# Privacy Policy

**Draft for owner review.** MICHI’s data controller is {{CONTROLLER}}, based in {{COUNTRY}}. Privacy requests: [{{EMAIL}}](mailto:{{EMAIL}}).

## What stays on your device

- The local database keeps active and completed games, technique progress, Daily completions and imported Sudoku boards.
- Local preferences include onboarding level and completion, language, streak reminder, personal insight bests, solved Spot it days, notebook stamps seen and your crash-report choice.
- With your permission, Scanner reads a camera capture or a photo you select. A bundled TensorFlow Lite model processes it on your device. MICHI does not upload photos. It attempts to delete temporary camera captures after reading them. Your original library photo stays in your library. Internal diagnostic builds can keep local scan files.
- If you enable the streak reminder, MICHI schedules it on your device based on local completion times. You can turn it off in Settings or revoke notification permission.

## Accounts and cloud sync

You can play as a guest. Guest progress stays local while you play as a guest. For email registration, Firebase Authentication handles your name, email, password and account ID. If a build offers Google or Apple sign-in and you choose it, the provider authenticates you and Firebase receives account credentials and available profile details such as your name and email.

When signed in, MICHI uses Cloud Firestore to sync completed games, Daily completions and technique progress, including per-installation contributions. A completed imported game can sync the starting and completed numeric boards, times, mistakes and hint use. An unfinished game does not sync. Legacy remote reminder records may contain an installation ID, platform, language, time zone, push token and scheduling preferences from the former 08:00 reminder.

## Services used for all players

- Firebase Remote Config provides feature and content flags. Firestore serves published puzzles and Daily assignments. These services receive ordinary technical request data, such as IP addresses and SDK or installation information as applicable.
- The Firebase Messaging SDK is still included. It may generate installation and push registration identifiers even when you use only the local reminder.
- Firebase App Check uses Play Integrity or App Attest with DeviceCheck fallback to check the app and device and help prevent abuse.
- Firebase Crashlytics helps diagnose crashes. Reports can include stack traces, device model, OS, app version and installation information. **Share crash reports** is on by default for release builds. Change it in Settings → About MICHI. Turning it off stops new Dart crash reporting. The SDK may apply the native change on next launch. Already sent reports are unaffected, and the SDK can cache crash information locally while sharing is off.

Firebase Analytics collection is disabled. MICHI does not run ads, track you across apps or sell your data. MICHI does not currently collect payment data. If MICHI Plus purchases are added, Apple or Google will process them under their own terms.

## Providers, retention and your choices

Google provides [Firebase services](https://firebase.google.com/support/privacy). Apple can process attestation and optional Apple sign-in data. Firebase services may process data outside your country. The account cleanup function runs in europe-west1. Firebase Authentication processes account data in the United States. This does not specify the location of every Firebase service. If you email us, we use your email address and message to respond.

Local data remains on the device until cleared by an app action or by clearing app storage or uninstalling, subject to OS backup settings. Synced data is kept for your account until deletion. Firebase service retention can vary by product. {{RETENTION}} {{LEGAL_BASIS_TRANSFERS}}

Depending on applicable law, you may be able to request access, correction, deletion, restriction or portability, object to processing, or complain to a data protection authority. Contact [{{EMAIL}}](mailto:{{EMAIL}}). You can change camera, photo and notification permissions in device settings.

## Feedback

When you send feedback, MICHI saves the category, message, optional reply email and, if you include them, the app version and build, platform, OS version, device model, app language and sign-in status. We use the reply address only to respond. We use an installation ID and, when signed in, your account ID to limit abuse. Signed-in feedback is saved with the account ID. The note can be forwarded to the MICHI operator by email. Firestore records are scheduled for deletion after 24 months once the retention policy is enabled. The retention of email copies follows {{RETENTION}}. Unsent drafts stay on your device until submitted or removed with app storage. Scanner images are not attached.

## Delete your account

In MICHI, sign in and open **Profile → Settings → Account → Delete account**. Firebase deletes the account and triggers removal of its cloud game, progress and reminder records. MICHI removes the local account profile on that device. Separate guest data and data already stored on other devices may remain. If you cannot use the app, email [{{EMAIL}}](mailto:{{EMAIL}}) from the address on your account and ask to delete your MICHI account and associated data. Do not send your password. We may verify that you own the account.
