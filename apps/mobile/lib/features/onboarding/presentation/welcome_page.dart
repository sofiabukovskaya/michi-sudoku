import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: MichiWordmark(),
                  ),
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
                ],
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
  Widget build(BuildContext context) => SizedBox(
    height: 255,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: 0,
          top: 16,
          child: Transform.rotate(
            angle: -math.pi / 28,
            child: const CustomPaint(
              size: Size(225, 225),
              painter: _WelcomeBoardPainter(),
            ),
          ),
        ),
        Positioned(
          right: -10,
          bottom: -4,
          child: Image.asset(
            'assets/images/coach_mascot.png',
            width: 187,
            height: 187,
            excludeFromSemantics: true,
          ),
        ),
      ],
    ),
  );
}

final class _WelcomeBoardPainter extends CustomPainter {
  const _WelcomeBoardPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final board = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(18),
    );
    canvas
      ..drawRRect(board, Paint()..color = MichiColors.ivory)
      ..drawRRect(
        board,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = MichiColors.textPrimary,
      );
    final linePaint = Paint()
      ..color = MichiColors.boardBoxLine
      ..strokeWidth = 1;
    for (var index = 1; index < 3; index++) {
      final offset = size.width * index / 3;
      canvas
        ..drawLine(
          Offset(offset, 0),
          Offset(offset, size.height),
          linePaint,
        )
        ..drawLine(
          Offset(0, offset),
          Offset(size.width, offset),
          linePaint,
        );
    }
    void number(String value, Offset offset) {
      TextPainter(
          text: TextSpan(
            text: value,
            style: MichiTypography.heading.copyWith(fontSize: 30),
          ),
          textDirection: TextDirection.ltr,
        )
        ..layout()
        ..paint(canvas, offset);
    }

    number('3', const Offset(27, 24));
    number('7', const Offset(96, 92));
    number('1', const Offset(170, 167));
    canvas.drawCircle(
      const Offset(190, 42),
      24,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = MichiColors.coral,
    );
  }

  @override
  bool shouldRepaint(covariant _WelcomeBoardPainter oldDelegate) => false;
}
