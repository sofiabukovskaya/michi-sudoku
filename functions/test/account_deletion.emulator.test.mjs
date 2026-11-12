import {test} from 'node:test';
import assert from 'node:assert/strict';
import {initializeApp} from 'firebase-admin/app';
import {getAuth} from 'firebase-admin/auth';
import {getFirestore} from 'firebase-admin/firestore';

test('deleting an Auth user recursively removes nested Firestore data', async () => {
  assert.ok(process.env.FIREBASE_AUTH_EMULATOR_HOST);
  assert.ok(process.env.FIRESTORE_EMULATOR_HOST);
  const app = initializeApp({projectId: 'demo-michi'}, 'deletion-test');
  const uid = `deleted-${Date.now()}`;
  const auth = getAuth(app);
  const db = getFirestore(app);
  await auth.createUser({uid, email: `${uid}@example.test`});
  const user = db.collection('users').doc(uid);
  await user.collection('completedGames').doc('game').set({schemaVersion: 1});
  await user.collection('techniqueProgress').doc('nakedSingle')
    .collection('devices').doc('device').set({attempts: 1});
  await user.collection('daily').doc('day').set({completed: true});
  await auth.deleteUser(uid);
  let cleared = false;
  for (let attempt = 0; attempt < 40; attempt++) {
    const [game, device, daily] = await Promise.all([
      user.collection('completedGames').doc('game').get(),
      user.collection('techniqueProgress').doc('nakedSingle')
        .collection('devices').doc('device').get(),
      user.collection('daily').doc('day').get(),
    ]);
    if (!game.exists && !device.exists && !daily.exists) {
      cleared = true;
      break;
    }
    await new Promise((resolve) => setTimeout(resolve, 250));
  }
  assert.equal(cleared, true);
  await app.delete();
});
