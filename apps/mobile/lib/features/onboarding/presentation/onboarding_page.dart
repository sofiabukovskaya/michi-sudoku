import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
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
  Widget build(BuildContext context) => switch (page) {
    0 => const Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: 310,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: MichiColors.coralTint,
              shape: BoxShape.circle,
            ),
          ),
        ),
        MichiMascot(
          state: MichiMascotState.calm,
          size: 275,
        ),
      ],
    ),
    1 => Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: -0.04,
          child: const CustomPaint(
            size: Size.square(260),
            painter: _ExampleGridPainter(),
          ),
        ),
        const Positioned(
          right: 0,
          bottom: 0,
          child: MichiMascot(
            state: MichiMascotState.pointing,
            size: 125,
          ),
        ),
      ],
    ),
    2 => const _PatternCards(),
    _ => const Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(320, 260),
          painter: _PathPainter(),
        ),
        MichiMascot(
          state: MichiMascotState.calm,
          size: 135,
        ),
      ],
    ),
  };
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
          (0, 'Hidden Single', -0.13, -82.0),
          (1, 'X-Wing', 0.13, 82.0),
          (2, 'Naked Pair', 0.0, 0.0),
        ])
          Transform.translate(
            offset: Offset(x, index == 2 ? -12 : 18),
            child: Transform.rotate(
              angle: angle,
              child: Container(
                width: 150,
                height: 200,
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
                      width: 110,
                      height: 110,
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

final class _PathPainter extends CustomPainter {
  const _PathPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.88)
      ..cubicTo(
        size.width * 0.45,
        size.height * 0.8,
        size.width * 0.15,
        size.height * 0.3,
        size.width * 0.6,
        size.height * 0.52,
      )
      ..cubicTo(
        size.width,
        size.height * 0.75,
        size.width * 0.5,
        size.height * 0.08,
        size.width,
        size.height * 0.12,
      );
    canvas
      ..drawPath(
        path,
        Paint()
          ..color = MichiColors.cream
          ..style = PaintingStyle.stroke
          ..strokeWidth = 28
          ..strokeCap = StrokeCap.round,
      )
      ..drawPath(
        path,
        Paint()
          ..color = MichiColors.coral
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
  }

  @override
  bool shouldRepaint(covariant _PathPainter oldDelegate) => false;
}
