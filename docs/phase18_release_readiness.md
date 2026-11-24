# MICHI 0.1.0 (1) · release readiness

**Decision — BLOCKED.** No store upload or tester invitation has been made. The owner confirmed that MICHI has no Apple Developer membership and no approved Android application ID or upload key.

## Live services

| Component | Verification on michi-sudoku-coach |
| --- | --- |
| Firestore | Created the default Native Mode database in europe-west1, the region already used by the project’s Functions. Compiled and deployed the repository’s owner-scoped rules and composite indexes. |
| Auth | Firebase CLI 15.36.0 successfully provisioned the Email/Password provider on the current plan. The app now offers it by default. Google and Apple sign-in require separate configuration. |
| Remote Config | Deployed and read back remoteContentEnabled, dailyRemoteEnabled, dailyFutureCacheDays and notificationsEnabled. |
| Editorial content | The Dart validator accepted all 35 puzzles. The live publisher created 35 documents. A second pass verified 35 identical hashes and zero conflicts. |
| Daily | Once the indexes finished building, the admin publisher created 15 locked dates, November 13–27, 2026 inclusive. Read back the November 13 assignment, remote_v3_medium_0001. Scheduling past this horizon requires the deployed function. |
| Functions | Source lint and compilation pass. Deployment was rejected because Artifact Registry and the Functions build pipeline require Blaze billing. Neither scheduled job nor the Auth deletion cleanup trigger is live. Deleting a real account can leave user progress under its UID until the cleanup trigger is deployed and older deletions are reconciled. |
| Push | A compiled sender uses the scheduled user’s UID in the data payload. A tap must match the active account before opening Daily. Foreground handling is silent. Test doubles exercise send scheduling, invalid tokens and retry. Live FCM HTTP v1 sent directly to the opted-in QA emulator. Foreground delivery reached the SDK silently. Background and cold taps on the system notification opened the November 13 completed Daily. Production scheduling and physical APNs remain open. |

## Identity, signing and devices

The visible name is MICHI on both platforms. Android uses **com.example.michi_sudoku** and iOS uses **com.example.michiSudoku**. The embedded widget is **com.example.michiSudoku.DailyWidget** with app group **group.com.example.michiSudoku.daily**. Both configured Firebase mobile registrations belong to project number **936754178748** and still use those example identifiers. The release icon uses the MICHI wordmark grid. Android now has a monochrome Sudoku notification glyph.

The connected-device inventory listed a paired iPhone 15 Pro Max. A direct CoreDevice connection timed out. Xcode also returned “No Accounts” for the configured team and missing provisioning profiles for Runner and DailyWidget on the signed archive attempt. Other signing identities on the Mac do not establish ownership of MICHI. The phone and a printed puzzle are available to the owner. No test below is counted as a physical-device pass.

| Physical verification | Status |
| --- | --- |
| iPhone camera permission, indoor capture, focus/glare, TFLite recognition, Review and one-step Coach | Awaiting a provisioned install and hands-on capture. |
| Haptic intensity, VoiceOver traversal and background/foreground restoration | Awaiting hands-on iPhone check. |
| Home and Lock Screen widget installation, tint, link and Siri shortcuts | Tested Home widget navigation on a simulator in Phase 17.5. App group and push entitlements need MICHI provisioning on real hardware. |
| APNs | No enrolled MICHI Apple team, matching push profile or verified APNs credential for MICHI in Firebase. |
| Android camera, TalkBack, haptics and notifications | No physical Android device appeared in adb. |

## Privacy inventory for store declarations

**Scanner photos do not leave the device through MICHI.** The camera/gallery adapter reads image bytes locally, passes them to the grid detector and bundled TFLite interpreter, then exposes recognized cells. Camera temporary-file deletion is attempted after reading. Selecting from Photos leaves the user’s original in the library. A signed-in player who finishes an imported puzzle can sync its numeric starting and completed boards. Review and the external Coach do not upload the photograph. This statement covers the app’s data paths. The phone’s own photo-library backup follows the owner’s OS settings.

