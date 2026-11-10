import {initializeApp} from 'firebase-admin/app';
import {getFirestore, type Firestore} from 'firebase-admin/firestore';
import * as functions from 'firebase-functions/v1';

initializeApp();

/** Includes nested device contributions even when the parent has no document. */
export async function removeUserData(db: Firestore, uid: string): Promise<void> {
  if (!uid) throw new Error('Missing Firebase UID');
  await db.recursiveDelete(db.collection('users').doc(uid));
}

/** Auth deletion is a server event; clients cannot delete another user's data. */
export const cleanupDeletedAccount = functions.auth.user().onDelete(async (user) => {
  await removeUserData(getFirestore(), user.uid);
});
