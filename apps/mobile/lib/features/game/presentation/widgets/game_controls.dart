import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/application/game_state.dart';

final class GameControls extends StatelessWidget {
  const GameControls({
    required this.state,
    required this.onUndo,
    required this.onErase,
    required this.onToggleNotes,
    required this.onHint,
    super.key,
  });

  final GameState state;
  final VoidCallback onUndo;
  final VoidCallback onErase;
  final VoidCallback onToggleNotes;
  final VoidCallback onHint;

  @override
  Widget build(BuildContext context) {
    final t = context.t.game;
    return Row(
      children: [
        _Control(
          label: t.undo,
          icon: Icons.undo_rounded,
          onTap: state.canUndo ? onUndo : null,
          key: const ValueKey('undo-control'),
        ),
        _Control(
          label: t.erase,
          icon: Icons.backspace_outlined,
          onTap: state.canErase ? onErase : null,
          key: const ValueKey('erase-control'),
        ),
        _Control(
          label: t.notes,
          icon: Icons.edit_outlined,
          selected: state.notesMode,
          onTap: onToggleNotes,
          key: const ValueKey('notes-control'),
        ),
        _Control(
          label: t.hint,
          icon: Icons.lightbulb_outline_rounded,
          asset: 'assets/images/hint_icon.png',
          onTap: onHint,
          key: const ValueKey('hint-control'),
        ),
      ],
    );
  }
}

final class _Control extends StatelessWidget {
  const _Control({
    required this.label,
    required this.icon,
    required this.onTap,
    this.asset,
    this.selected = false,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final String? asset;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final palette = MichiPalette.of(context);
    final color = onTap == null
        ? palette.disabledText
        : selected
        ? palette.indigo
        : palette.textPrimary;
    return Expanded(
      child: Semantics(
        button: true,
        enabled: onTap != null,
        selected: selected,
        label: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(MichiRadius.control),
          child: SizedBox(
            height: 66,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 56,
                  height: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selected ? MichiColors.indigoTint : null,
                      borderRadius: BorderRadius.circular(MichiRadius.small),
                    ),
                    child: asset == null
                        ? Icon(icon, color: color, size: 25)
                        : Image.asset(
                            asset!,
                            width: 40,
                            height: 40,
                            excludeFromSemantics: true,
                          ),
                  ),
                ),
                const SizedBox(height: MichiSpacing.xs),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: MichiTypography.meta.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
