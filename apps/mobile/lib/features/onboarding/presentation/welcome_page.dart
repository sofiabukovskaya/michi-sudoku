import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/auth/presentation/auth_copy.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_error_banner.dart';
import 'package:michi_mobile/features/auth/presentation/widgets/auth_provider_buttons.dart';
import 'package:michi_mobile/features/legal/domain/legal_document.dart';

@RoutePage()
final class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: MichiContentFrame(
        expandedMaxHeight: 960,
        expandedAlignment: Alignment.topCenter,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // Phones keep the approved top-down composition. Larger
                  // windows hold the identity at the top and place the
                  // invitation as one group in the optical middle.
                  mainAxisAlignment:
                      MichiLayout.classify(MediaQuery.sizeOf(context).width) ==
                          MichiWindowClass.compact
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: MichiWordmark(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: MichiSpacing.xl),
                        const WelcomeArt(),
                        SizedBox(height: constraints.maxHeight * 0.06),
                        Text(
                          context.t.welcome.title,
                          style: MichiTypography.display,
                        ),
                        const SizedBox(height: MichiSpacing.md),
                        Text(
                          context.t.welcome.subtitle,
                          style: MichiTypography.body.copyWith(
                            color: MichiColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.04),
                        MichiButton(
                          label: context.t.welcome.guest,
                          onPressed: () =>
                              context.router.push(const OnboardingRoute()),
                        ),
                        if (context.watch<AuthCubit>().state.available &&
                            context
                                .watch<AuthCubit>()
                                .state
                                .hasEnabledProvider) ...[
                          const SizedBox(height: MichiSpacing.sm),
                          if (context.watch<AuthCubit>().state.googleEnabled ||
                              context
                                  .watch<AuthCubit>()
                                  .state
                                  .appleEnabled) ...[
                            AuthProviderButtons(
                              onAuthenticated: () async =>
                                  context.router.push(const OnboardingRoute()),
                            ),
                            const SizedBox(height: MichiSpacing.sm),
                          ],
                          if (context.watch<AuthCubit>().state.emailEnabled)
                            MichiButton(
                              label: context.t.auth.emailEntry,
                              variant: MichiButtonVariant.text,
                              onPressed: () async {
                                context.read<AuthCubit>().clearProblem();
                                await context.router.push(
                                  AuthRoute(fromWelcome: true),
                                );
                              },
                            ),
                          if (context.watch<AuthCubit>().state.problem
                              case final problem?) ...[
                            const SizedBox(height: MichiSpacing.md),
                            AuthErrorBanner(
                              message: authProblemText(context, problem),
                            ),
                          ],
                        ],
                        TextButton(
                          onPressed: () => context.router.push(
                            LegalRoute(document: LegalDocument.privacy),
                          ),
                          child: Semantics(
                            link: true,
                            child: Text(
                              context.t.legal.privacy,
                              style: MichiTypography.meta,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Balances the wordmark so the group centers optically.
                    const SizedBox(height: MichiSpacing.huge),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Editorial board-and-mascot composition from the approved Welcome screen.
final class WelcomeArt extends StatelessWidget {
  const WelcomeArt({super.key});

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/images/welcome_hero.png',
    height: 255,
    fit: BoxFit.contain,
    excludeFromSemantics: true,
  );
}
