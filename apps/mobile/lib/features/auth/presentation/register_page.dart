import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/presentation/auth_copy.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_provider_buttons.dart';

@RoutePage()
final class RegisterPage extends StatefulWidget {
  const RegisterPage({this.fromWelcome = false, super.key});

  final bool fromWelcome;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  bool _showPassword = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _finishSocial() async {
    if (!mounted) return;
    if (widget.fromWelcome) {
      await context.router.replace(const OnboardingRoute());
    } else {
      context.router.popUntilRoot();
    }
  }

  Future<void> _create() async {
    setState(() {
      _nameError = _name.text.trim().isEmpty
          ? context.t.auth.errorNameRequired
          : null;
      _emailError = isValidEmail(_email.text)
          ? null
          : context.t.auth.errorInvalidEmail;
      _passwordError = _password.text.length < 8
          ? context.t.auth.errorPasswordLength
          : null;
    });
    if (_nameError != null || _emailError != null || _passwordError != null) {
      return;
    }
    final created = await context.read<AuthCubit>().register(
      _name.text,
      _email.text,
      _password.text,
    );
    if (created && mounted) {
      await context.router.replace(
        EmailVerificationRoute(fromWelcome: widget.fromWelcome),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          children: [
            Text(
              context.t.auth.createTitle,
              style: MichiTypography.functionalTitle,
            ),
            const SizedBox(height: MichiSpacing.sm),
            Text(
              context.t.auth.createSubtitle,
              style: MichiTypography.secondary,
            ),
            const SizedBox(height: MichiSpacing.xl),
            if (!auth.available || !auth.hasEnabledProvider) ...[
              AuthErrorBanner(message: context.t.auth.errorUnavailable),
            ] else ...[
              if (auth.googleEnabled || auth.appleEnabled) ...[
                AuthProviderButtons(onAuthenticated: _finishSocial),
                const SizedBox(height: MichiSpacing.lg),
                const Divider(color: MichiColors.hairline),
                const SizedBox(height: MichiSpacing.lg),
              ],
              if (auth.problem case final problem?) ...[
                AuthErrorBanner(message: authProblemText(context, problem)),
                const SizedBox(height: MichiSpacing.lg),
              ],
              if (auth.emailEnabled) ...[
                MichiTextField(
                  key: const ValueKey('register-name'),
                  label: context.t.auth.name,
                  controller: _name,
                  errorText: _nameError,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  enabled: !auth.busy,
                  onChanged: (_) => _clearErrors(),
                ),
                const SizedBox(height: MichiSpacing.md),
                MichiTextField(
                  key: const ValueKey('register-email'),
                  label: context.t.auth.email,
                  controller: _email,
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  enabled: !auth.busy,
                  onChanged: (_) => _clearErrors(),
                ),
                const SizedBox(height: MichiSpacing.md),
                MichiTextField(
                  key: const ValueKey('register-password'),
                  label: context.t.auth.password,
                  controller: _password,
                  errorText: _passwordError,
                  obscureText: !_showPassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  enabled: !auth.busy,
                  onChanged: (_) => _clearErrors(),
                  onSubmitted: (_) => _create(),
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
                Padding(
                  padding: const EdgeInsets.only(top: MichiSpacing.xs),
                  child: Text(
                    context.t.auth.passwordHint,
                    style: MichiTypography.meta,
                  ),
                ),
                const SizedBox(height: MichiSpacing.xl),
                MichiButton(
                  key: const ValueKey('register-submit'),
                  label: context.t.auth.createAccount,
                  isLoading: auth.busy,
                  onPressed: auth.busy ? null : _create,
                ),
                const SizedBox(height: MichiSpacing.lg),
                TextButton(
                  onPressed: auth.busy
                      ? null
                      : () async {
                          context.read<AuthCubit>().clearProblem();
                          await context.router.replace(
                            AuthRoute(fromWelcome: widget.fromWelcome),
                          );
                        },
                  child: Text(
                    '${context.t.auth.alreadyAccount} ${context.t.auth.signIn}',
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void _clearErrors() {
    if (_nameError != null || _emailError != null || _passwordError != null) {
      setState(() {
        _nameError = null;
        _emailError = null;
        _passwordError = null;
      });
    }
    context.read<AuthCubit>().clearProblem();
  }
}
