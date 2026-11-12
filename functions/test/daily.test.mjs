import assert from 'node:assert/strict';
import {test} from 'node:test';
import {addUtcDays, selectDailyPuzzle} from '../lib/daily.js';

const pool = Array.from({length: 35}, (_, index) => `p${String(index).padStart(2, '0')}`);

test('Daily selection is deterministic and independent of input order', () => {
  const a = selectDailyPuzzle('2026-11-11', 'release-v3', pool, []);
  const b = selectDailyPuzzle('2026-11-11', 'release-v3', [...pool].reverse(), []);
  assert.equal(a, b);
  assert.ok(pool.includes(a));
});

test('recent puzzle IDs are excluded when another option exists', () => {
  const selected = selectDailyPuzzle('2026-11-11', 'release-v3', ['c', 'a', 'b'], ['a', 'b']);
  assert.equal(selected, 'c');
});

test('exhausted pool falls back deterministically without throwing', () => {
  const first = selectDailyPuzzle('2026-11-11', 'release-v3', ['b', 'a'], ['a', 'b']);
  assert.equal(first, selectDailyPuzzle('2026-11-11', 'release-v3', ['a', 'b'], ['b', 'a']));
});

test('UTC calendar arithmetic handles month and leap-day boundaries', () => {
  assert.equal(addUtcDays('2024-02-28', 1), '2024-02-29');
  assert.equal(addUtcDays('2024-02-29', 1), '2024-03-01');
});
