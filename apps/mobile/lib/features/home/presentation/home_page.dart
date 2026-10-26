import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';

@RoutePage()
final class HomePage extends StatefulWidget {
  const HomePage({this.repository, super.key});

  /// Tests may supply a repository; normal navigation uses DI.
  final GameRepository? repository;

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  late final GameRepository _repository;
  ActiveGameSummary? _active;
  bool _loading = true;
  bool _loadFailed = false;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? getIt<GameRepository>();
    unawaited(_reload());
  }

  Future<void> _reload() async {
    try {
      final active = await _repository.loadActiveSummary();
      if (!mounted) return;
      setState(() {
        _active = active;
        _loadFailed = false;
        _loading = false;
      });
    } on Object {
      if (!mounted) return;
      setState(() {
        _loadFailed = true;
        _loading = false;
      });
    }
  }

  Future<void> _startNew() async {
    if (_active != null) {
      final replace = await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (sheetContext) => MichiBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                sheetContext.t.home.replaceTitle,
                style: MichiTypography.heading,
              ),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                sheetContext.t.home.replaceBody,
                style: MichiTypography.secondary,
              ),
              const SizedBox(height: MichiSpacing.xl),
              MichiButton(
                label: sheetContext.t.home.keepPlaying,
                variant: MichiButtonVariant.secondary,
                onPressed: () => Navigator.of(sheetContext).pop(false),
              ),
              const SizedBox(height: MichiSpacing.sm),
              MichiButton(
                label: sheetContext.t.home.startNew,
                onPressed: () => Navigator.of(sheetContext).pop(true),
              ),
            ],
          ),
        ),
      );
      if (replace != true || !mounted) return;
    }
    await context.router.push(GameRoute(repository: _repository));
    if (mounted) await _reload();
  }

  Future<void> _continue() async {
    await context.router.push(
      GameRoute(restore: true, repository: _repository),
    );
    if (mounted) await _reload();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(context.t.appName)),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(MichiSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.t.home.title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: MichiSpacing.xxl),
            MichiButton(
              label: context.t.home.game,
              onPressed: _loading ? null : _startNew,
            ),
            if (_loading) ...[
              const SizedBox(height: MichiSpacing.lg),
              Text(context.t.home.loading, style: MichiTypography.secondary),
            ] else if (_active case final summary?) ...[
              const SizedBox(height: MichiSpacing.lg),
              _ContinueCard(summary: summary, onTap: _continue),
            ] else if (_loadFailed) ...[
              const SizedBox(height: MichiSpacing.lg),
              Text(context.t.home.storageUnavailable),
            ],
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.learn,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const LearnRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.progress,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProgressRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.profile,
              variant: MichiButtonVariant.secondary,
              onPressed: () => context.router.push(const ProfileRoute()),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              label: context.t.home.scanner,
              variant: MichiButtonVariant.text,
              onPressed: () => context.router.push(const ScannerRoute()),
            ),
          ],
        ),
      ),
    ),
  );
}

final class _ContinueCard extends StatelessWidget {
  const _ContinueCard({required this.summary, required this.onTap});

  final ActiveGameSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final elapsed = summary.elapsed;
    final time =
        '${elapsed.inMinutes.toString().padLeft(2, '0')}:'
        '${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
    final started = MaterialLocalizations.of(context).formatMediumDate(
      summary.startedAt.toLocal(),
    );
    return InkWell(
      key: const ValueKey('continue-game'),
      onTap: onTap,
      borderRadius: BorderRadius.circular(MichiRadius.control),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MichiSpacing.md),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: MichiColors.ivory,
                borderRadius: BorderRadius.circular(MichiRadius.small),
                border: Border.all(color: MichiColors.hairline),
              ),
              child: const SizedBox.square(
                dimension: 48,
                child: Icon(Icons.grid_on_rounded, color: MichiColors.indigo),
              ),
            ),
            const SizedBox(width: MichiSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.home.continueGame,
                    style: MichiTypography.body,
                  ),
                  Text(
                    context.t.home.continueDetails(
                      date: started,
                      progress: (summary.progress * 100).round(),
                      time: time,
                    ),
                    style: MichiTypography.secondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