| Data reaching Firebase/Google | When, purpose and linkage | Store disclosure to review |
| --- | --- | --- |
| Email, password submitted to Auth, optional display name, UID, sign-in tokens and provider request metadata | Optional account creation and authentication. Firebase handles credentials. The UID identifies the account in Firestore. MICHI does not store the password in Drift. | Contact info, user ID, account management and app functionality |
| Initial/completed board values, game and puzzle IDs, completion dates, elapsed time, errors, hint use, Daily keys and per-install technique statistics | Signed-in sync scoped by UID. Guest progress is claimed on first sign-in. Learning progress and mastery can be derived from these records. Active game and its undo history stay local. | User content, gameplay/activity and identifiers linked to the account |
| Installation ID, FCM token, platform, locale, IANA time zone, reminder preference/time, next and last reminder date | Opted-in server registration under UID. The Firebase SDK can generate a token/installation identifier independently of notification permission. A push goes through FCM and, on iOS, APNs. | Identifiers and app functionality |
| Crash reports, stack traces, app/OS/device information, installation identifiers | Crashlytics is enabled in release. No explicit user ID or custom gameplay log is attached by MICHI. | Crash data, diagnostics and applicable identifiers |
| App Check attestation tokens and app/device integrity signals | Play Integrity on Android and App Attest with DeviceCheck fallback on iOS. Used for abuse prevention. Provider registration/enforcement requires validation on the final registrations. | Identifiers, diagnostics and security |
| Firebase Installation ID, application and SDK versions, configuration fetch metadata, locale/region and platform attributes | Remote Config checks feature parameters and caches them on the device. Published puzzle/Daily reads also reach Firestore. Network requests disclose the client IP to the service. | Identifiers and app functionality |
| Analytics | Collection is deactivated in the native app configuration and disabled in Dart before application analytics use. There is no advertising or cross-app tracking feature in this build. | Review SDK declarations against the signed binary before submission |

