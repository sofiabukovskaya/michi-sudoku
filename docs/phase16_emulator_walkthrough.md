# Phase 16 in-app emulator walkthrough — 10 November 2026

Two iOS 18.3 simulators ran MICHI against the Firebase Auth, Firestore, and
Functions Emulator Suite. Device B was a newly created simulator. The test
accounts and project were disposable (`demo-michi`); no live Firebase data was
changed. Local Drift and emulator documents were inspected to verify the UI.

| Scenario | Result | Observation |
| --- | --- | --- |
| A. Guest → account | Passed | Device A showed five completed puzzles and one mastered technique as guest. After signing in, Profile still showed five and one. The five completed records were present in the emulator. |
| B. Second client | Passed | Clean Device B signed into the same account and restored five completed puzzles, one mastered technique, and the Naked Single practice progress. It did not restore Device A's local active game. |
| C. Account isolation | Passed | Device B signed out: guest Profile and Learn showed zero account progress. A second test account also showed zero Naked Single progress; returning to the first account restored its progress. |
| D. Offline → reconnect | Passed | With emulators stopped, a correct practice check increased local attempts and left one outbox row. The approved offline banner appeared. After restart and Retry, the outbox was empty and Firestore showed two attempts. |
| E. Concurrent devices | Passed | Both devices made a correct Naked Single check while offline. After reconnect, Firestore held two source records with three and one attempts. Both local databases converged to four total attempts; neither outbox retained a row. |

The walkthrough uncovered two Phase 16 runtime issues that widget tests had not
exercised:

1. `MichiApp` registered `ChangeNotifier`/`ValueNotifier` objects with
   `RepositoryProvider`, causing a debug assertion at launch. It now uses
   `ChangeNotifierProvider.value` for both objects.
2. `Firebase.initializeApp(demoProjectId: ...)` creates a **named** app.
   Auth and Firestore were using the native default app, so the first guest
   claim wrote to the `michi-sudoku-coach` *emulator namespace* rather than
   `demo-michi`. Both services now use the app owned by `FirebaseRuntime`.
   Historical simulator records were requeued into the corrected demo
   namespace solely for this walkthrough. No production data was involved.
3. Three feature refresh callbacks returned a `Future` from `setState` during
   a sync notification. They now use synchronous `setState` closures.

Restarting the Emulator Suite clears its in-memory Auth and Firestore state.
The disposable first test UID was recreated between the offline and concurrent
checks; the simulator's local profile and database were retained. This is test
setup, not a product flow.

**LIVE FIREBASE VERIFICATION OUTSTANDING.** The Phase 16 Rules and Function
have not been deployed, live Email/Password and Firestore setup have not been
verified, and no live two-device sync test has been run.
