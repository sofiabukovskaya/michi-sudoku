import assert from 'node:assert/strict';
import {after, before, test} from 'node:test';
import {initializeApp, deleteApp} from 'firebase-admin/app';
import {getFirestore, Timestamp} from 'firebase-admin/firestore';
import {sendDueReminders} from '../lib/reminders.js';

let app;
let db;
const now = new Date('2026-11-11T07:00:00Z');
const device = (token, due = now, enabled = true) => ({
  schemaVersion: 1, deviceId: token, fcmToken: token, platform: 'android',
  locale: 'cs', timezone: 'Europe/Prague', remindersEnabled: enabled,
  reminderHour: 8, reminderMinute: 0,
  nextReminderAt: Timestamp.fromDate(due), updatedAt: Timestamp.fromDate(now),
});

before(async () => {
  app = initializeApp({projectId: 'demo-michi-reminder-tests'}, 'reminder-tests');
  db = getFirestore(app);
  await db.doc('users/alice/devices/due').set(device('due'));
  await db.doc('users/alice/devices/later').set(device('later', new Date('2026-11-11T09:00:00Z')));
  await db.doc('users/alice/devices/disabled').set(device('disabled', now, false));
});
after(async () => {await deleteApp(app);});

test('only due enabled device gets one reminder for local date', async () => {
  const sent = [];
  const messaging = {async send(message) {sent.push(message); return 'message-id';}};
  assert.equal(await sendDueReminders(db, messaging, now), 1);
  assert.deepEqual(sent.map((item) => item.token), ['due']);
  assert.deepEqual(sent[0].data, {type: 'dailyReminder', date: '2026-11-11'});
  assert.equal(await sendDueReminders(db, messaging, now), 0);
  assert.equal(sent.length, 1);
  const row = await db.doc('users/alice/devices/due').get();
  assert.equal(row.get('lastReminderDate'), '2026-11-11');
  assert.equal(row.get('nextReminderAt').toDate().toISOString(),
    '2026-11-12T07:00:00.000Z');
});

test('invalid token is deleted and transient failures can retry after lease', async () => {
  await db.doc('users/alice/devices/invalid').set(device('invalid'));
  await db.doc('users/alice/devices/retry').set(device('retry'));
  const messaging = {async send(message) {
    if (message.token === 'invalid') throw {code: 'messaging/registration-token-not-registered'};
    if (message.token === 'retry') throw {code: 'messaging/internal-error'};
    return 'ok';
  }};
  await sendDueReminders(db, messaging, now);
  assert.equal((await db.doc('users/alice/devices/invalid').get()).exists, false);
  const retry = await db.doc('users/alice/devices/retry').get();
  assert.equal(retry.get('lastReminderDate'), undefined);
  let tries = 0;
  const successful = {async send(message) {if (message.token === 'retry') tries++; return 'ok';}};
  await sendDueReminders(db, successful, new Date('2026-11-11T07:06:00Z'));
  assert.equal(tries, 1);
});
