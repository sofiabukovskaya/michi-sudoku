import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/data/auth_error_mapper.dart';
import 'package:michi_mobile/features/auth/domain/auth_account.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';

final class _FakeAuthRepository implements AuthRepository {
  final sessions = StreamController<AuthSession>.broadcast(sync: true);
  AuthProblem? nextProblem;
  AuthAccount account = const AuthAccount(
    uid: 'firebase-uid',
    email: 'player@example.com',
    emailVerified: false,
  );
  bool signedOut = false;

  void _maybeFail() {
    final problem = nextProblem;
    nextProblem = null;
    if (problem != null) throw AuthException(problem);
  }

  @override
  Stream<AuthSession> watchSession() => sessions.stream;

  @override
  Future<AuthAccount> signInWithEmail(String email, String password) async {
    _maybeFail();
    return account;
  }

  @override
  Future<AuthAccount> register(String name, String email, String password) =>
      signInWithEmail(email, password);

  @override
  Future<AuthAccount> signInWithGoogle() => signInWithEmail('', '');

  @override
  Future<AuthAccount> signInWithApple() => signInWithEmail('', '');

  @override
  Future<void> sendPasswordReset(String email) async => _maybeFail();

  @override
  Future<void> sendEmailVerification() async => _maybeFail();

  @override
  Future<bool> refreshEmailVerification() async {
    _maybeFail();
    return true;
  }

  @override
  Future<void> signOut() async {
    _maybeFail();
    signedOut = true;
  }
}

void main() {
  late _FakeAuthRepository repository;
  late AuthCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    cubit = AuthCubit(repository);
  });
  tearDown(() async {
    await cubit.close();
    await repository.sessions.close();
  });

  test('starts as an optional guest and restores a persisted session', () {
    expect(cubit.state.account, isNull);
    expect(cubit.state.available, isFalse);
    repository.sessions.add(
      AuthSession(available: true, account: repository.account),
    );
    expect(cubit.state.account?.uid, 'firebase-uid');
    expect(cubit.state.account?.emailVerified, isFalse);
    repository.sessions.add(const AuthSession(available: true));
    expect(cubit.state.account, isNull);
    expect(cubit.state.available, isTrue);
  });

  test('sign-in succeeds, then sign-out returns to guest', () async {
    repository.sessions.add(
      const AuthSession(
        available: true,
        emailEnabled: true,
        googleEnabled: true,
      ),
    );
    expect(await cubit.signIn('player@example.com', 'password'), isTrue);
    expect(cubit.state.account?.uid, 'firebase-uid');
    expect(cubit.state.googleEnabled, isTrue);
    expect(await cubit.signOut(), isTrue);
    expect(repository.signedOut, isTrue);
    expect(cubit.state.account, isNull);
    expect(cubit.state.googleEnabled, isTrue);
  });

  test('cancellation is quiet and failures remain typed', () async {
    repository.sessions.add(const AuthSession(available: true));
    repository.nextProblem = AuthProblem.cancelled;
    expect(await cubit.signInWithGoogle(), isFalse);
    expect(cubit.state.problem, isNull);
    repository.nextProblem = AuthProblem.network;
    expect(await cubit.signIn('player@example.com', 'password'), isFalse);
    expect(cubit.state.problem, AuthProblem.network);
    repository.sessions.add(const AuthSession(available: false));
    expect(cubit.state.available, isFalse);
  });

  test(
    'registration, verification, and reset maintain account identity',
    () async {
      repository.sessions.add(const AuthSession(available: true));
      expect(
        await cubit.register('Player', 'player@example.com', 'password'),
        isTrue,
      );
      expect(await cubit.sendEmailVerification(), isTrue);
      expect(await cubit.refreshEmailVerification(), isTrue);
      expect(cubit.state.account?.emailVerified, isTrue);
      expect(await cubit.resetPassword('player@example.com'), isTrue);
      expect(cubit.state.account?.uid, 'firebase-uid');
    },
  );

  test('Firebase errors map to stable presentation problems', () {
    expect(
      authProblemForFirebaseCode('invalid-email'),
      AuthProblem.invalidEmail,
    );
    expect(
      authProblemForFirebaseCode('weak-password'),
      AuthProblem.weakPassword,
    );
    expect(
      authProblemForFirebaseCode('email-already-in-use'),
      AuthProblem.emailInUse,
    );
    expect(
      authProblemForFirebaseCode('invalid-credential'),
      AuthProblem.wrongCredentials,
    );
    expect(
      authProblemForFirebaseCode('too-many-requests'),
      AuthProblem.tooManyRequests,
    );
    expect(
      authProblemForFirebaseCode('network-request-failed'),
      AuthProblem.network,
    );
    expect(authProblemForFirebaseCode('other'), AuthProblem.unexpected);
  });
}
