import 'package:michi_mobile/features/auth/domain/auth_account.dart';

enum AuthProblem {
  unavailable,
  invalidEmail,
  weakPassword,
  emailInUse,
  wrongCredentials,
  disabled,
  tooManyRequests,
  network,
  cancelled,
  unexpected,
}

final class AuthException implements Exception {
  const AuthException(this.problem);

  final AuthProblem problem;
}

final class AuthSession {
  const AuthSession({
    required this.available,
    this.account,
    this.emailEnabled = false,
    this.googleEnabled = false,
    this.appleEnabled = false,
  });

  final bool available;
  final AuthAccount? account;
  final bool emailEnabled;
  final bool googleEnabled;
  final bool appleEnabled;
}

abstract interface class AuthRepository {
  Stream<AuthSession> watchSession();

  Future<AuthAccount> signInWithEmail(String email, String password);

  Future<AuthAccount> register(String name, String email, String password);

  Future<AuthAccount> signInWithGoogle();

  Future<AuthAccount> signInWithApple();

  Future<void> sendPasswordReset(String email);

  Future<void> sendEmailVerification();

  Future<bool> refreshEmailVerification();

  Future<void> signOut();
}
