import assert from 'node:assert/strict';
import {test} from 'node:test';
import {localDateKey, nextReminderAt, reminderCopy} from '../lib/reminders.js';

test('08:00 follows Prague daylight-saving changes', () => {
  assert.equal(nextReminderAt(new Date('2026-03-28T06:00:00Z'), 'Europe/Prague', 8, 0)
    .toISOString(), '2026-03-28T07:00:00.000Z');
  assert.equal(nextReminderAt(new Date('2026-03-29T05:00:00Z'), 'Europe/Prague', 8, 0)
    .toISOString(), '2026-03-29T06:00:00.000Z');
  assert.equal(nextReminderAt(new Date('2026-10-25T05:00:00Z'), 'Europe/Prague', 8, 0)
    .toISOString(), '2026-10-25T07:00:00.000Z');
});

test('reminders use each device local calendar date and next occurrence', () => {
  const now = new Date('2026-11-10T23:30:00Z');
  assert.equal(localDateKey(now, 'Europe/Prague'), '2026-11-11');
  assert.equal(localDateKey(now, 'America/New_York'), '2026-11-10');
  assert.equal(nextReminderAt(now, 'Europe/Prague', 8, 0)
    .toISOString(), '2026-11-11T07:00:00.000Z');
});

test('localized copy falls back safely', () => {
  assert.equal(reminderCopy('fr-FR'), 'Le sudoku du jour est prêt.');
  assert.equal(reminderCopy('xx-YY'), "Today's Sudoku is ready.");
});
