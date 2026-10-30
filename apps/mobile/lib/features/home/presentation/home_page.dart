import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class HomePage extends StatefulWidget {
  const HomePage({
    this.repository,
    this.puzzleRepository,
    this.clock,
    super.key,
  });

  /// Tests may supply a repository; normal navigation uses DI.
  final GameRepository? repository;
  final PuzzleRepository? puzzleRepository;
  final GameClock? clock;

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final GameRepository _repository;
  late final PuzzleRepository _puzzles;
  late final GameClock _clock;
  ActiveGameSummary? _active;
  DailyPuzzle? _daily;
  bool _dailyCompleted = false;
  bool _dailyLoading = true;
  bool _dailyFailed = false;
  bool _loading = true;
  bool _loadFailed = false;
  int _reloadSequence = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _repository = widget.repository ?? getIt<GameRepository>();
    _puzzles = widget.puzzleRepository ?? getIt<PuzzleRepository>();
    _clock = widget.clock ?? getIt<GameClock>();
    unawaited(_reload());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_reload());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _reload() async {
    final sequence = ++_reloadSequence;
    if (mounted) {
      setState(() {
        _daily = null;
        _dailyLoading = true;
        _dailyFailed = false;
      });
    }
    try {
      final active = await _repository.loadActiveSummary();
      if (!mounted || sequence != _reloadSequence) return;
      setState(() {
        _active = active;
        _loadFailed = false;
        _loading = false;
      });
    } on Object catch (error, stackTrace) {
      developer.log(
        'Unable to load Home content',
        name: 'michi.home',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted || sequence != _reloadSequence) return;
      setState(() {
        _loadFailed = true;
        _loading = false;
        _dailyLoading = false;
      });
      return;
    }
    try {
      final daily = await _puzzles.getDailyPuzzle(
        LocalDate.fromDateTime(_clock.now()),
      );
      final completed = await _repository.isDailyCompleted(daily.challengeKey);
      if (!mounted || sequence != _reloadSequence) return;
      setState(() {
        _daily = daily;
        _dailyCompleted = completed;
        _dailyLoading = false;
      });
    } on Object catch (error, stackTrace) {
      developer.log(
        'Unable to load bundled Daily content',
        name: 'michi.home',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted || sequence != _reloadSequence) return;
      setState(() {
        _dailyLoading = false;
        _dailyFailed = true;
      });
    }
  }

  Future<void> _startNew() async {
    final difficulty = await showModalBottomSheet<PuzzleDifficulty>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => MichiBottomSheet(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              sheetContext.t.home.chooseDifficulty,
              style: MichiTypography.heading,
            ),
            const SizedBox(height: MichiSpacing.lg),
            MichiButton(
              key: const ValueKey('difficulty-easy'),
              label: sheetContext.t.home.easy,
              onPressed: () =>
                  Navigator.of(sheetContext).pop(PuzzleDifficulty.easy),
            ),
            const SizedBox(height: MichiSpacing.sm),
            MichiButton(
              key: const ValueKey('difficulty-medium'),
              label: sheetContext.t.home.medium,
              variant: MichiButtonVariant.secondary,
              onPressed: () =>
                  Navigator.of(sheetContext).pop(PuzzleDifficulty.medium),
            ),
          ],
        ),
      ),
    );
    if (difficulty == null || !mounted) return;
    try {
      final puzzle = await _puzzles.selectPuzzle(difficulty: difficulty);
      if (!mounted || !await _confirmReplacement()) return;
      if (!mounted) return;
      await context.router.push(
        GameRoute(definition: puzzle, repository: _repository),
      );
      if (mounted) await _reload();
    } on Object {
      if (mounted) _showContentError();
    }
  }

  Future<void> _startDaily() async {
    final daily = _daily;
    if (daily == null || _dailyCompleted) return;
    if (_active?.dailyChallengeKey == daily.challengeKey) {
      await _continue();
      return;
    }
    if (!await _confirmReplacement() || !mounted) return;
    try {
      await context.router.push(
        GameRoute(
          definition: daily.puzzle,
          dailyChallengeKey: daily.challengeKey,
          repository: _repository,
        ),
      );
      if (mounted) await _reload();
    } on Object {
      if (mounted) _showContentError();
    }
  }

  void _showContentError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.t.home.contentUnavailable)),
    );
  }

  Future<bool> _confirmReplacement() async {
    if (_active == null) return true;
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
      return replace == true && mounted;
    }
    return true;
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
      child: SingleChildScrollView(
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
                onPressed: _loading || _loadFailed ? null : _startNew,
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
              if (!_loading && !_loadFailed && _daily != null) ...[
                const SizedBox(height: MichiSpacing.xl),
                _DailyCard(
                  daily: _daily!,
                  completed: _dailyCompleted,
                  inProgress:
                      _active?.dailyChallengeKey == _daily!.challengeKey,
                  onTap: _startDaily,
                ),
              ],
              if (!_loading && _dailyLoading) ...[
                const SizedBox(height: MichiSpacing.xl),
                Text(context.t.home.loading, style: MichiTypography.secondary),
              ],
              if (_dailyFailed) ...[
                const SizedBox(height: MichiSpacing.xl),
                Text(
                  context.t.home.contentUnavailable,
                  style: MichiTypography.secondary,
                ),
              ],
              const SizedBox(height: MichiSpacing.sm),
              MichiButton(
                label: context.t.home.learn,
                variant: MichiButtonVariant.secondary,
                onPressed: () => context.router.push(LearnRoute()),
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
    ),
  );
}