The owner must supply the legal operator, monitored feedback/privacy contact, retention/deletion terms and a public privacy-policy URL. For Google Play, also supply the external account-deletion request resource if the app is submitted with accounts. Final store answers should reflect optional account and notification flows, required SDK processing, encryption in transit and applicable service-provider arrangements. See [Apple App Privacy](https://developer.apple.com/app-store/app-privacy-details/), [Google Play Data safety](https://support.google.com/googleplay/android-developer/answer/10787469), [Firebase Apple disclosures](https://firebase.google.com/docs/ios/app-store-data-collection) and [Firebase Android disclosures](https://firebase.google.com/docs/android/play-data-disclosure).

## Release builds and installation

The Flutter production entry point is `apps/mobile/lib/main.dart`. Release configuration selects the registered Firebase project, Play Integrity or App Attest with DeviceCheck fallback, the bundled scanner model and the validated puzzle catalog. The emulator and App Check debug branches require a debug build. The app disables the Flutter debug banner. The bundled offline Daily is intentional product content.

| Deliverable | Result |
| --- | --- |
| Android | Gradle assembled a release APK and the final 92.1 MB bundle. JDK signature verification reported an unsigned JAR. Release signing now reads the owner's ignored `android/key.properties`. Without these properties Gradle produces an unsigned bundle. A disposable local QA signature allowed a release APK to run on a clean AVD. This credential cannot be used for the store. |
| iOS | Fixed the Crashlytics symbol-upload script lookup for the Xcode Archive action. The final 276.2 MB arm64 Release archive compiled locally with its embedded DailyWidget. Flutter validated the replacement launch artwork without a template warning. Signed archiving failed on provisioning. The Runner target now declares its push environment and shares the app group with the widget. No distributable IPA exists. |
| Distribution | No TestFlight or Play upload. The beta description, What to Test, feedback prompts and Play internal-track notes are in the [beta test plan](phase18_beta_test_plan.md). Permanent IDs, credentials and store contacts require owner action. |

Four packages passed static analysis. All 401 workspace tests passed (221 mobile, 160 engine, 18 scanner, two design system). Backend lint, TypeScript compilation and all 25 Firebase emulator tests passed.

## Walkthrough and persistence

| Story | Observed result |
| --- | --- |
| A · First-time player | On a newly created Android emulator, the release APK opened Welcome, accepted guest onboarding and level selection, and opened the live November 13 Medium Daily. Coach traversed four levels. Completion recorded 56 solved cells, one hint, zero mistakes and a Daily stamp. On another puzzle, tapping Explanation on a Coach-assisted 8 opened Why and showed the row, column and box evidence. The level selection currently has no persistent personalization effect. Removed the promise that it sets the first lesson and difficulty. |
| B · Learning | Android opened Learn, Naked Single, the lesson and Practice. Selecting row 3 column 3 and digit 7 produced “Well spotted”. Progress showed 25% Naked Single mastery and a next learning action. Home and Week reflected the completed Daily. The learning focus can remain the same technique after one correct exercise. |
| C and D · External Sudoku | On the upgraded iOS simulator, the native photo picker opened a newspaper image with a pre-entered 3 at row 9 column 4. Review recognized it and accepted confirmation of the low-confidence 1. “I'm stuck” produced one four-stage Coach deduction. Closing Coach preserved the 3. Continue in MICHI opened an imported Game with the reviewed board. This used the real local recognition path and a library image. Fresh camera capture remains a hardware check. |
| E · Accounts | Two separate fresh iOS simulator installations used the production Firebase runtime, Drift repositories, guest-claim operation and SyncEngine. Install A recorded one correct guest practice answer, signed in and uploaded. Install B signed into the same live account and restored one first-try correct answer and 25% mastery with an empty outbox. A second UID saw no local progress and received a Firestore permission denial when requesting the first UID’s records. The two-install harness called app services directly. Separately, Android registered a disposable account through the release UI after guest play and Practice. Settings displayed its last sync and the completed Daily remained visible. The two disposable sync-test identities were verified absent after cleanup. |
| F · Offline | With Wi-Fi and mobile data disabled, Android cold-started, opened the local Daily, applied the Coach result “Place 5” and displayed Why. A separate offline walkthrough advanced through the Naked Single lesson. Network access was restored after each test. Current tests verified a locked fallback Daily, cached remote Daily, queued sync writes and successful retry without doubling progress. A single physical-device disconnect-to-reconnect journey is outstanding. |

**Fresh install and upgrade.** The Android release walkthrough used a dedicated empty emulator. On iOS, the candidate was installed over two populated simulator applications without clearing their containers. For the schema-8 install every fingerprint across 11 tables matched, including one active game, one completed game, one Daily completion, technique mastery, an imported board, 35 cached puzzles, a cached release and three Daily assignments. On the older schema-7 install the upgrade to schema 8 added the three remote-content tables. All pre-existing rows matched, including five account-owned completed games, two technique progress rows, four device contributions and four sync metadata records. No loss was observed in either fixture. A store-signed upgrade remains dependent on permanent identity and signing. An app installed under a different permanent identifier will have a different OS data container.

## Visual and performance audit

Compared running Android screens for Welcome, Home, Game, Coach Result, Technique, Practice feedback, Progress, Week and guest Profile with the approved PDF. The mascot, paper/indigo surfaces and typography remain recognizable. The reference Home Daily mascot is larger, and the reference progress/profile examples have sections the current app cannot populate. The Android system bars and local content change the available space. Corrected the iOS native launch storyboard’s empty template image and white surface with the existing approved splash mascot and indigo. Corrected the stale guest Profile/account copy after enabling live sync.

The [previous side-by-side captures](phase17_5_product_delight_audit.md) cover onboarding, completion, the four-stage Coach, regular iPhone, compact Ukrainian/Czech and large German. The current walkthrough also compared the first onboarding panel, Why, Learn, Lesson and Settings side by side. It exercised Scanner and Review through native UI automation. A complete fresh side-by-side audit on the signed iPhone build, including small-device scroll and long localized copy, remains outstanding. No claim of pixel parity.

The clean Android cold start took 6.223 seconds according to Activity Manager on a newly booted ARM emulator. A later process-cold restart on the same emulator took 1.340 seconds. The emulator recorded 144 rendered frames across the walkthrough, median 69 ms and 90th percentile 250 ms, while native builds and simulators were active. A tab-only Android frame-counter run returned zero captured frames, so it supplies no tab latency metric. The aggregate result requires a Flutter frame trace on hardware. The Android Coach tap through screen capture took 3.46 seconds including automation overhead. In the iOS scanner UI test, about two seconds elapsed from dispatching the photo selection to reading the recognized board. These measure the full interaction, including the OS and test driver. Home, Game entry, Practice and tab switching were exercised. Per-screen Flutter raster timing, steady-state memory and production read counts still need a hardware profile.

Game now suspends its periodic display timer while backgrounded. Existing tests cover paused board visibility and restoration of elapsed time and givens. Camera controller, decoded images, codec, inference worker and native interpreter have disposal paths. There was no long-running hardware leak test.

## Recoverable failures and outstanding issues

| Failure | Evidence |
| --- | --- |
| No network, remote Daily absent, malformed content, sync write failure | Offline device journeys and repository tests cover cached and bundled fallback, rejection of incomplete releases, retained outbox and retry. |
| Firebase unavailable or expired session | Guest startup proceeds independently of Firebase initialization. The auth mapper tests verify localized handling for expired/invalid user tokens, recent-login requirements and network errors. A live forcibly expired session through the release UI remains unverified. |
| No grid, invalid scanned puzzle, unsupported hint | Scanner regressions reject non-grid imagery. Scanner and widget tests cover invalid positions, correction and the distinct unsupported-step response. The simulator additionally exercised successful recognition and recovery from a low-confidence result. |
| Push unavailable or denied | Startup handles an unavailable initial-message service. Sign-in and explicit opt-in gate OS permission. Sender tests cover failures, token cleanup and retry. On Android the OS prompt appeared only after tapping Reminders. Denying it produced system-settings guidance. Granting permission and opting in registered a live token. The foreground remained quiet. An OS notification appeared on channel michi_daily in the background. A subsequent tap with no running MICHI process reopened the correct completed Daily. Logout returned to a fresh guest Home with no inherited Daily stamp. A live query found zero device registrations for the signed-out UID. The stale notification was no longer in the tray, so a tap on an already signed-out UID was not reproduced. These tests used real FCM on an emulator. The separate reminder-test identity and its synced QA data were removed with owner approval, and identity absence was verified. |

| Priority | Open issue and owner action |
| --- | --- |
| P1 | Both permanent application IDs and their Firebase registrations require owner approval. Apple membership, MICHI-owned distribution profiles, widget app group and APNs configuration are missing. Android has no owner upload key. Neither platform has an uploadable candidate. |
| P1 | Enable billing for the Functions deployment. Deploy and verify scheduled publishing, reminder sending and account-deletion cleanup. Reconcile previously deleted accounts as needed. The account deletion promise currently exceeds the deployed backend. |
| P1 release verification | Install a signed build on the available iPhone, verify camera/TFLite, accessibility, haptics, app restoration, widget tint and links, Siri and physical APNs. Repeat real FCM opt-in, delivery, taps and account switching on signed physical hardware. |
| P2 | Profile frame timing on physical hardware. Close the remaining signed-build design and offline/online walkthroughs. Android hardware QA remains open if a device becomes available. |
| P2 distribution | Supply a monitored feedback/privacy contact, legal operator and policy/deletion resources. Complete the privacy forms against the signed binaries and decide store access. |
| P3 | Remaining visual differences include Home mascot scale, simpler diagrams and fewer Profile/Settings sections than the illustrative PDF. |

No confirmed P0 was observed in the exercised paths. Distribution is on hold pending the P1 items.
