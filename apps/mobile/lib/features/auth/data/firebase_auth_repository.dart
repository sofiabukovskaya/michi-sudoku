import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/notifications/reminder_registration.dart';
import 'package:michi_mobile/features/auth/data/auth_error_mapper.dart';
import 'package:michi_mobile/features/auth/domain/auth_account.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';

final class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._runtime, [this._reminders]);

  // Enable each provider only after its console and platform setup is verified.
  static bool get emailEnabled =>
      FirebaseRuntime.useEmulators ||
      const bool.fromEnvironment('MICHI_EMAIL_AUTH_ENABLED');
  static bool get googleEnabled =>
      const bool.fromEnvironment('MICHI_GOOGLE_AUTH_ENABLED');
  static bool get appleEnabled =>
      const bool.fromEnvironment('MICHI_APPLE_AUTH_ENABLED');

  final FirebaseRuntime _runtime;
  final ReminderRegistration Function()? _reminders;
  Future<void>? _googleInitialization;

  @override
  Stream<AuthSession> watchSession() async* {
    if (!await _runtime.ready) {
      yield const AuthSession(available: false);
      return;
    }
    try {
      await for (final user in _runtime.auth.userChanges()) {
        yield AuthSession(
          available: true,
          account: _account(user),
          emailEnabled: emailEnabled,
          googleEnabled: googleEnabled,
          appleEnabled: appleEnabled,
        );
      }
    } on Object {
      yield const AuthSession(available: false);
    }
  }

  Future<FirebaseAuth> _auth() async {
    if (!await _runtime.ready) {
      throw const AuthException(AuthProblem.unavailable);
    }
    return _runtime.auth;
  }

  @override
  Future<AuthAccount> signInWithEmail(String email, String password) async {
    if (!emailEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      final auth = await _auth();
      final result = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return _requiredAccount(result.user);
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<AuthAccount> register(
    String name,
    String email,
    String password,
  ) async {
    if (!emailEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      final auth = await _auth();
      final result = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = result.user;
      if (user == null) throw const AuthException(AuthProblem.unexpected);
      var displayName = user.displayName;
      final requestedName = name.trim();
      if (requestedName.isNotEmpty) {
        try {
          await user.updateDisplayName(requestedName);
          displayName = requestedName;
        } on FirebaseAuthException {
          // Keep the new account even if its display name cannot be set.
        }
      }
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException {
        // The account already exists. The verification screen can retry.
      }
      return AuthAccount(
        uid: user.uid,
        email: user.email,
        displayName: displayName,
        emailVerified: user.emailVerified,
      );
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<AuthAccount> signInWithGoogle() async {
    if (!googleEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      final auth = await _auth();
      _googleInitialization ??= GoogleSignIn.instance.initialize();
      await _googleInitialization;
      final googleUser = await GoogleSignIn.instance.authenticate();
      final token = googleUser.authentication.idToken;
      if (token == null) throw const AuthException(AuthProblem.unexpected);
      final credential = GoogleAuthProvider.credential(idToken: token);
      final result = await auth.signInWithCredential(credential);
      return _requiredAccount(result.user);
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const AuthException(AuthProblem.cancelled);
      }
      throw const AuthException(AuthProblem.unexpected);
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<AuthAccount> signInWithApple() async {
    if (!appleEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      final auth = await _auth();
      // Firebase's native provider owns the Apple nonce and credential flow.
      final result = await auth.signInWithProvider(AppleAuthProvider());
      return _requiredAccount(result.user);
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    if (!emailEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      await (await _auth()).sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!emailEnabled) throw const AuthException(AuthProblem.unavailable);
    try {
      final user = (await _auth()).currentUser;
      if (user == null) throw const AuthException(AuthProblem.unavailable);
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<bool> refreshEmailVerification() async {
    try {
      final auth = await _auth();
      await auth.currentUser?.reload();
      return auth.currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final auth = await _auth();
      final uid = auth.currentUser?.uid;
      if (uid != null) await _reminders?.call().disable(uid);
      await auth.signOut();
      if (_googleInitialization != null) {
        try {
          await GoogleSignIn.instance.signOut();
        } on Object {
          // Firebase session termination is the security boundary.
        }
      }
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = (await _auth()).currentUser;
      if (user == null) throw const AuthException(AuthProblem.unavailable);
      await user.delete();
    } on FirebaseAuthException catch (error) {
      throw _map(error);
    }
  }

  static AuthAccount? _account(User? user) => user == null
      ? null
      : AuthAccount(
          uid: user.uid,
          email: user.email,
          displayName: user.displayName,
          emailVerified: user.emailVerified,
        );

  static AuthAccount _requiredAccount(User? user) =>
      _account(user) ?? (throw const AuthException(AuthProblem.unexpected));

  static AuthException _map(FirebaseAuthException error) =>
      AuthException(authProblemForFirebaseCode(error.code));
}
