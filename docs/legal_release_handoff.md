# MICHI legal release handoff

The Privacy Policy and Terms of Use are drafts dated 2026-11-26. Have the owner or legal counsel review all six translations and the actual release configuration before publishing.

## Owner inputs

| Input | Where to update |
| --- | --- |
| Controller or operator legal name | Replace `{{CONTROLLER}}` in the Markdown documents |
| Working privacy and deletion email | Set `LegalVersion.contact`. The app and generator insert it into the shared Markdown and activate the mail links |
| Controller country and applicable law | Replace `{{COUNTRY}}` after confirming both descriptions are correct |
| Retention and deletion details | Replace `{{RETENTION}}` in each privacy policy. Verify schedule, backups, exceptions and provider configuration |
| Legal bases and transfer safeguards, where applicable | Replace `{{LEGAL_BASIS_TRANSFERS}}` and confirm applicable rights, notices and crash-report default |
| Public HTTPS origin | Choose a domain or managed hosting address. No origin is configured by the app |
| Effective date | Confirm and update `LegalVersion.current` |

Remove the localized draft notices after approval. Establish an owner-operated inbox procedure to verify account ownership, delete the account and associated data, and handle privacy requests. The site uses email and the in-app deletion path. It has no deletion backend. Verify that the deployed account cleanup function works and establish a procedure for failures.

## Build and host

From the repository root:

```sh
export PATH=~/fvm/versions/3.47.8/bin:$PATH
cd apps/mobile
dart run tool/build_legal_site.dart
```

The generator writes `apps/mobile/build/legal_site`. It contains 12 documents and a language index. Run `dart run tool/build_legal_site.dart --check-ready` to reject unresolved draft placeholders before producing the publication copy. Run this check even if files from a previous draft generation exist.

After approval, serve the output on an HTTPS static host, such as Firebase Hosting. Confirm the selected host's request logging and update the web disclosure if necessary. Check all locale links, the email action and the deletion anchor before entering the URLs in App Store Connect or Play Console.

| Purpose | Intended path on the approved origin |
| --- | --- |
| Privacy Policy | `/en/privacy.html` |
| Terms of Use | `/en/terms.html` |
| Play Console account deletion | `/en/privacy.html#delete-account` |
| Localized pages | Replace `en` with `cs`, `de`, `es`, `fr` or `uk` |

## Code audit

- `firestore.rules` and the sync repository scope completed games, Daily completions and per-installation technique contributions to the UID. Completed games include starting and final numeric boards, including imported boards. In-progress games and original scan photos stay local. Scanner capture cleanup is best effort. The diagnostic define is false by default and can retain local files if explicitly enabled for a build.
- The email registration form requires a name. Google and Apple sign-in are optional build features and may supply available profile details. Firebase Authentication processes account data in the United States. The account cleanup function runs in `europe-west1`. That region does not establish the location of Firestore or other Firebase products. [Firebase privacy and security](https://firebase.google.com/support/privacy/)
- Account deletion removes account-owned local data on the device when the app completes the account cleanup flow. The Auth deletion event recursively removes `users/{uid}` and its subcollections. Separate guest data, copies on other devices, and Firebase SDK diagnostics are outside that Firestore cleanup.
- Streak reminders schedule locally. Legacy reminder migration and the old FCM server job remain in the repository. Old records may contain platform, locale, time zone, token and schedule. Messaging can also generate SDK registration identifiers separately from the local reminder, depending on platform and configuration. Confirm the legacy job and token state for the release. [Firebase iOS SDK disclosures](https://firebase.google.com/docs/ios/app-store-data-collection) · [Firebase Android SDK disclosures](https://firebase.google.com/docs/android/play-data-disclosure)
- Analytics is deactivated in the iOS and Android configuration and explicitly disabled at Firebase startup. Crash reporting defaults to on in release after reading the local preference. The off switch gates Dart reporting immediately, asks the SDK to disable collection and requests deletion of pending reports. Native SDK timing and local buffering vary by platform. The switch does not retract uploaded reports. [Crashlytics reporting behavior](https://firebase.google.com/docs/crashlytics/flutter/customize-crash-reports)
- The registration notice distinguishes agreement to the terms from acknowledgement of the privacy policy. Crash sharing has its own control in Settings.

## Store form draft

Classifications below use the repository and published Firebase SDK disclosures. Check the actual iOS archive, Google Play build, provider configuration and service settings before submission. For Play, assess service-provider sharing exemptions separately from collection. For Apple, treat device-linked data as linked unless you have verified de-identification before collection. Tracking is **No** for each row.

| Data | Apple App Privacy | Google Play Data safety | Linked | Purpose and availability |
| --- | --- | --- | --- | --- |
| Name, email and Firebase UID | Name, Email Address, User ID | Personal info: Name, Email address, User IDs | Account | App functionality and account management. Optional for play, required for email registration |
| Password and optional social sign-in credentials | Review Other Data Types for credentials collected by Auth | Review Personal info → Other info for credentials collected by Auth | Account | Authentication and account security. Only for the selected sign-in method |
| Completed games, numeric imported boards, Daily and technique progress | Gameplay Content, Product Interaction as applicable | App activity: Other actions, Other user-generated content as applicable | Account | Restore and sync progress. Optional overall through guest play |
| Installation IDs, Messaging registration, legacy device metadata and schedule | Device ID, Other Data Types as applicable | Device or other IDs, App activity or Diagnostics as applicable to retained metadata | Installation. Legacy records also link to account | Service operation and legacy reminder delivery. Core SDK IDs may be automatic, legacy registration was optional |
| Remote Config, App Check and content request metadata | Device ID and Other Diagnostic Data or Other Data Types where retained | Device or other IDs and Diagnostics where retained | Installation where identifiers are retained | App functionality, service security and fraud prevention. No separate opt-out for connected service requests |
| Crash reports and device context | Crash Data, Device ID, Other Diagnostic Data as applicable | Crash logs, Diagnostics, Device or other IDs | Installation | Reliability. Optional, enabled by default in release |
| Scanner photos, guest progress, in-progress boards, local preferences and reminders | No collection for on-device processing | No collection for on-device processing | — | Local only. Completed imported boards that sync are covered above |
| Analytics, ads, payment details | No current collection for these purposes | No current collection for these purposes | — | Review again if introducing paid features or analytics |

References: [Apple App Privacy details](https://developer.apple.com/app-store/app-privacy-details/), [Google Play Data safety](https://support.google.com/googleplay/android-developer/answer/10787469), and [Google Play account deletion](https://support.google.com/googleplay/android-developer/answer/13327111).
