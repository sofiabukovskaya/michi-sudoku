import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/presentation/auth_copy.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_error_banner.dart';

@RoutePage()
final class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({this.initialEmail = '', super.key});

  final String initialEmail;

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

final class _PasswordResetPageState extends State<PasswordResetPage> {
  late final TextEditingController _email;
  String? _emailError;
  bool _sent = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    setState(() {
      _emailError = isValidEmail(_email.text)
          ? null
          : context.t.auth.errorInvalidEmail;
    });
    if (_emailError != null) return;
    if (await context.read<AuthCubit>().resetPassword(_email.text) && mounted) {
      setState(() => _sent = true);
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
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          children: [
            Text(context.t.auth.resetTitle, style: MichiTypography.heading),
            const SizedBox(height: MichiSpacing.sm),
            Text(
              context.t.auth.resetSubtitle,
              style: MichiTypography.secondary,
            ),
            const SizedBox(height: MichiSpacing.xl),
            if (_sent) ...[
              Text(context.t.auth.resetSent, style: MichiTypography.body),
            ] else if (!auth.available || !auth.emailEnabled) ...[
              AuthErrorBanner(message: context.t.auth.errorUnavailable),
            ] else ...[
              if (auth.problem case final problem?) ...[
                AuthErrorBanner(message: authProblemText(context, problem)),
                const SizedBox(height: MichiSpacing.lg),
              ],
              MichiTextField(
                key: const ValueKey('reset-email'),
                label: context.t.auth.email,
                controller: _email,
                errorText: _emailError,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.email],
                enabled: !auth.busy,
                onChanged: (_) {
                  if (_emailError != null) setState(() => _emailError = null);
                  context.read<AuthCubit>().clearProblem();
                },
                onSubmitted: (_) => _send(),
              ),
              const SizedBox(height: MichiSpacing.xl),
              MichiButton(
                key: const ValueKey('reset-submit'),
                label: context.t.auth.sendLink,
                isLoading: auth.busy,
                onPressed: auth.busy ? null : _send,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
