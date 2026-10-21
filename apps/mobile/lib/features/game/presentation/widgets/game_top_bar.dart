import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

final class GameTopBar extends StatelessWidget {
  const GameTopBar({
    required this.elapsed,
    required this.paused,
    required this.onBack,
    required this.onPause,
    super.key,
  });

  final Duration elapsed;
  final bool paused;
  final VoidCallback onBack;
  final VoidCallback onPause;

  @override
  Widget build(BuildContext context) {
    final palette = MichiPalette.of(context);
    final minutes = elapsed.inMinutes.toString().padLeft(2, '0');
    final seconds = (elapsed.inSeconds % 60).toString().padLeft(2, '0');
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Semantics(
            label: MaterialLocalizations.of(context).backButtonTooltip,
            button: true,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.chevron_left),
              color: palette.textPrimary,
              iconSize: 28,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.t.game.title,
                  style: MichiTypography.meta,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$minutes:$seconds',
                  style: MichiTypography.heading,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPause,
            tooltip: paused ? context.t.game.resume : context.t.game.pause,
            icon: Icon(paused ? Icons.play_arrow_rounded : Icons.pause_rounded),
            color: palette.textPrimary,
            iconSize: 24,
          ),
        ],
      ),
    );
  }
}
