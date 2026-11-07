import 'package:flutter/widgets.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';

String authProblemText(BuildContext context, AuthProblem problem) {
  final copy = context.t.auth;
  return switch (problem) {
    AuthProblem.invalidEmail => copy.errorInvalidEmail,
    AuthProblem.weakPassword => copy.errorWeakPassword,
    AuthProblem.emailInUse => copy.errorEmailInUse,
    AuthProblem.wrongCredentials => copy.errorWrongCredentials,
    AuthProblem.disabled => copy.errorDisabled,
    AuthProblem.tooManyRequests => copy.errorTooMany,
    AuthProblem.network => copy.errorNetwork,
    AuthProblem.unavailable => copy.errorUnavailable,
    AuthProblem.cancelled || AuthProblem.unexpected => copy.errorUnexpected,
  };
}

bool isValidEmail(String email) => RegExp(
  r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
).hasMatch(email.trim());
