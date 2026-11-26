import {createHash} from 'node:crypto';
import {createRequire} from 'node:module';
import {getFirestore, Timestamp, type Firestore} from 'firebase-admin/firestore';
import {defineSecret} from 'firebase-functions/params';
import {HttpsError, onCall} from 'firebase-functions/v2/https';

const feedbackTo = defineSecret('FEEDBACK_TO');
const smtpHost = defineSecret('FEEDBACK_SMTP_HOST');
const smtpUser = defineSecret('FEEDBACK_SMTP_USER');
const smtpPass = defineSecret('FEEDBACK_SMTP_PASS');

const categories = ['idea', 'broken', 'scanner', 'learning', 'other'] as const;
const detailKeys = [
  'appVersion', 'build', 'platform', 'osVersion', 'deviceModel', 'language', 'signedIn',
] as const;
const day = 24 * 60 * 60 * 1000;

type Category = typeof categories[number];
type Details = Partial<Record<typeof detailKeys[number], string | boolean>>;
type Submission = {
  category: Category;
  message: string;
  installationId: string;
  replyEmail?: string;
  details?: Details;
};
type Note = Omit<Submission, 'installationId'>;
type Notify = (id: string, note: Note) => Promise<unknown>;

function invalid(): never {
  throw new HttpsError('invalid-argument', 'Invalid feedback.');
}

function object(value: unknown): Record<string, unknown> {
  if (value === null || typeof value !== 'object' || Array.isArray(value)) {
    return invalid();
  }
  return value as Record<string, unknown>;
}

export function validateFeedback(input: unknown): Submission {
  const data = object(input);
  if (Buffer.byteLength(JSON.stringify(data)) >= 8192 ||
      Object.keys(data).some((key) => ![
        'category', 'message', 'installationId', 'replyEmail', 'details',
      ].includes(key))) return invalid();
  const {category, message, installationId, replyEmail, details} = data;
  if (typeof category !== 'string' || !categories.includes(category as Category) ||
      typeof message !== 'string' || typeof installationId !== 'string' ||
      !/^[0-9a-f]{32}$/i.test(installationId)) return invalid();
  const trimmed = message.trim();
  const length = [...trimmed].length;
  if (length < 10 || length > 2000) return invalid();
  const note: Submission = {
    category: category as Category, message: trimmed,
    installationId: installationId.toLowerCase(),
  };
  if (replyEmail !== undefined) {
    if (typeof replyEmail !== 'string') return invalid();
    const email = replyEmail.trim();
    if (email.length > 254 || !/^[^\s@<>(),;:"\\]+@[^\s@<>(),;:"\\]+\.[^\s@<>(),;:"\\]+$/.test(email)) {
      return invalid();
    }
    note.replyEmail = email;
  }
  if (details !== undefined) {
    const fields = object(details);
    for (const [key, value] of Object.entries(fields)) {
      if (!detailKeys.includes(key as typeof detailKeys[number])) return invalid();
      if (key === 'signedIn') {
        if (typeof value !== 'boolean') return invalid();
      } else if (typeof value !== 'string' || value.length < 1 ||
          value.length > 200 || /[\x00-\x1f\x7f]/u.test(value)) {
        return invalid();
      }
      if (key === 'platform' && value !== 'ios' && value !== 'android') return invalid();
    }
    note.details = fields as Details;
  }
  return note;
}

export async function saveFeedback(
  db: Firestore, input: unknown, uid: string | undefined,
  notify: Notify, now = Date.now(),
): Promise<{id: string}> {
  const {installationId, ...note} = validateFeedback(input);
  const keys = [`installation:${installationId}`, ...(uid ? [`uid:${uid}`] : [])];
  const refs = keys.map((key) => db.collection('feedbackLimits')
    .doc(createHash('sha256').update(key).digest('hex')));
  const doc = db.collection('feedback').doc();
  const expires = new Date(now);
  expires.setUTCMonth(expires.getUTCMonth() + 24);
  await db.runTransaction(async (tx) => {
    const snapshots = await tx.getAll(...refs);
    const windows = snapshots.map((snapshot) => {
      const recorded = (snapshot.get('submittedAt') ?? []) as number[];
      const recent = recorded.filter((time) => time > now - day);
      if (recent.length >= 5 || recent.some((time) => time > now - 30_000)) {
        throw new HttpsError('resource-exhausted', 'Feedback limit reached.');
      }
      return [...recent, now];
    });
    for (const [i, ref] of refs.entries()) {
      tx.set(ref, {submittedAt: windows[i], expiresAt: Timestamp.fromMillis(now + day)});
    }
    tx.create(doc, {
      ...note, ...(uid ? {uid} : {}),
      createdAt: Timestamp.fromMillis(now), expiresAt: Timestamp.fromDate(expires),
      status: 'saved',
    });
  });

  let status = 'emailed';
  try {
    await notify(doc.id, note);
  } catch {
    status = 'emailFailed';
  }
  // A secondary status write must not ask the player to submit a saved note again.
  await doc.update({status}).catch(() => undefined);
  return {id: doc.id};
}

type Mail = {from: string; to: string; subject: string; text: string; replyTo?: string};
type Smtp = {
  createTransport(options: {
    host: string; port: number; secure: boolean; requireTLS: boolean;
    auth: {user: string; pass: string}; connectionTimeout: number;
    greetingTimeout: number; socketTimeout: number;
  }): {sendMail(mail: Mail): Promise<unknown>};
};
const loadModule = createRequire(__filename);

async function mailOwner(id: string, note: Note): Promise<void> {
  const mailer = loadModule('nodemailer') as Smtp;
  const user = smtpUser.value();
  const transport = mailer.createTransport({
    host: smtpHost.value(), port: 587, secure: false, requireTLS: true,
    auth: {user, pass: smtpPass.value()},
    connectionTimeout: 5000, greetingTimeout: 5000, socketTimeout: 8000,
  });
  const {platform = 'unknown', appVersion = 'unknown'} = note.details ?? {};
  const details = Object.entries(note.details ?? {}).map(([key, value]) => `${key}: ${value}`);
  await transport.sendMail({
    from: user, to: feedbackTo.value(),
    subject: `[MICHI feedback] ${note.category} · ${platform} ${appVersion}`,
    text: [note.message, '', ...details, '', `Feedback ID: ${id}`].join('\n'),
    ...(note.replyEmail ? {replyTo: note.replyEmail} : {}),
  });
}

export const submitFeedback = onCall({
  region: 'europe-west1',
  enforceAppCheck: true,
  secrets: [feedbackTo, smtpHost, smtpUser, smtpPass],
}, (request) => saveFeedback(getFirestore(), request.data, request.auth?.uid, mailOwner));
