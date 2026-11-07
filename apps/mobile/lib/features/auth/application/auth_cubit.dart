import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/features/auth/domain/auth_account.dart';
import 'package:michi_mobile/features/auth/domain/auth_repository.dart';

final class AuthState {
  const AuthState({
    this.available = false,
    this.account,
    this.busy = false,
    this.problem,
    this.emailEnabled = false,
    this.googleEnabled = false,
    this.appleEnabled = false,
  });

  final bool available;
  final AuthAccount? account;
  final bool busy;
  final AuthProblem? problem;
  final bool emailEnabled;
  final bool googleEnabled;
  final bool appleEnabled;

  bool get isSignedIn => account != null;
  bool get hasEnabledProvider => emailEnabled || googleEnabled || appleEnabled;
}

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState()) {
    _sessionSubscription = _repository.watchSession().listen(
      _onSession,
      onError: (Object error, StackTrace stack) {
        if (!isClosed) emit(const AuthState());
      },
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<AuthSession> _sessionSubscription;
  int _request = 0;

  void _onSession(AuthSession session) {
    if (isClosed) return;
    emit(
      AuthState(
        available: session.available,
        account: session.account,
        busy: state.busy,
        problem: state.problem,
        emailEnabled: session.emailEnabled,
        googleEnabled: session.googleEnabled,
        appleEnabled: session.appleEnabled,
      ),
    );
  }

  void clearProblem() {
    if (state.problem == null || isClosed) return;
    emit(
      AuthState(
        available: state.available,
        account: state.account,
        busy: state.busy,
        emailEnabled: state.emailEnabled,
        googleEnabled: state.googleEnabled,
        appleEnabled: state.appleEnabled,
      ),
    );
  }

  Future<bool> signIn(String email, String password) =>
      _accountAction(() => _repository.signInWithEmail(email, password));

  Future<bool> register(String name, String email, String password) =>
      _accountAction(() => _repository.register(name, email, password));

  Future<bool> signInWithGoogle() =>
      _accountAction(_repository.signInWithGoogle);

  Future<bool> signInWithApple() => _accountAction(_repository.signInWithApple);

  Future<bool> _accountAction(Future<AuthAccount> Function() action) async {
    if (state.busy) return false;
    final request = ++_request;
    emit(
      _copy(busy: true),
    );
    try {
      final account = await action();
      if (isClosed || request != _request) return false;
      emit(_copy(account: account));
      return true;
    } on AuthException catch (error) {
      if (isClosed || request != _request) return false;
      emit(
        _copy(
          problem: error.problem == AuthProblem.cancelled
              ? null
              : error.problem,
        ),
      );
      return false;
    } on Object {
      if (isClosed || request != _request) return false;
      emit(
        _copy(problem: AuthProblem.unexpected),
      );
      return false;
    }
  }

  Future<bool> resetPassword(String email) =>
      _voidAction(() => _repository.sendPasswordReset(email));

  Future<bool> sendEmailVerification() =>
      _voidAction(_repository.sendEmailVerification);

  Future<bool> refreshEmailVerification() async {
    if (state.busy) return false;
    final request = ++_request;
    emit(
      _copy(busy: true),
    );
    try {
      final verified = await _repository.refreshEmailVerification();
      if (isClosed || request != _request) return false;
      final old = state.account;
      emit(
        AuthState(
          available: true,
          account: old == null
              ? null
              : AuthAccount(
                  uid: old.uid,
                  email: old.email,
                  displayName: old.displayName,
                  emailVerified: verified,
                ),
          emailEnabled: state.emailEnabled,
          googleEnabled: state.googleEnabled,
          appleEnabled: state.appleEnabled,
        ),
      );
      return verified;
    } on AuthException catch (error) {
      if (!isClosed && request == _request) {
        emit(
          _copy(problem: error.problem),
        );
      }
      return false;
    } on Object {
      if (!isClosed && request == _request) {
        emit(_copy(problem: AuthProblem.unexpected));
      }
      return false;
    }
  }

  Future<bool> signOut() => _voidAction(
    _repository.signOut,
    signedOut: true,
  );

  Future<bool> _voidAction(
    Future<void> Function() action, {
    bool signedOut = false,
  }) async {
    if (state.busy) return false;
    final request = ++_request;
    emit(
      _copy(busy: true),
    );
    try {
      await action();
      if (isClosed || request != _request) return false;
      emit(
        _copy(clearAccount: signedOut),
      );
      return true;
    } on AuthException catch (error) {
      if (!isClosed && request == _request) {
        emit(
          _copy(problem: error.problem),
        );
      }
      return false;
    } on Object {
      if (!isClosed && request == _request) {
        emit(
          _copy(problem: AuthProblem.unexpected),
        );
      }
      return false;
    }
  }

  AuthState _copy({
    AuthAccount? account,
    bool clearAccount = false,
    AuthProblem? problem,
    bool busy = false,
  }) => AuthState(
    available: state.available,
    account: clearAccount ? null : account ?? state.account,
    busy: busy,
    problem: problem,
    emailEnabled: state.emailEnabled,
    googleEnabled: state.googleEnabled,
    appleEnabled: state.appleEnabled,
  );

  @override
  Future<void> close() async {
    _request++;
    await _sessionSubscription.cancel();
    await super.close();
  }
}
