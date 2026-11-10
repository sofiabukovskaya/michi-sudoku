import {readFileSync} from 'node:fs';
import assert from 'node:assert/strict';
import {join} from 'node:path';
import {after, before, test} from 'node:test';
import {
  assertFails,
  assertSucceeds,
  initializeTestEnvironment,
} from '@firebase/rules-unit-testing';

let environment;

before(async () => {
  environment = await initializeTestEnvironment({
    projectId: 'demo-michi',
    firestore: {
      rules: readFileSync(join(process.cwd(), '..', 'firestore.rules'), 'utf8'),
    },
  });
});

after(async () => environment?.cleanup());

const completed = () => ({
  schemaVersion: 1,
  puzzleId: 'puzzle-1',
  dailyChallengeKey: null,
  initialBoard: '0'.repeat(81),
  completedBoard: '1'.repeat(81),
  startedAtMs: 1,
  completedAtMs: 2,
  elapsedMs: 1,
  mistakes: 0,
  hintsRequested: 0,
  highestHintLevelUsed: 0,
  techniqueHelpJson: '{}',
  createdAt: new Date(),
  updatedAt: new Date(),
});

const contribution = () => ({
  schemaVersion: 1,
  attempts: 2,
  correctAttempts: 1,
  firstTryCorrect: 1,
  independentStreak: 1,
  bestIndependentStreak: 1,
  directionHintSuccesses: 0,
  focusHintSuccesses: 0,
  reasoningHintSuccesses: 0,
  resultHintSuccesses: 0,
  lastPracticedAtMs: 2,
  updatedAt: new Date(),
});

test('unauthenticated users cannot read or write progress', async () => {
  const db = environment.unauthenticatedContext().firestore();
  const game = db.doc('users/alice/completedGames/game-1');
  await assertFails(game.get());
  await assertFails(game.set(completed()));
});

test('owner can create and read a valid completed game; another UID cannot', async () => {
  const alice = environment.authenticatedContext('alice').firestore();
  const bob = environment.authenticatedContext('bob').firestore();
  const path = 'users/alice/completedGames/game-1';
  await assertSucceeds(alice.doc(path).set(completed()));
  await assertSucceeds(alice.doc(path).get());
  await assertFails(bob.doc(path).get());
  await assertFails(bob.doc('users/alice/completedGames/other').set(completed()));
  await assertFails(alice.doc(path).delete());
});

test('schema changes, extra fields and invalid values are rejected', async () => {
  const db = environment.authenticatedContext('alice').firestore();
  await assertFails(db.doc('users/alice/completedGames/bad-version')
    .set({...completed(), schemaVersion: 99}));
  await assertFails(db.doc('users/alice/completedGames/bad-board')
    .set({...completed(), initialBoard: '123'}));
  await assertFails(db.doc('users/alice/completedGames/extra')
    .set({...completed(), isAdmin: true}));
  await assertFails(db.doc('users/alice').set({isAdmin: true}));
  await assertFails(db.doc('users/alice/settings/main').set({language: 'en'}));
});

test('Daily completion is owner-only and append-only', async () => {
  const alice = environment.authenticatedContext('alice').firestore();
  const bob = environment.authenticatedContext('bob').firestore();
  const path = 'users/alice/daily/2026-11-01|v1';
  const data = {
    schemaVersion: 1,
    puzzleId: 'puzzle-1',
    gameId: 'game-1',
    completedAtMs: 2,
    createdAt: new Date(),
    updatedAt: new Date(),
  };
  await assertSucceeds(alice.doc(path).set(data));
  await assertFails(bob.doc(path).get());
  await assertFails(alice.doc(path).update({completedAtMs: 3}));
});

test('per-device technique contributions require owner and valid ID', async () => {
  const alice = environment.authenticatedContext('alice').firestore();
  const bob = environment.authenticatedContext('bob').firestore();
  const path = 'users/alice/techniqueProgress/nakedSingle/devices/device-1';
  await assertSucceeds(alice.doc(path).set(contribution()));
  await assertSucceeds(alice.doc(path).get());
  await assertFails(bob.doc(path).get());
  await assertFails(bob.doc(path).set(contribution()));
  await assertFails(alice.doc('users/alice/techniqueProgress/fake/devices/device-1')
    .set(contribution()));
  await assertFails(alice.doc('users/alice/techniqueProgress/nakedSingle/devices/extra')
    .set({...contribution(), protected: true}));
  await assertFails(alice.doc(path).delete());
});

test('two authenticated clients retain distinct offline contributions', async () => {
  const first = environment.authenticatedContext('same-user').firestore();
  const second = environment.authenticatedContext('same-user').firestore();
  const base = 'users/same-user/techniqueProgress/hiddenSingle/devices';
  await assertSucceeds(first.doc(`${base}/device-a`).set(contribution()));
  await assertSucceeds(second.doc(`${base}/device-b`).set({
    ...contribution(), attempts: 3, correctAttempts: 2,
  }));
  const snapshot = await assertSucceeds(second.collection(base).get());
  assert.equal(snapshot.docs.length, 2);
  assert.equal(snapshot.docs.reduce((sum, doc) => sum + doc.data().attempts, 0), 5);
});
