import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/domain/auth_account.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';
import 'package:michi_mobile/features/auth/presentation/auth_page.dart';
import 'package:michi_mobile/features/auth/presentation/password_reset_page.dart';
import 'package:michi_mobile/features/auth/presentation/register_page.dart';

final class _AuthRepository implements AuthRepository {
  final sessions = StreamController<AuthSession>.broadcast(sync: true);
  AuthProblem? signInProblem;
  String? resetRequestedFor;

  @override
  Stream<AuthSession> watchSession() => sessions.stream;

  @override
  Future<AuthAccount> signInWithEmail(String email, String password) async {
    if (signInProblem case final problem?) throw AuthException(problem);
    return const AuthAccount(
      uid: 'uid',
      email: 'player@example.com',
      emailVerified: false,
    );
  }

  @override
  Future<AuthAccount> register(String name, String email, String password) =>
      signInWithEmail(email, password);

  @override
  Future<AuthAccount> signInWithGoogle() => signInWithEmail('', '');

  @override
  Future<AuthAccount> signInWithApple() => signInWithEmail('', '');

  @override
  Future<void> sendPasswordReset(String email) async =>
      resetRequestedFor = email;

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<bool> refreshEmailVerification() async => true;

  @override
  Future<void> signOut() async {}
}

void main() {
  late _AuthRepository repository;
  late AuthCubit cubit;

  setUp(() {
    LocaleSettings.setLocaleSync(AppLocale.en);
    repository = _AuthRepository();
    cubit = AuthCubit(repository);
    repository.sessions.add(
      const AuthSession(available: true, emailEnabled: true),
    );
  });

  tearDown(() async {
    await cubit.close();
    await repository.sessions.close();
  });

  Future<void> showPage(
    WidgetTester tester, {
    Widget page = const AuthPage(),
  }) async {
    await tester.pumpWidget(
      BlocProvider.value(
        value: cubit,
        child: TranslationProvider(
          child: MaterialApp(home: page),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('email sign-in stays available without social provider setup', (
    tester,
  ) async {
    await showPage(tester);
    expect(find.byKey(const ValueKey('auth-email')), findsOneWidget);
    expect(find.byKey(const ValueKey('auth-password')), findsOneWidget);
    expect(find.byKey(const ValueKey('auth-google')), findsNothing);
    expect(find.byKey(const ValueKey('auth-apple')), findsNothing);
  });

  testWidgets('invalid email is explained before a network request', (
    tester,
  ) async {
    await showPage(tester);
    await tester.enterText(find.byType(TextField).first, 'invalid');
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.tap(find.byKey(const ValueKey('auth-sign-in')));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  testWidgets('typed server error is presented in the approved form', (
    tester,
  ) async {
    repository.signInProblem = AuthProblem.wrongCredentials;
    await showPage(tester);
    await tester.enterText(
      find.byType(TextField).first,
      'player@example.com',
    );
    await tester.enterText(find.byType(TextField).last, 'password123');
    await tester.tap(find.byKey(const ValueKey('auth-sign-in')));
    await tester.pumpAndSettle();
    expect(cubit.state.problem, AuthProblem.wrongCredentials);
    expect(find.byType(AuthPage), findsOneWidget);
  });

  testWidgets('registration validates name and password locally', (
    tester,
  ) async {
    await showPage(tester, page: const RegisterPage());
    await tester.enterText(
      find.byKey(const ValueKey('register-email')),
      'player@example.com',
    );
    await tester.tap(find.byKey(const ValueKey('register-submit')));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);
    expect(find.text('Enter your name.'), findsOneWidget);
  });

  testWidgets('password reset sends the entered email', (tester) async {
    await showPage(
      tester,
      page: const PasswordResetPage(initialEmail: 'player@example.com'),
    );
    await tester.tap(find.byKey(const ValueKey('reset-submit')));
    await tester.pumpAndSettle();
    expect(repository.resetRequestedFor, 'player@example.com');
    expect(find.byKey(const ValueKey('reset-submit')), findsNothing);
  });
}
