import {readFileSync} from 'node:fs';
import {join} from 'node:path';
import {after, before, test} from 'node:test';
import {
  assertFails,
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

test('guests cannot read or write Firestore', async () => {
  const document = environment.unauthenticatedContext()
    .firestore().doc('users/guest');
  await assertFails(document.get());
  await assertFails(document.set({displayName: 'Guest'}));
});

test('authenticated users cannot access arbitrary documents before a schema exists', async () => {
  for (const uid of ['first-user', 'second-user']) {
    const document = environment.authenticatedContext(uid)
      .firestore().doc('users/other-user');
    await assertFails(document.get());
    await assertFails(document.set({displayName: 'Other'}));
  }
});
