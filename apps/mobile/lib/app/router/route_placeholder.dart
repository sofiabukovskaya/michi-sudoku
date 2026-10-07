import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

/// Consistent shell for Phase 1 routes; replaced by feature UI later.
final class RoutePlaceholder extends StatelessWidget {
  const RoutePlaceholder({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.t.appName)),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(title, style: Theme.of(context).textTheme.displayLarge),
            if (subtitle != null) ...[
              const SizedBox(height: MichiSpacing.lg),
              Text(subtitle!, style: Theme.of(context).textTheme.bodyLarge),
            ],
            const Spacer(),
            if (actionLabel != null)
              MichiButton(label: actionLabel!, onPressed: onAction),
          ],
        ),
      ),
    ),
  );
}
