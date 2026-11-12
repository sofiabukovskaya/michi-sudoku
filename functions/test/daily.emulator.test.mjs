import assert from 'node:assert/strict';
import {after, before, test} from 'node:test';
import {initializeApp, deleteApp} from 'firebase-admin/app';
import {getFirestore} from 'firebase-admin/firestore';
import {publishDailyHorizon} from '../lib/daily.js';

let app;
let db;
before(async () => {
  app = initializeApp({projectId: 'demo-michi-daily-tests'}, 'daily-tests');
  db = getFirestore(app);
  const batch = db.batch();
  for (let i = 0; i < 32; i++) {
    batch.set(db.collection('puzzles').doc(`eligible-${i}`),
      {status: 'published', dailyEligible: true});
  }
  batch.set(db.collection('puzzles').doc('not-eligible'),
    {status: 'published', dailyEligible: false});
  batch.set(db.collection('puzzles').doc('draft'),
    {status: 'draft', dailyEligible: true});
  batch.set(db.collection('contentReleases').doc('v1'),
    {status: 'published', publishedAt: new Date('2026-11-10T00:00:00Z'),
      puzzleIds: [...Array.from({length: 32}, (_, i) => `eligible-${i}`),
        'not-eligible', 'draft']});
  await batch.commit();
});
after(async () => {await deleteApp(app);});

test('publisher fills future horizon with eligible puzzles and never rewrites a date', async () => {
  const first = await publishDailyHorizon(db, '2026-11-11', 14);
  assert.deepEqual(first, {created: 15, existing: 0});
  const rows = await db.collection('dailyChallenges').get();
  assert.equal(rows.size, 15);
  const ids = rows.docs.map((doc) => doc.get('puzzleId'));
  assert.equal(new Set(ids).size, 15);
  assert.ok(ids.every((id) => id.startsWith('eligible-')));
  const today = await db.collection('dailyChallenges').doc('2026-11-11').get();
  const second = await publishDailyHorizon(db, '2026-11-11', 14);
  assert.deepEqual(second, {created: 0, existing: 15});
  const unchanged = await db.collection('dailyChallenges').doc('2026-11-11').get();
  assert.equal(unchanged.get('puzzleId'), today.get('puzzleId'));
  assert.equal(unchanged.get('publishedAt').toMillis(), today.get('publishedAt').toMillis());
});

test('overlapping schedulers create a missing date once', async () => {
  const results = await Promise.all([
    publishDailyHorizon(db, '2026-12-20', 0),
    publishDailyHorizon(db, '2026-12-20', 0),
  ]);
  assert.equal(results.reduce((sum, item) => sum + item.created, 0), 1);
  assert.equal((await db.collection('dailyChallenges').doc('2026-12-20').get()).exists, true);
});