final class _DailyCard extends StatelessWidget {
  const _DailyCard({
    required this.daily,
    required this.completed,
    required this.inProgress,
    required this.onTap,
  });

  final DailyPuzzle daily;
  final bool completed;
  final bool inProgress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = completed
        ? context.t.home.dailyCompleted
        : inProgress
        ? context.t.home.dailyContinue
        : context.t.home.dailyStart;
    final difficulty = daily.puzzle.difficulty == PuzzleDifficulty.easy
        ? context.t.home.easy
        : context.t.home.medium;
    final techniques = daily.puzzle.requiredTechniques
        .where((technique) => technique != SudokuTechnique.nakedSingle)
        .map((technique) => _techniqueName(context, technique))
        .join(' · ');
    return Semantics(
      label: '${context.t.home.dailyTitle}, $label',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MichiColors.indigo,
          borderRadius: BorderRadius.circular(MichiRadius.card),
        ),
        child: Padding(
          padding: const EdgeInsets.all(MichiSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 184,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${context.t.home.dailyTitle} · ${daily.date}',
                            style: MichiTypography.meta.copyWith(
                              color: MichiColors.ivory,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(height: MichiSpacing.sm),
                          Text(
                            difficulty,
                            style: MichiTypography.display.copyWith(
                              color: MichiColors.ivory,
                            ),
                          ),
                          const SizedBox(height: MichiSpacing.sm),
                          if (techniques.isNotEmpty)
                            Text(
                              techniques,
                              style: MichiTypography.secondary.copyWith(
                                color: MichiColors.ivory,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'assets/images/coach_mascot.png',
                        width: 118,
                        height: 142,
                        fit: BoxFit.contain,
                        excludeFromSemantics: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MichiSpacing.sm),
              if (completed)
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: MichiColors.cream,
                    borderRadius: BorderRadius.circular(MichiRadius.control),
                  ),
                  child: SizedBox(
                    height: 52,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_rounded),
                        const SizedBox(width: MichiSpacing.xs),
                        Text(label, style: MichiTypography.body),
                      ],
                    ),
                  ),
                )
              else
                MichiButton(
                  key: const ValueKey('daily-action'),
                  label: label,
                  variant: MichiButtonVariant.secondary,
                  onPressed: onTap,
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _techniqueName(BuildContext context, SudokuTechnique technique) =>
      switch (technique) {
        SudokuTechnique.nakedSingle => context.t.coach.nakedSingle,
        SudokuTechnique.hiddenSingle => context.t.coach.hiddenSingle,
        SudokuTechnique.nakedPair => context.t.coach.nakedPair,
        SudokuTechnique.pointingPair => context.t.coach.pointingPair,
        _ => technique.name,
      };
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
