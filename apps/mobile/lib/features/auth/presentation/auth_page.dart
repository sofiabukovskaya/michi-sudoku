import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/presentation/auth_copy.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_provider_buttons.dart';

@RoutePage()
final class AuthPage extends StatefulWidget {
  const AuthPage({this.fromWelcome = false, super.key});

  final bool fromWelcome;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

final class _AuthPageState extends State<AuthPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    if (!mounted) return;
    if (widget.fromWelcome) {
      await context.router.replace(const OnboardingRoute());
    } else {
      await context.router.maybePop();
    }
  }

  Future<void> _signIn() async {
    setState(() {
      _emailError = isValidEmail(_email.text)
          ? null
          : context.t.auth.errorInvalidEmail;
      _passwordError = _password.text.isNotEmpty
          ? null
          : context.t.auth.errorPasswordLength;
    });
    if (_emailError != null || _passwordError != null) return;
    if (await context.read<AuthCubit>().signIn(_email.text, _password.text)) {
      await _finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    final copy = context.t.auth;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: MichiMascot(state: MichiMascotState.calm, size: 48),
            ),
            const SizedBox(height: MichiSpacing.sm),
            Text(
              context.t.auth.signInTitle,
              style: MichiTypography.functionalTitle,
            ),
            const SizedBox(height: MichiSpacing.xxl),
            if (!auth.available || !auth.hasEnabledProvider) ...[
              AuthErrorBanner(message: context.t.auth.errorUnavailable),
            ] else ...[
              if (auth.problem case final problem?) ...[
                AuthErrorBanner(message: authProblemText(context, problem)),
                const SizedBox(height: MichiSpacing.lg),
              ],
              if (auth.emailEnabled)
                MichiTextField(
                  key: const ValueKey('auth-email'),
                  label: context.t.auth.email,
                  controller: _email,
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  enabled: !auth.busy,
                  onChanged: (_) => _clearErrors(),
                ),
              if (auth.emailEnabled) const SizedBox(height: MichiSpacing.md),
              if (auth.emailEnabled)
                MichiTextField(
                  key: const ValueKey('auth-password'),
                  label: context.t.auth.password,
                  controller: _password,
                  errorText: _passwordError,
                  obscureText: !_showPassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  enabled: !auth.busy,
                  onChanged: (_) => _clearErrors(),
                  onSubmitted: (_) => _signIn(),
                  suffixIcon: IconButton(
                    tooltip: _showPassword
                        ? context.t.auth.hidePassword
                        : context.t.auth.showPassword,
                    onPressed: () =>
                        setState(() => _showPassword = !_showPassword),
                    icon: Icon(
                      _showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              if (auth.emailEnabled)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: auth.busy
                        ? null
                        : () async {
                            context.read<AuthCubit>().clearProblem();
                            await context.router.push(
                              PasswordResetRoute(initialEmail: _email.text),
                            );
                          },
                    child: Text(context.t.auth.forgotPassword),
                  ),
                ),
              if (auth.emailEnabled) const SizedBox(height: MichiSpacing.lg),
              if (auth.emailEnabled)
                MichiButton(
                  key: const ValueKey('auth-sign-in'),
                  label: context.t.auth.signIn,
                  isLoading: auth.busy,
                  onPressed: auth.busy ? null : _signIn,
                ),
              if (auth.googleEnabled || auth.appleEnabled) ...[
                const SizedBox(height: MichiSpacing.xl),
                const Divider(color: MichiColors.hairline),
                const SizedBox(height: MichiSpacing.xl),
                AuthProviderButtons(onAuthenticated: _finish),
              ],
              if (auth.emailEnabled) const SizedBox(height: MichiSpacing.xl),
              if (auth.emailEnabled)
                TextButton(
                  onPressed: auth.busy
                      ? null
                      : () async {
                          context.read<AuthCubit>().clearProblem();
                          await context.router.replace(
                            RegisterRoute(fromWelcome: widget.fromWelcome),
                          );
                        },
                  child: Text(
                    '${copy.noAccount} ${copy.createAccount}',
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  void _clearErrors() {
    if (_emailError != null || _passwordError != null) {
      setState(() {
        _emailError = null;
        _passwordError = null;
      });
    }
    context.read<AuthCubit>().clearProblem();
  }
}
