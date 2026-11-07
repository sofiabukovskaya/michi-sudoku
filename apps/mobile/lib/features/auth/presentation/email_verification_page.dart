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

@RoutePage()
final class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({this.fromWelcome = false, super.key});

  final bool fromWelcome;

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

final class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool _checked = false;

  Future<void> _finish() async {
    if (!mounted) return;
    if (widget.fromWelcome) {
      await context.router.replace(const OnboardingRoute());
    } else {
      context.router.popUntilRoot();
    }
  }

  Future<void> _check() async {
    final verified = await context.read<AuthCubit>().refreshEmailVerification();
    if (!mounted) return;
    if (verified) {
      await _finish();
    } else {
      setState(() => _checked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthCubit>().state;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: _finish,
          icon: const Icon(Icons.close),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: MichiMascot(state: MichiMascotState.notebook, size: 112),
              ),
              const SizedBox(height: MichiSpacing.xl),
              Text(
                context.t.auth.verifyTitle,
                style: MichiTypography.functionalTitle,
              ),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                context.t.auth.verifySubtitle(email: auth.account?.email ?? ''),
                style: MichiTypography.body,
              ),
              if (_checked && !auth.isSignedIn) ...[
                const SizedBox(height: MichiSpacing.lg),
                AuthErrorBanner(message: context.t.auth.errorUnavailable),
              ] else if (_checked && auth.account?.emailVerified == false) ...[
                const SizedBox(height: MichiSpacing.lg),
                AuthErrorBanner(message: context.t.auth.notVerified),
              ],
              if (auth.problem case final problem?) ...[
                const SizedBox(height: MichiSpacing.lg),
                AuthErrorBanner(message: authProblemText(context, problem)),
              ],
              const Spacer(),
              MichiButton(
                key: const ValueKey('verify-check'),
                label: context.t.auth.checkVerification,
                isLoading: auth.busy,
                onPressed: auth.busy ? null : _check,
              ),
              const SizedBox(height: MichiSpacing.sm),
              TextButton(
                key: const ValueKey('verify-resend'),
                onPressed: auth.busy || !auth.isSignedIn
                    ? null
                    : () async {
                        final sent = await context
                            .read<AuthCubit>()
                            .sendEmailVerification();
                        if (sent && context.mounted) {
                          setState(() => _checked = false);
                        }
                      },
                child: Text(context.t.auth.resendVerification),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
