# Phase 17 — published puzzles, Daily, and reminders

MICHI keeps the Sudoku engine, Coach, and gameplay on the device. Firestore distributes immutable editorial content; Drift caches it globally on the installation. User game history and Daily completion remain in the existing profile-scoped sync tables.

## Content release

The reviewable source is `content/releases/remote_v3.json`. It contains 35 validated Sudoku puzzles derived from the bundled pack by digit relabeling, including 32 Daily-eligible entries. This starter release exercises the publishing path without importing third-party puzzle IP. Future editorial packs should use new stable puzzle IDs. The Dart validator uses `PuzzleAnalyzer`, `ExactSolver`, and `HumanSolver` to require a structurally valid board, one solution, full human solve, declared difficulty, and exact technique metadata. The generated artifact includes a SHA-256 checksum and is intentionally written to ignored `build/` output.

From the repository root, with Flutter 3.47.8/Dart 3.13.7 on `PATH`:

```sh
./tools/content/validate_release.sh content/releases/remote_v3.json build/content/releases/remote_v3.json
npm --prefix functions run content:publish -- --artifact=build/content/releases/remote_v3.json --project=demo-michi
```

The publisher defaults to a dry run. Applying requires both `--apply` and `--confirm-project=PROJECT`:

```sh
FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 npm --prefix functions run content:publish -- \
  --artifact=build/content/releases/remote_v3.json \
  --project=demo-michi --apply --confirm-project=demo-michi
```

The Admin tool checks the artifact schema/checksum, existing release hash, and every existing puzzle content hash **before** writing. It reports created, identical, conflict, and failed counts. It creates puzzle documents in batches of at most 400 and publishes release metadata last. A published ID is immutable. To change a board, publish a new ID. `draft`, `published`, and `retired` are the release states; only `published` documents are readable by clients. The Admin tool does not reimplement Sudoku rules in TypeScript. Never run a production `--apply` from CI or an ordinary PR.

## Firestore data

- `contentReleases/{releaseId}`: schema version, content version, status, sorted puzzle IDs, artifact SHA-256, publish time.
- `puzzles/{puzzleId}`: board, difficulty, stable technique identifiers, Daily eligibility, content version, release ID, status, content hash, publish time.
- `dailyChallenges/{yyyy-MM-dd}`: local calendar date key, puzzle ID, release ID, challenge key, status, publish time.
- `users/{uid}/devices/{installationId}`: owner-only FCM registration and reminder schedule. Firestore Rules deny any client write to shared content. Guests can read only published shared content.

Drift schema v8 adds `remote_puzzles`, `remote_content_releases`, and `daily_challenge_cache`. These tables have **no profile ID**. A complete release activates atomically in the local cache only after all listed puzzle documents pass lightweight schema and constraint checks. Older cached puzzles remain for active games/history. The client never runs expensive solver validation on every startup. If a refresh fails, New Puzzle uses the active cached release or the bundled pack. Remote Config defaults are in `firebase/remote_config.template.json`; `remoteContentEnabled` and `dailyRemoteEnabled` can fall back to bundled play, while `dailyFutureCacheDays` is capped at three.

## Daily calendar and lock

The 2nd-gen `ensureDailyChallengesPublished` scheduler runs daily at 00:15 UTC in `europe-west1` and maintains today plus 14 future UTC date keys. This ahead-of-time horizon covers users who have entered tomorrow locally. It only selects published Daily-eligible puzzles. A SHA-256 digest of date, release ID, and sorted eligible IDs chooses deterministically after excluding the previous 30 published Daily puzzle IDs. If the pool is exhausted, it deterministically uses the full pool. Firestore transaction `create` leaves an existing date untouched across retries, overlap, or release changes.

After the first release publication, seed the horizon immediately:

```sh
FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 npm --prefix functions run daily:ensure -- \
  --project=demo-michi --confirm-project=demo-michi --date=2026-11-11
```

The client asks for its **local** `yyyy-MM-dd`. It checks the locally locked assignment first, then a prefetched cached assignment, then Firestore, and finally the deterministic bundled Daily. Once shown, the assignment is locked for that date. If a user first opens Daily offline and gets bundled fallback, that identity remains for the rest of the date even after reconnection. The next two future dates are prefetched when online. Daily completion still uses the existing challenge key and profile sync path. No Firebase source label appears in Home.

## Reminders

