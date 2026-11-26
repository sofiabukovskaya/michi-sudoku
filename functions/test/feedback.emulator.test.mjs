import assert from 'node:assert/strict';
import {after, before, test} from 'node:test';
import {randomBytes} from 'node:crypto';
import {initializeApp, deleteApp} from 'firebase-admin/app';
import {getFirestore} from 'firebase-admin/firestore';
import {saveFeedback} from '../lib/feedback.js';

const id = () => randomBytes(16).toString('hex');
const note = (installationId = id()) => ({
  installationId, category: 'scanner', message: 'The scanner found the wrong digit.',
});
const noMail = async () => {};
const now = Date.UTC(2026, 10, 26);
let app;
let db;

before(() => {
  assert.ok(process.env.FIRESTORE_EMULATOR_HOST, 'Run this suite against the Firestore emulator.');
  app = initializeApp({projectId: 'demo-michi-feedback-tests'}, 'feedback-tests');
  db = getFirestore(app);
});
after(async () => {if (app) await deleteApp(app);});

test('stores guest and signed-in feedback; SMTP failures keep a successful submission', async () => {
  const email = 'reply@example.test';
  const messages = [];
  const guest = await saveFeedback(db, {...note(), replyEmail: email}, undefined,
    async (id, data) => messages.push({id, data}), now);
  const dbGuest = (await db.collection('feedback').doc(guest.id).get()).data();
  assert.equal(dbGuest.status, 'emailed');
  assert.equal(dbGuest.replyEmail, email);
  assert.equal(dbGuest.uid, undefined);
  assert.equal(dbGuest.installationId, undefined);
  assert.equal(messages[0].id, guest.id);
  assert.equal(messages[0].data.replyEmail, email);
  assert.equal(dbGuest.expiresAt.toDate().getUTCFullYear(), 2028);

  const signed = await saveFeedback(db, note(), 'signed-in-uid', async () => {
    throw new Error('Mock SMTP unavailable');
  }, now);
  const saved = (await db.collection('feedback').doc(signed.id).get()).data();
  assert.equal(saved.uid, 'signed-in-uid');
  assert.equal(saved.status, 'emailFailed');
});

test('checks both identity limits atomically and rolls the 24-hour window', async () => {
  const installationId = id();
  const uid = id();
  await saveFeedback(db, note(installationId), uid, noMail, now);
  await assert.rejects(saveFeedback(db, note(installationId), id(), noMail, now + 29_999),
    {code: 'resource-exhausted'});
  await assert.rejects(saveFeedback(db, note(), uid, noMail, now + 29_999),
    {code: 'resource-exhausted'});
  for (let i = 1; i < 5; i++) {
    await saveFeedback(db, note(installationId), uid, noMail, now + i * 30_000);
  }
  await assert.rejects(saveFeedback(db, note(installationId), id(), noMail, now + 200_000),
    {code: 'resource-exhausted'});
  await assert.rejects(saveFeedback(db, note(), uid, noMail, now + 200_000),
    {code: 'resource-exhausted'});
  await saveFeedback(db, note(installationId), uid, noMail, now + 86_400_000);
});

test('concurrent submissions permit at most one success', async () => {
  const payload = note();
  const outcomes = await Promise.allSettled([
    saveFeedback(db, payload, undefined, noMail, now),
    saveFeedback(db, payload, undefined, noMail, now),
  ]);
  assert.equal(outcomes.filter(({status}) => status === 'fulfilled').length, 1);
  assert.equal(outcomes.find(({status}) => status === 'rejected').reason.code, 'resource-exhausted');
});

test('callable rejects a request without App Check before writing feedback', async (t) => {
  const hub = process.env.FIREBASE_EMULATOR_HUB;
  if (!hub) return t.skip('Start the Functions emulator to run the callable check.');
  const emulators = await (await fetch(`http://${hub}/emulators`)).json();
  if (!emulators.functions) return t.skip('Functions emulator is not running.');
  const {host, port} = emulators.functions;
  const response = await fetch(`http://${host}:${port}/demo-michi/europe-west1/submitFeedback`, {
    method: 'POST', headers: {'Content-Type': 'application/json'},
    body: JSON.stringify({data: note()}),
  });
  assert.equal(response.status, 401, await response.text());
});
