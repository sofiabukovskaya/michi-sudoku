# Phase 15 Firebase setup

The Firebase project is `michi-sudoku-coach`. FlutterFire registered the existing
Android application ID `com.example.michi_sudoku` and iOS bundle ID
`com.example.michiSudoku`. The generated configuration files are committed; they
contain public app identifiers, not a service account or private key.

## Authentication providers

Email/password, Google, and Apple are implemented through Firebase Auth. The
Firebase Console provider switches and platform credentials still need setup:

1. In Firebase Console → Authentication → Sign-in method, enable Email/Password.
   Test registration, verification, reset, sign-in, session restoration, and
   sign-out on a device against the real project. Until then, email account
   controls are hidden in a normal build. The Auth emulator exposes them in a
   debug build using `MICHI_USE_FIREBASE_EMULATORS=true`.
2. Enable Google. Add Android debug and release SHA-1/SHA-256 fingerprints to
   the registered Android app, download a refreshed `google-services.json`, and
   rebuild. Refresh the iOS `GoogleService-Info.plist`, add its
   `REVERSED_CLIENT_ID` as an iOS URL scheme, then test account selection and
   cancellation on Android and iOS. The current iOS plist has no `CLIENT_ID`
   or `REVERSED_CLIENT_ID`, so Google is deliberately hidden by default.
3. Set up Sign in with Apple in the Apple Developer account and Firebase Console
   using the Apple Team ID, Services ID, and Sign in with Apple private key.
   Add the Sign in with Apple capability to the signed iOS target, then verify
   first and repeat sign-in, private relay email, and cancellation on a device.
   No Apple Developer provider details were available in Phase 15, so Apple is
   deliberately hidden by default.

After each provider's setup and device verification, enable its UI in the build:

```sh
flutter build ios --dart-define=MICHI_EMAIL_AUTH_ENABLED=true
flutter build ios --dart-define=MICHI_GOOGLE_AUTH_ENABLED=true
flutter build ios --dart-define=MICHI_APPLE_AUTH_ENABLED=true
```

Use the same defines for Android or `flutter run` as appropriate. Keep a provider
flag disabled on any platform where its configuration has not been verified.
The app's guest route remains available without Firebase.

## Local verification

```sh
flutterfire configure --project=michi-sudoku-coach --account=sofi454545@gmail.com \
  --platforms=android,ios \
  --android-package-name=com.example.michi_sudoku \
  --ios-bundle-id=com.example.michiSudoku \
  --out=lib/firebase_options.dart --yes

firebase emulators:exec --project demo-michi --only auth,firestore \
  'cd functions && node --test test/*.test.mjs'

flutter run --dart-define=MICHI_USE_FIREBASE_EMULATORS=true
```

Run `flutterfire configure` from `apps/mobile`. Run the emulator command from
the repository root. On Android Emulator, the app uses `10.0.2.2` to reach the
local emulators; iOS Simulator uses `localhost`. The emulator flag works in
debug builds only.

## Security and data ownership

Firestore rules currently deny every read and write. No Firestore database or
Functions endpoint is required for Phase 15 authentication, and no gameplay
records are uploaded. Before enabling a future Firestore schema, define
per-UID ownership, stable local and remote record IDs, update times or versions,
conflict handling, and guest-to-account migration in Phase 16. Existing Drift
records remain device-local and are visible after sign-in and sign-out; account
separation of these pre-existing local records is a Phase 16 decision.

App Check uses debug providers in debug builds, Play Integrity on Android and
App Attest with DeviceCheck fallback on iOS in release builds. Register the
providers and test real builds before enabling enforcement in Firebase Console.
Analytics collection remains disabled until a consent policy is implemented.
Crashlytics captures uncaught errors only in release builds. Remote Config is
initialized without remote gameplay dependencies or required fetches.

The installed Android Gradle wrapper is 8.14 and Android Gradle Plugin is
8.11.1; Kotlin 2.4.21 is required by the current Firebase Android artifacts.
Use Java 21 for Android builds in this environment. A later toolchain upgrade
can address Flutter's deprecation notices independently of Phase 15.
