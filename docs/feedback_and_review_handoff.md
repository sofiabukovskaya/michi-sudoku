# MICHI feedback and native reviews

## Owner setup

Add the numeric App Store Connect Apple ID to `ReviewService.appStoreId` to show the iOS Settings row. Android uses the package's Play listing. Test automatic reviews with the store's supported testing flow. A successful API request does not establish that a native sheet appeared.

Register and verify the production App Check providers for Android and iOS. Sign in to the CLI with permission to manage the MICHI project's functions and secrets. The callable enforces App Check for guests and signed-in accounts. Flutter Firebase emulator mode keeps feedback unavailable. Use a debug App Check token only in a controlled test setup.

Select an SMTP provider with authenticated submission on port 587 using STARTTLS. Set the values at the CLI prompts. For Gmail, the user is the SMTP account and the password is its app password. The recipient can be different from the SMTP account. Enable billing as needed for Functions, Secret Manager and Firestore TTL.

```sh
firebase functions:secrets:set FEEDBACK_TO --project michi-sudoku-coach
firebase functions:secrets:set FEEDBACK_SMTP_HOST --project michi-sudoku-coach
firebase functions:secrets:set FEEDBACK_SMTP_USER --project michi-sudoku-coach
firebase functions:secrets:set FEEDBACK_SMTP_PASS --project michi-sudoku-coach
firebase deploy --only functions:submitFeedback,firestore:rules --project michi-sudoku-coach
gcloud firestore fields ttls update expiresAt --collection-group=feedbackLimits --enable-ttl --project=michi-sudoku-coach
gcloud firestore fields ttls update expiresAt --collection-group=feedback --enable-ttl --project=michi-sudoku-coach
```

The rate window is enforced by timestamps even if TTL cleanup is delayed. Feedback records carry a 24-month expiration timestamp. Firestore deletion requires the TTL policy above. Confirm and document the retention and deletion process for notification email copies and signed-in notes outside the account's game-data tree. The existing account cleanup trigger handles the account's `users/{uid}` subtree. Monitor Firestore for `emailFailed` and `saved` records and review them there when mail is unavailable.

After setup, send a guest note with app details disabled and a signed-in note with details and a QA reply address. Check Firestore delivery status and verify the recipient and Reply-To headers. Confirm scanner images are absent. [App Check for callables](https://firebase.google.com/docs/app-check/cloud-functions) · [Firestore TTL](https://firebase.google.com/docs/firestore/ttl)

## Local verification

```sh
export PATH=~/fvm/versions/3.47.8/bin:$PATH
cd apps/mobile
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
cd ../..
npm --prefix functions run build
firebase emulators:exec --project demo-michi --only auth,firestore,functions \
  'npm --prefix functions run lint && npm --prefix functions test'
```

Use the npm Firebase CLI with a Node runtime compatible with the Functions dependencies when the standalone CLI bundles an older runtime. The tests use the demo project and a mocked SMTP transport.
