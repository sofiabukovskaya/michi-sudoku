import {FieldValue, getFirestore, Timestamp, type DocumentReference, type Firestore} from 'firebase-admin/firestore';
import {getMessaging, type Messaging} from 'firebase-admin/messaging';
import {getRemoteConfig} from 'firebase-admin/remote-config';
import {logger} from 'firebase-functions';
import {onSchedule} from 'firebase-functions/v2/scheduler';

type CalendarParts = {year: number; month: number; day: number; hour: number; minute: number};

export function localParts(date: Date, timezone: string): CalendarParts {
  const parts = new Intl.DateTimeFormat('en-US', {timeZone: timezone, hourCycle: 'h23',
    year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'}).formatToParts(date);
  const value = (name: string): number => Number(parts.find((part) => part.type === name)?.value);
  return {year: value('year'), month: value('month'), day: value('day'),
    hour: value('hour'), minute: value('minute')};
}

export function localDateKey(date: Date, timezone: string): string {
  const parts = localParts(date, timezone);
  return `${parts.year}-${String(parts.month).padStart(2, '0')}-${String(parts.day).padStart(2, '0')}`;
}

/** Resolve 08:00 (or configured time) in an IANA zone, including DST changes. */
export function nextReminderAt(now: Date, timezone: string, hour: number, minute: number): Date {
  if (!Number.isInteger(hour) || hour < 0 || hour > 23 ||
      !Number.isInteger(minute) || minute < 0 || minute > 59) throw new Error('Invalid reminder time');
  const today = localParts(now, timezone);
  const tomorrow = (today.hour > hour || (today.hour === hour && today.minute >= minute));
  const targetDay = new Date(Date.UTC(today.year, today.month - 1, today.day + (tomorrow ? 1 : 0)));
  const target = Date.UTC(targetDay.getUTCFullYear(), targetDay.getUTCMonth(),
    targetDay.getUTCDate(), hour, minute);
  let guess = target;
  for (let i = 0; i < 5; i++) {
    const actual = localParts(new Date(guess), timezone);
    const localAsUtc = Date.UTC(actual.year, actual.month - 1, actual.day, actual.hour, actual.minute);
    const correction = target - localAsUtc;
    if (correction === 0) break;
    guess += correction;
  }
  return new Date(guess);
}

const COPY: Record<string, string> = {
  en: "Today's Sudoku is ready.",
  uk: 'Сьогоднішнє судоку вже чекає.',
  cs: 'Dnešní sudoku je připravené.',
  es: 'El sudoku de hoy está listo.',
  fr: "Le sudoku du jour est prêt.",
  de: 'Das heutige Sudoku ist bereit.',
};

export function reminderCopy(locale: string): string {
  return COPY[locale.split(/[-_]/)[0]] ?? COPY.en;
}

const LEASE_MS = 5 * 60 * 1000;

async function claim(db: Firestore, ref: DocumentReference, now: Date): Promise<null | {
  token: string; date: string; timezone: string; hour: number; minute: number; locale: string;
}> {
  return db.runTransaction(async (tx) => {
    const doc = await tx.get(ref);
    if (!doc.exists || doc.get('remindersEnabled') !== true ||
        !(doc.get('nextReminderAt') instanceof Timestamp) ||
        (doc.get('nextReminderAt') as Timestamp).toDate() > now ||
        (doc.get('leaseUntil') instanceof Timestamp &&
          (doc.get('leaseUntil') as Timestamp).toDate() > now)) return null;
    const timezone = doc.get('timezone') as string;
    const date = localDateKey(now, timezone);
    if (doc.get('lastReminderDate') === date) {
      tx.update(ref, {nextReminderAt: Timestamp.fromDate(
        nextReminderAt(new Date(now.getTime() + 60_000), timezone,
          doc.get('reminderHour') as number, doc.get('reminderMinute') as number))});
      return null;
    }
    const token = doc.get('fcmToken') as string;
    if (!token) {
      tx.update(ref, {remindersEnabled: false});
      return null;
    }
    // Mark before send: retries cannot send the same local date twice.
    tx.update(ref, {lastReminderDate: date,
      leaseUntil: Timestamp.fromMillis(now.getTime() + LEASE_MS),
      updatedAt: FieldValue.serverTimestamp()});
    return {token, date, timezone,
      hour: doc.get('reminderHour') as number,
      minute: doc.get('reminderMinute') as number,
      locale: doc.get('locale') as string};
  });
}

export async function sendDueReminders(db: Firestore, messaging: Messaging, now: Date): Promise<number> {
  let sent = 0;
  for (let page = 0; page < 10; page++) {
    const due = await db.collectionGroup('devices')
      .where('remindersEnabled', '==', true)
      .where('nextReminderAt', '<=', Timestamp.fromDate(now))
      .orderBy('nextReminderAt').limit(100).get();
    if (due.empty) break;
    let progressed = 0;
    for (const doc of due.docs) {
      let item: Awaited<ReturnType<typeof claim>>;
      try { item = await claim(db, doc.ref, now); }
      catch { continue; }
      if (item === null) continue;
      progressed++;
      try {
        await messaging.send({token: item.token,
          notification: {title: 'MICHI', body: reminderCopy(item.locale)},
          data: {type: 'dailyReminder', date: item.date},
          android: {notification: {channelId: 'michi_daily'}},
          apns: {payload: {aps: {sound: 'default'}}},
        });
        sent++;
        await doc.ref.update({leaseUntil: FieldValue.delete(),
          nextReminderAt: Timestamp.fromDate(nextReminderAt(
            new Date(now.getTime() + 60_000), item.timezone, item.hour, item.minute)),
          updatedAt: FieldValue.serverTimestamp()});
      } catch (error) {
        const code = (error as {code?: string}).code;
        logger.warn('Daily reminder send failed', {function: 'sendDueDailyReminders',
          category: code ?? 'unknown'});
        if (code === 'messaging/registration-token-not-registered' ||
            code === 'messaging/invalid-registration-token') {
          await doc.ref.delete();
        } else {
          // A failed send can retry after the lease, on the same date.
          await doc.ref.update({lastReminderDate: FieldValue.delete(),
            leaseUntil: Timestamp.fromMillis(now.getTime() + LEASE_MS),
            updatedAt: FieldValue.serverTimestamp()});
        }
      }
    }
    if (due.size < 100 || progressed === 0) break;
  }
  return sent;
}

export const sendDueDailyReminders = onSchedule(
  {schedule: 'every 15 minutes', timeZone: 'Etc/UTC',
    region: 'europe-west1', timeoutSeconds: 540},
  async () => {
    const started = Date.now();
    try {
      const template = await getRemoteConfig().getTemplate();
      const defaultValue = template.parameters.notificationsEnabled?.defaultValue;
      if (defaultValue && 'value' in defaultValue && defaultValue.value === 'false') {
        logger.info('Daily reminders disabled by Remote Config',
          {function: 'sendDueDailyReminders'});
        return;
      }
    } catch {
      // Remote Config API may be unavailable in a new project. Safe local
      // default is enabled, while the client still requires explicit opt-in.
      logger.warn('Remote Config unavailable for reminders',
        {function: 'sendDueDailyReminders', category: 'configUnavailable'});
    }
    const sent = await sendDueReminders(getFirestore(), getMessaging(), new Date());
    logger.info('Due Daily reminders processed',
      {function: 'sendDueDailyReminders', sent, durationMs: Date.now() - started});
  },
);
