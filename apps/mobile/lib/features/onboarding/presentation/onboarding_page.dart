import 'dart:async';
import 'dart:math' as math;

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
      unawaited(context.router.push(PlayerLevelRoute()));
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
        child: MichiContentFrame(
          expandedMaxHeight: 960,
          expandedAlignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.router.push(PlayerLevelRoute()),
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
        : page == 0 &&
              MichiLayout.classify(MediaQuery.sizeOf(context).width) !=
                  MichiWindowClass.compact
        ? const _CompletedDiscArt()
        : _softEdges(
            context,
            enabled: page == 3,
            child: Image.asset(
              switch (page) {
                0 => 'assets/images/onboarding_see.png',
                1 => 'assets/images/onboarding_hint.png',
                _ => 'assets/images/onboarding_path.png',
              },
              width: double.infinity,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
            ),
          ),
  );
}

/// The path illustration runs off its raster edges. Phones let it bleed off
/// the screen; inside a tablet column its ends fade instead of being cut.
Widget _softEdges(
  BuildContext context, {
  required bool enabled,
  required Widget child,
}) {
  if (!enabled ||
      MichiLayout.classify(MediaQuery.sizeOf(context).width) ==
          MichiWindowClass.compact) {
    return child;
  }
  return ShaderMask(
    blendMode: BlendMode.dstIn,
    shaderCallback: (bounds) => const LinearGradient(
      colors: [
        Color(0x00000000),
        Color(0xFF000000),
        Color(0xFF000000),
        Color(0x00000000),
      ],
      stops: [0, 0.14, 0.86, 1],
    ).createShader(bounds),
    child: child,
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

/// The first illustration's coral disc is cut by the raster edge. Phones show
/// it bleeding off the screen as approved; inside a tablet column the cut
/// reads as a mistake, so the disc is completed behind the art and the whole
/// group is centered. Geometry is measured from the 732×716 asset.
final class _CompletedDiscArt extends StatelessWidget {
  const _CompletedDiscArt();

  static const _imageWidth = 732.0;
  static const _imageHeight = 716.0;
  static const _discCenter = Offset(587, 365);
  static const _discRadius = 310.0;
  static const _discColor = Color(0xFFFAE9E1);

  /// Horizontal center of mascot-plus-disc, in image pixels.
  static const double _groupCenterX = (150 + 587 + 310) / 2;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) {
      final height = math.min(380, box.maxWidth * 0.68).toDouble();
      final scale = height / _imageHeight;
      final shift = (_groupCenterX - _imageWidth / 2) * scale;
      return SizedBox(
        width: box.maxWidth,
        height: height,
        child: Center(
          child: Transform.translate(
            offset: Offset(-shift, 0),
            child: SizedBox(
              width: _imageWidth * scale,
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: (_discCenter.dx - _discRadius) * scale,
                    top: (_discCenter.dy - _discRadius) * scale,
                    width: _discRadius * 2 * scale,
                    height: _discRadius * 2 * scale,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: _discColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/onboarding_see.png',
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
