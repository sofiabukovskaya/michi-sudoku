import 'package:michi_mobile/features/auth/domain/auth_repository.dart';

AuthProblem authProblemForFirebaseCode(String code) => switch (code) {
  'invalid-email' => AuthProblem.invalidEmail,
  'weak-password' => AuthProblem.weakPassword,
  'email-already-in-use' => AuthProblem.emailInUse,
  'invalid-credential' ||
  'wrong-password' ||
  'user-not-found' => AuthProblem.wrongCredentials,
  'user-disabled' => AuthProblem.disabled,
  'too-many-requests' => AuthProblem.tooManyRequests,
  'network-request-failed' => AuthProblem.network,
  'web-context-cancelled' || 'cancelled' => AuthProblem.cancelled,
  _ => AuthProblem.unexpected,
};
