import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';

final class AuthProviderButtons extends StatelessWidget {
  const AuthProviderButtons({required this.onAuthenticated, super.key});

  final VoidCallback onAuthenticated;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    final busy = state.busy;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.appleEnabled)
          MichiButton(
            key: const ValueKey('auth-apple'),
            label: context.t.auth.apple,
            variant: MichiButtonVariant.outline,
            onPressed: busy
                ? null
                : () async {
                    final signedIn = await context
                        .read<AuthCubit>()
                        .signInWithApple();
                    if (signedIn && context.mounted) onAuthenticated();
                  },
          ),
        if (state.appleEnabled && state.googleEnabled)
          const SizedBox(height: MichiSpacing.sm),
        if (state.googleEnabled)
          MichiButton(
            key: const ValueKey('auth-google'),
            label: context.t.auth.google,
            variant: MichiButtonVariant.outline,
            onPressed: busy
                ? null
                : () async {
                    final signedIn = await context
                        .read<AuthCubit>()
                        .signInWithGoogle();
                    if (signedIn && context.mounted) onAuthenticated();
                  },
          ),
      ],
    );
  }
}
