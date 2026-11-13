import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

final class _OnboardingPageState extends State<OnboardingPage> {
  int _page = 0;

  void _next() {
    if (_page == 3) {
      unawaited(context.router.push(const PlayerLevelRoute()));
      return;
    }
    setState(() => _page++);
  }

  @override
  Widget build(BuildContext context) {
    final dark = _page == 1;
    final titles = [
      context.t.onboarding.seeTitle,
      context.t.onboarding.hintsTitle,
      context.t.onboarding.patternsTitle,
      context.t.onboarding.pathTitle,
    ];
    final subtitles = [
      context.t.onboarding.seeBody,
      context.t.onboarding.hintsBody,
      context.t.onboarding.patternsBody,
      context.t.onboarding.pathBody,
    ];
    return Scaffold(
      backgroundColor: dark ? MichiColors.indigo : MichiColors.paper,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.router.push(const PlayerLevelRoute()),
                  child: Text(
                    context.t.onboarding.skip,
                    style: MichiTypography.body.copyWith(
                      color: dark
                          ? MichiColors.ivory
                          : MichiColors.textSecondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(child: _OnboardingArt(page: _page)),
              ),
              Text(
                titles[_page],
                style: MichiTypography.display.copyWith(
                  color: dark ? MichiColors.ivory : MichiColors.textPrimary,
                ),
              ),
              const SizedBox(height: MichiSpacing.md),
              Text(
                subtitles[_page],
                style: MichiTypography.body.copyWith(
                  color: dark ? MichiColors.ivory : MichiColors.textSecondary,
                ),
              ),
              const SizedBox(height: MichiSpacing.huge),
              Row(
                children: [
                  for (var index = 0; index < 4; index++) ...[
                    Icon(
                      Icons.pets,
                      size: 16,
                      color: index <= _page
                          ? MichiColors.coral
                          : dark
                          ? const Color(0xFF97A3AD)
                          : MichiColors.boardBoxLine,
                    ),
                    const SizedBox(width: MichiSpacing.xs),
                  ],
                  const Spacer(),
                  SizedBox(
                    width: 124,
                    child: MichiButton(
                      label: _page == 3
                          ? context.t.common.start
                          : context.t.onboarding.next,
                      variant: dark
                          ? MichiButtonVariant.secondary
                          : MichiButtonVariant.primary,
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _OnboardingArt extends StatelessWidget {
  const _OnboardingArt({required this.page});

  final int page;

  @override
  Widget build(BuildContext context) => MichiReveal(
    key: ValueKey(page),
    child: page == 2
        ? const _PatternCards()
        : Image.asset(
            switch (page) {
              0 => 'assets/images/onboarding_see.png',
              1 => 'assets/images/onboarding_hint.png',
              _ => 'assets/images/onboarding_path.png',
            },
            width: double.infinity,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
  );
}

final class _PatternCards extends StatelessWidget {
  const _PatternCards();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 260,
    child: Stack(
      alignment: Alignment.center,
      children: [
        for (final (index, title, angle, x) in [
          (0, context.t.coach.hiddenSingle, -0.13, -82.0),
          (1, context.t.coach.xWing, 0.13, 82.0),
          (2, context.t.coach.nakedPair, 0.0, 0.0),
        ])
          Transform.translate(
            offset: Offset(x, index == 2 ? -12 : 18),
            child: Transform.rotate(
              angle: angle,
              child: Container(
                width: 150,
                height: 204,
                padding: const EdgeInsets.all(MichiSpacing.md),
                decoration: BoxDecoration(
                  color: MichiColors.ivory,
                  borderRadius: BorderRadius.circular(MichiRadius.card),
                  border: Border.all(color: MichiColors.textPrimary),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 98,
                      height: 98,
                      child: CustomPaint(painter: _ExampleGridPainter()),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: MichiTypography.meta.copyWith(
                        color: MichiColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

final class _ExampleGridPainter extends CustomPainter {
  const _ExampleGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = MichiColors.ivory);
    final thin = Paint()..color = MichiColors.boardCellLine;
    final thick = Paint()
      ..color = MichiColors.boardBoxLine
      ..strokeWidth = 2;
    for (var index = 0; index <= 9; index++) {
      final position = index * size.width / 9;
      final paint = index % 3 == 0 ? thick : thin;
      canvas
        ..drawLine(Offset(position, 0), Offset(position, size.height), paint)
        ..drawLine(Offset(0, position), Offset(size.width, position), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ExampleGridPainter oldDelegate) => false;
}
