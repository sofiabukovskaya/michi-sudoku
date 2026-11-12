import {readFileSync} from 'node:fs';
import assert from 'node:assert/strict';
import {join} from 'node:path';
import {after, before, test} from 'node:test';
import {assertFails, assertSucceeds, initializeTestEnvironment} from '@firebase/rules-unit-testing';

let environment;

before(async () => {
  environment = await initializeTestEnvironment({projectId: 'demo-michi-content',
    firestore: {rules: readFileSync(join(process.cwd(), '..', 'firestore.rules'), 'utf8')}});
  await environment.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();
    await db.doc('puzzles/published').set({status: 'published', board: '0'.repeat(81)});
    await db.doc('puzzles/draft').set({status: 'draft', board: '0'.repeat(81)});
    await db.doc('contentReleases/v1').set({status: 'published', puzzleIds: ['published']});
    await db.doc('contentReleases/draft').set({status: 'draft'});
    await db.doc('dailyChallenges/2026-11-11').set({status: 'published', puzzleId: 'published'});
  });
});

after(async () => environment?.cleanup());

test('guests can read published shared content but not drafts', async () => {
  const guest = environment.unauthenticatedContext().firestore();
  await assertSucceeds(guest.doc('puzzles/published').get());
  await assertSucceeds(guest.doc('contentReleases/v1').get());
  await assertSucceeds(guest.doc('dailyChallenges/2026-11-11').get());
  await assertFails(guest.doc('puzzles/draft').get());
  await assertFails(guest.doc('contentReleases/draft').get());
  const listed = await assertSucceeds(guest.collection('puzzles')
    .where('status', '==', 'published').get());
  assert.deepEqual(listed.docs.map((doc) => doc.id), ['published']);
  await assertFails(guest.collection('puzzles').get());
});

test('neither guests nor signed-in clients can publish content or Daily', async () => {
  for (const db of [environment.unauthenticatedContext().firestore(),
    environment.authenticatedContext('alice').firestore()]) {
    await assertFails(db.doc('puzzles/evil').set({status: 'published'}));
    await assertFails(db.doc('contentReleases/evil').set({status: 'published'}));
    await assertFails(db.doc('dailyChallenges/2026-11-12').set({status: 'published'}));
    await assertFails(db.doc('puzzles/published').delete());
  }
});

const device = () => ({schemaVersion: 1, deviceId: 'install-1', fcmToken: 'token-1',
  platform: 'ios', locale: 'en', timezone: 'Europe/Prague',
  remindersEnabled: true, reminderHour: 8, reminderMinute: 0,
  nextReminderAt: new Date('2026-11-11T07:00:00Z'), updatedAt: new Date()});

test('device registration is owner-only and server delivery fields are protected', async () => {
  const alice = environment.authenticatedContext('alice').firestore();
  const bob = environment.authenticatedContext('bob').firestore();
  const ref = alice.doc('users/alice/devices/install-1');
  await assertSucceeds(ref.set(device()));
  await assertSucceeds(ref.get());
  await assertFails(bob.doc(ref.path).get());
  await assertFails(bob.doc(ref.path).set(device()));
  await assertFails(alice.doc('users/alice/devices/install-2')
    .set({...device(), deviceId: 'install-1'}));
  await assertFails(ref.update({lastReminderDate: '2026-11-11'}));
  await assertSucceeds(ref.update({fcmToken: 'rotated', updatedAt: new Date()}));
  await assertSucceeds(ref.delete());
});
