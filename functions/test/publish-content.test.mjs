import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {test} from 'node:test';
import {publishArtifact, verifyArtifact} from '../lib/publish-content.js';

function artifact(puzzle = {id: 'p1', board: '0'.repeat(81), difficulty: 'easy',
  requiredTechniques: ['nakedSingle'], dailyEligible: true}) {
  const payload = {schemaVersion: 1, releaseId: 'v1', contentVersion: 1, puzzles: [puzzle]};
  return {...payload, sha256: createHash('sha256').update(JSON.stringify(payload)).digest('hex')};
}

function fakeDb() {
  const records = new Map();
  const ref = (name, id) => ({
    key: `${name}/${id}`,
    async get() { const data = records.get(this.key); return {exists: !!data, get: (field) => data?.[field]}; },
    async create(data) { if (records.has(this.key)) throw Error('already exists'); records.set(this.key, data); },
  });
  return {
    records,
    collection(name) {return {doc(id) {return ref(name, id);}};},
    batch() {
      const pending = [];
      return {create(reference, data) {pending.push([reference, data]);},
        async commit() {for (const [reference, data] of pending) await reference.create(data);}};
    },
  };
}

test('validated artifact schema and checksum reject tampering and duplicate IDs', () => {
  assert.equal(verifyArtifact(artifact()).puzzles.length, 1);
  assert.throws(() => verifyArtifact({...artifact(), sha256: '0'.repeat(64)}), /checksum/);
  const duplicate = artifact();
  duplicate.puzzles.push(duplicate.puzzles[0]);
  assert.throws(() => verifyArtifact(duplicate), /schema/);
  assert.throws(() => verifyArtifact({schemaVersion: 99}), /schema/);
});

test('dry run writes nothing, apply is idempotent, changed ID aborts', async () => {
  const db = fakeDb();
  const first = artifact();
  assert.deepEqual(await publishArtifact(db, first, false),
    {created: 1, alreadyIdentical: 0});
  assert.equal(db.records.size, 0);
  assert.deepEqual(await publishArtifact(db, first, true),
    {created: 1, alreadyIdentical: 0});
  assert.equal(db.records.size, 2);
  assert.deepEqual(await publishArtifact(db, first, true),
    {created: 0, alreadyIdentical: 1});
  const changed = artifact({...first.puzzles[0], board: '1'.repeat(81)});
  await assert.rejects(publishArtifact(db, changed, true), /Immutable release ID conflict/);
  assert.equal(db.records.size, 2);
});

test('published puzzle ID conflict is rejected before any writes', async () => {
  const db = fakeDb();
  const first = artifact();
  await publishArtifact(db, first, true);
  const changed = artifact({...first.puzzles[0], board: '1'.repeat(81)});
  changed.releaseId = 'v2';
  changed.sha256 = createHash('sha256').update(JSON.stringify({
    schemaVersion: changed.schemaVersion, releaseId: changed.releaseId,
    contentVersion: changed.contentVersion, puzzles: changed.puzzles,
  })).digest('hex');
  await assert.rejects(publishArtifact(db, changed, true), /Immutable puzzle conflict/);
  assert.equal(db.records.size, 2);
});
