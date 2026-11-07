# Phase 15 Firebase and authentication plan

## Baseline and audit

- Branch: `feature/firebase_foundation`, clean at `622ffc7` before Phase 15 changes. Phase 14.5 reported 366 passing workspace tests, code generation, analysis, formatting, Android and iOS simulator builds.
- Local Drift remains the source of active games, history, mastery and preferences. Its records have no Firebase UID owner. Sign-in/sign-out must preserve them; this device-local data is shared across account changes until Phase 16 defines ownership and migration.
- Existing startup restores local games without authentication. Four tabs are persistent. `AuthRoute` is a hidden placeholder; Profile is guest-only.
- The approved PDF account flow is on exported pages 7–14, 16–27, 93–101. It includes optional guest entry, email registration/sign-in/reset/verification, Apple and Google actions, and guest/account profile states. The PDF is flattened imagery, so Flutter components reproduce its layout and tokens rather than extract vectors.
- Android application ID is `com.example.michi_sudoku`; iOS bundle ID is `com.example.michiSudoku`. No Firebase configuration existed at baseline. The installed Firebase CLI listed no MICHI project. After the user accepted `michi-sudoku-coach` as the permanent ID, the project was created under `sofi454545@gmail.com` and FlutterFire registered both existing platform IDs.

## Stages and intended commits

1. Firebase dependencies and nonblocking bootstrap. Keep guest gameplay available on initialization failure. Commit after generation, analysis and smoke tests.
2. Auth domain, Firebase adapter, session Cubit and focused unit tests. UID is the authenticated identity; no credentials enter Drift. Commit after tests.
3. Approved auth and account UI, six-language copy, Profile integration, widget/navigation tests. Commit after generation and tests.
4. Deny-by-default Firestore rules, Emulator Suite configuration, and a TypeScript Functions workspace with no public endpoint. Commit after rule and TypeScript checks.
5. App Check, Crashlytics, Analytics and Remote Config foundations, then full regression, Android/iOS builds and simulator walkthrough. Commit after verification.

Provider flows requiring Firebase Console, Android SHA certificates, Google iOS URL scheme or Apple Developer capability remain unverified until those configurations and device tests are available. Phase 16 synchronization is excluded.

## Implemented and verified

- Firebase project and Android/iOS app registrations were created through the
  CLI. Bootstrap starts Firebase without waiting before guest gameplay.
- The Auth repository and Cubit manage optional sessions, typed errors, email
  actions, Google and Apple adapters, and sign-out. Provider controls are gated
  by explicit build flags until corresponding live setup is verified; the Auth
  emulator enables email forms in debug builds.
- Approved account screens and guest/signed-in Profile states use the existing
  design system and Slang copy for all six languages. Local Drift records are
  neither cleared nor uploaded on authentication changes.
- Firestore rules deny all access. Auth and rules emulator tests pass. Functions
  lint and TypeScript build pass; no endpoint is exported.
- Code generation, formatting, workspace analysis, 376 workspace tests, Android
  debug build and iOS simulator debug build pass. The iPhone SE simulator showed
  the guest Profile and emulator registration, sign-in and reset screens.

## External configuration

The Firebase project has no Authentication configuration yet (`getConfig`
returned `CONFIGURATION_NOT_FOUND`). The Firebase Console opens at a Google
sign-in screen in the available browser. Email/Password must be enabled there
before a live email build is exposed. Google additionally needs Android SHA
certificates and a refreshed iOS plist with URL scheme. Apple Developer
Services ID/key and capability are not set up. Details are in
`docs/phase15_firebase_setup.md`. No live provider was claimed as verified.
