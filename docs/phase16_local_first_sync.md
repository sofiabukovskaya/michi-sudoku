# Phase 16 local-first synchronization

Drift is the feature database. Firestore is a per-account copy used for recovery
and cross-device progress. Game, Learn, Practice, Progress, and Profile read only
the local repositories; the sync layer pulls and merges into Drift.

## Ownership and migration

Schema v7 adds `profile_id` to active games, completed games, technique
progress, Daily learning focus, and imported puzzles. The composite primary
keys include the profile. Infrastructure tables (`sync_metadata`,
`sync_outbox`) have their own ownership semantics. The v6→v7 migration places
all unowned legacy rows in `guest`, regardless of the Firebase session at
migration time. On first authenticated session, `LocalProfileManager` claims
guest rows into `firebase:<uid>` in one Drift transaction. It uses a stable
`guestImportId` and source ID for pre-claim technique contributions, then
rotates the guest import ID after a successful claim. Repeating the claim
cannot double-count them.

Sign-out selects `guest` without deleting the account cache. Another account
gets its own profile ID. A local active game is scoped to its owner and never
uploaded. If both guest and account already have an active game, the account
game stays active and the guest game remains available in guest mode until it
can be claimed later. Divergent completed games with the same ID stop the
claim and retain the guest data for review.

After confirmed account deletion, the account's local scope and outbox are
purged. A confirmed-deletion marker supports retrying local cleanup after a
crash. The server Auth deletion trigger recursively removes `users/{uid}` and
all nested collections, including technique device contributions.

## Synced data and merge policy

| Record | Firestore path | Merge |
| --- | --- | --- |
| Completed game | `users/{uid}/completedGames/{gameId}` | Append-only union; divergent same IDs are conflicts. |
| Daily completion | `users/{uid}/daily/{challengeKey}` | Completed remains completed; remote metadata wins if both exist. |
| Technique contribution | `users/{uid}/techniqueProgress/{techniqueId}/devices/{sourceId}` | Sum distinct sources; repeated uploads of one source use cumulative counters. |

`schemaVersion: 1` is required on every remote document. Unknown versions stop
that sync pass without overwriting a future-format document. Remote reads use
the server rather than treating Firestore's local cache as a successful sync.
All writes have server `updatedAt`, and append-only records have server
`createdAt`. Stable document IDs and Firestore transactions make retries
idempotent. A Drift outbox row is written in the same transaction as each
completed game, Daily completion, or practice check. Sync pulls, merges, and
drains the outbox; successful uploads remove a row only if its local revision
has not changed meanwhile.

Technique counters are per-installation cumulative values. The current
independent streak can reset after a wrong or assisted check. Its highest
historical value is retained separately, so achieved mastery cannot
downgrade. Account-level current streak is the maximum current device streak;
it does not pretend to reconstruct a cross-device sequence. The aggregate
used by Learn remains a Drift projection. Recommendations and Daily learning
focus remain local derived decisions. The language choice is device-local,
matching the current system-locale preference behavior. Player level is not
persisted or used after its selection screen yet, so there is no meaningful
account-level setting to synchronize in this phase. Scanner images, active
games, local UI state, and ML artifacts are never uploaded.

## Triggers and user states

Sync runs after authenticated startup/sign-in, on app resume, after a
debounced outbox change, and through Retry in Settings. There is no terminated
app background scheduling. The UI says progress is saved locally while a
network operation cannot finish. An offline banner appears only for a signed-in
profile with an unavailable cloud connection. Transient cloud errors receive
up to four automatic retries after 2, 4, 8, and 16 seconds; app resume or a
manual Retry starts a fresh bounded sequence. Permanent errors retain the
outbox and wait for intervention. Gameplay remains available.

The Auth account UID is checked before remote access and each sync pass has a
generation guard. Account switching changes the local scope immediately and
invalidates cached feature tabs. Remote changes refresh Home, Learn, Progress,
and Profile from Drift. Normal sync failures retain the outbox for later retry.

## Firebase setup and verification

The repository contains least-privilege Firestore rules and an Auth deletion
Function. They are tested against `demo-michi` emulators. **They have not been
deployed to the live `michi-sudoku-coach` project.** Live Email/Password must
be enabled in Firebase Console before a normal build exposes account entry;
Google and Apple still need the provider/platform setup in
[Phase 15 setup](phase15_firebase_setup.md). The live Firestore database,
provider settings, App Check, rules deployment, and two-device production sync
have not been verified. Do not enable App Check enforcement before registering
and testing release providers.

From the repository root:

```sh
dart run melos run generate
dart run melos run format
dart run melos run analyze
dart run melos run test
cd functions && npm run lint && npm run build
cd ..
firebase emulators:exec --project demo-michi --only auth,firestore,functions \
  'cd functions && node --test test/*.test.mjs'
cd apps/mobile && flutter run --dart-define=MICHI_USE_FIREBASE_EMULATORS=true
```

The installed standalone Firebase CLI in this environment bundles Node 20,
which cannot load the current Functions dependencies. Run Emulator Suite with
an npm-installed Firebase CLI under a Node 22+ runtime. The test run used
firebase-tools 15.35.0 with Node 24 and passed the recursive deletion test.
The app's Functions workspace targets Node 22 for deployment.

The five in-app emulator scenarios and the runtime issues fixed during that
walkthrough are recorded in [Phase 16 emulator walkthrough](phase16_emulator_walkthrough.md).
Emulator builds bind Auth, Firestore, and Functions to the same named
`demo-michi` Firebase app. This keeps emulator data separate from the native
default app's live project ID.

After configuring live Auth and Firestore, verify registration, guest claim,
offline completion and practice, sign-out, a second clean installation, Daily
completion, account switching, retry, and account deletion on real devices
before claiming live production sync is ready. No Firebase deployment was made
in Phase 16.
