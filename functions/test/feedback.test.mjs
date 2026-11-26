import assert from 'node:assert/strict';
import {test} from 'node:test';
import {validateFeedback} from '../lib/feedback.js';

const valid = {
  installationId: 'b'.repeat(32), category: 'scanner', message: '  Long enough feedback.  ',
  replyEmail: ' reply@example.test ', details: {platform: 'ios', signedIn: false},
};

test('validates and trims category, note and optional email', () => {
  assert.deepEqual(validateFeedback(valid), {
    ...valid, message: 'Long enough feedback.', replyEmail: 'reply@example.test',
  });
  assert.equal(validateFeedback({...valid, message: '😀'.repeat(10)}).message, '😀'.repeat(10));
  assert.equal(validateFeedback({...valid, replyEmail: undefined}).replyEmail, undefined);
});

test('rejects invalid fields, unknown details, and oversized UTF-8 payloads', () => {
  for (const overrides of [
    {category: 'unknown'}, {message: ' short '}, {message: 'a'.repeat(2001)},
    {installationId: 'guess'}, {replyEmail: 'invalid'}, {replyEmail: 'a@b.test\r\nBcc: t@b.test'},
    {details: {image: 'bytes'}}, {details: {signedIn: 'yes'}},
    {details: {platform: 'ios\nHeader: bad'}}, {details: []},
    {uid: 'supplied-by-client'}, {message: '😀'.repeat(2000), details: {deviceModel: 'x'.repeat(200)}},
  ]) {
    assert.throws(() => validateFeedback({...valid, ...overrides}), {code: 'invalid-argument'});
  }
});
