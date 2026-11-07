import {after, test} from 'node:test';
import {initializeApp, deleteApp} from 'firebase/app';
import {
  connectAuthEmulator,
  createUserWithEmailAndPassword,
  getAuth,
  signInWithEmailAndPassword,
  signOut,
} from 'firebase/auth';

const app = initializeApp({
  apiKey: 'demo-key',
  projectId: 'demo-michi',
}, 'michi-emulator-test');
const auth = getAuth(app);
connectAuthEmulator(auth, 'http://127.0.0.1:9099', {disableWarnings: true});

after(async () => {
  await signOut(auth);
  await deleteApp(app);
});

test('email registration, sign-out and sign-in work in the emulator', async () => {
  const email = `player-${Date.now()}@example.test`;
  const password = 'test-password-123';
  const created = await createUserWithEmailAndPassword(auth, email, password);
  const uid = created.user.uid;
  await signOut(auth);
  const restored = await signInWithEmailAndPassword(auth, email, password);
  if (restored.user.uid !== uid) {
    throw new Error('Firebase UID changed across sign-in');
  }
});