Settings offers the approved “Daily at 08:00” control. Guests see sign-in context and cannot enable FCM reminders. No notification permission is requested at launch; an authenticated user explicitly enabling reminders triggers the OS prompt. The client stores the installation ID (not a hardware ID), FCM token, language, IANA timezone, and next local 08:00 occurrence under its own account. Token rotation is observed after app startup; timezone/locale changes are checked on resume and in Settings. Sign-out removes the registration before ending Firebase Auth and invalidates the token. If server cleanup cannot complete, sign-out remains pending so the previous account's active token is not silently left behind. Account deletion's recursive cleanup removes device records too.

The 2nd-gen `sendDueDailyReminders` scheduler runs every 15 minutes in `europe-west1`. It queries enabled device records by `nextReminderAt` in bounded pages. A Firestore transaction claims a due device, writes its local `lastReminderDate` before FCM send, and uses a five-minute lease. Successful delivery schedules the next local occurrence with IANA/DST conversion. Transient failures can retry after the lease; permanent invalid-token errors remove the device. The copy says only that today's Sudoku is ready, in the device's supported language. The foreground path is silent; background and terminated taps route to Home after startup/profile selection, where the existing Daily state handles active or completed games. Android has a single `michi_daily` channel and Android 13+ permission declaration. iOS declares remote notification background mode.

The `notificationsEnabled` Remote Config parameter controls the client and the scheduled sender. Remote Config is behavior control, never puzzle storage. [Firebase scheduled functions](https://firebase.google.com/docs/functions/schedule-functions) and [Flutter FCM lifecycle](https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages) are the platform references.

## Verification and deployment boundaries

```sh
npm --prefix functions run lint
npm --prefix functions run build
# With Auth/Firestore/Functions emulators running:
FIRESTORE_EMULATOR_HOST=127.0.0.1:8080 FIREBASE_AUTH_EMULATOR_HOST=127.0.0.1:9099 npm --prefix functions test
flutter test --no-pub
flutter analyze --no-pub
flutter build apk --debug --no-pub
flutter build ios --simulator --debug --no-pub
```

Live Firebase setup remains separate from emulator verification. The project must have Firestore enabled, production Rules/indexes deployed, Remote Config template published, Email/Password Auth enabled, and Functions deployed before a real device can consume published content. Live iOS push additionally needs an Apple Developer Team, Push Notifications entitlement/provisioning, and an APNs key in Firebase. A real-device FCM send/tap test is required before claiming live push works. The emulator cannot validate APNs/FCM delivery.

### Verification record — 12 November 2026

- The Dart validator accepted all 35 puzzles in `remote_v3`; the publisher dry run found 35 new records. Emulator apply created 35 records, and the Daily seeder created 15 calendar dates beginning 2026-11-12. These operations targeted only disposable `demo-michi` emulator data.
- The mobile suite passed 217 tests, the pure Dart engine suite 160, the scanner suite 17, and the design-system suite 2. Functions, Rules, and emulator integration passed 25 Node tests. Functions lint/build, Dart analysis/formatting, Android debug, and iOS simulator debug passed.
- The earlier five Phase 16 manual in-app flows passed on two iOS simulators; see [Phase 16 walkthrough](phase16_emulator_walkthrough.md). For Phase 17, a new isolated iOS 18.3 simulator opened Home as a guest against disposable Firebase emulators. Its Drift cache held release `remote_v3`, 35 puzzles, and a locked `remotePublished` assignment for 2026-11-12 (`remote_v3_medium_0008`). The published Daily opened in Game. New Puzzle selected `remote_v3_easy_0001`. After stopping the backend emulators, New Puzzle opened cached `remote_v3_medium_0001`, and the same published Daily still opened offline. Guest Settings showed the reminder switch disabled with sign-in guidance. The shared Android emulator was also attempted but had a System UI not responding dialog while an unrelated app held the foreground.
- The manual iOS walkthrough did not complete all 81 cells, simulate a new uncached date for bundled Daily fallback, or verify real FCM delivery. Those paths have automated repository/sync/backend coverage, but still need a full in-app acceptance pass before claiming end-to-end device verification.
- The live `michi-sudoku-coach` Firestore API returned HTTP 403 (disabled/not yet initialized). No production Rules, indexes, Functions, Remote Config, or puzzle release were deployed. Live account sync and physical-device FCM send/tap remain unverified. iOS APNs setup is still unavailable.
