import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/progress/domain/weekly_activity.dart';
import 'package:michi_mobile/features/puzzle/domain/daily_puzzle.dart';
import 'package:michi_mobile/features/puzzle/domain/local_date.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_repository.dart';
import 'package:michi_mobile/features/recommendation/application/learning_recommendation_service.dart';
import 'package:michi_mobile/features/recommendation/domain/learning_recommendation.dart';
import 'package:michi_mobile/features/recommendation/presentation/recommendation_copy.dart';
import 'package:michi_mobile/features/scanner/application/scanner_cubit.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class HomePage extends StatefulWidget {
  const HomePage({
    this.repository,
    this.puzzleRepository,
    this.clock,
    this.recommendationService,
    super.key,
  });

  /// Tests may supply a repository; normal navigation uses DI.
  final GameRepository? repository;
  final PuzzleRepository? puzzleRepository;
  final GameClock? clock;
  final LearningRecommendationService? recommendationService;

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final GameRepository _repository;
  late final PuzzleRepository _puzzles;
  late final GameClock _clock;
  LearningRecommendationService? _recommendations;
  LearningRecommendation? _focus;
  ActiveGameSummary? _active;
  DailyPuzzle? _daily;
  WeeklyActivity? _week;
  bool _dailyCompleted = false;
  bool _dailyLoading = true;
  bool _dailyFailed = false;
  bool _loading = true;
  bool _loadFailed = false;
  int _reloadSequence = 0;
  SyncCoordinator? _sync;
  int _syncRevision = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _repository = widget.repository ?? getIt<GameRepository>();
    _puzzles = widget.puzzleRepository ?? getIt<PuzzleRepository>();
    _clock = widget.clock ?? getIt<GameClock>();
    // Tests and embedded routes can supply isolated repositories without
    // constructing the production Drift connection.
    _recommendations =
        widget.recommendationService ??
        (widget.repository == null
            ? getIt<LearningRecommendationService>()
            : null);
    unawaited(_reload());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_reload());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sync = context.read<SyncCoordinator?>();
    if (identical(_sync, sync)) return;
    _sync?.removeListener(_onSynced);
    _sync = sync;
    _syncRevision = sync?.dataRevision ?? 0;
    sync?.addListener(_onSynced);
  }

  void _onSynced() {
    final revision = _sync?.dataRevision ?? 0;
    if (revision == _syncRevision) return;
    _syncRevision = revision;
    unawaited(_reload());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _sync?.removeListener(_onSynced);
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
      unawaited(_loadFocus(sequence));
      unawaited(_loadWeek(sequence));
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

  Future<void> _loadFocus(int sequence) async {
    final service = _recommendations;
    if (service == null) return;
    final focus = await service.today();
    if (!mounted || sequence != _reloadSequence) return;
    setState(() => _focus = focus);
  }

  Future<void> _loadWeek(int sequence) async {
    try {
      final games = await _repository.loadRecentCompletedGames(limit: 1000);
      if (!mounted || sequence != _reloadSequence) return;
      setState(() => _week = WeeklyActivity.current(_clock.now(), games));
    } on Object catch (error, stackTrace) {
      developer.log(
        'Unable to load weekly activity',
        name: 'michi.home',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _openFocus() async {
    final focus = _focus;
    if (focus == null) return;
    await openRecommendation(context, focus);
    if (mounted) await _reload();
  }

  Future<void> _startNew() async {
    final choice = await showModalBottomSheet<Object>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => MichiBottomSheet(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.8,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  sheetContext.t.home.newPuzzleTitle,
                  style: MichiTypography.heading,
                ),
                const SizedBox(height: MichiSpacing.sm),
                Text(
                  sheetContext.t.home.catalogSource,
                  style: MichiTypography.secondary,
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
                const SizedBox(height: MichiSpacing.sm),
                MichiButton(
                  key: const ValueKey('difficulty-advanced'),
                  label: sheetContext.t.home.advanced,
                  variant: MichiButtonVariant.secondary,
                  onPressed: () =>
                      Navigator.of(sheetContext).pop(PuzzleDifficulty.advanced),
                ),
                const SizedBox(height: MichiSpacing.sm),
                MichiButton(
                  key: const ValueKey('difficulty-expert'),
                  label: sheetContext.t.home.expert,
                  variant: MichiButtonVariant.secondary,
                  onPressed: () =>
                      Navigator.of(sheetContext).pop(PuzzleDifficulty.expert),
                ),
                const SizedBox(height: MichiSpacing.lg),
                const Divider(color: MichiColors.hairline),
                const SizedBox(height: MichiSpacing.sm),
                Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    key: const ValueKey('scan-sudoku'),
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.document_scanner_outlined),
                    title: Text(sheetContext.t.home.scanSource),
                    subtitle: Text(sheetContext.t.home.scanSourceDetail),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => Navigator.of(sheetContext).pop('scanner'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    if (choice == null || !mounted) return;
    if (choice == 'scanner') {
      if (!await _confirmReplacement() || !mounted) return;
      await context.router.root.push(
        ScannerRoute(cubit: getIt<ScannerCubit>()),
      );
      if (mounted) await _reload();
      return;
    }
    final difficulty = choice as PuzzleDifficulty;
    try {
      final puzzle = await _puzzles.selectPuzzle(difficulty: difficulty);
      if (!mounted || !await _confirmReplacement()) return;
      if (!mounted) return;
      await context.router.root.push(
        GameRoute(
          definition: puzzle,
          repository: _repository,
          recommendationService: _recommendations,
        ),
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
      await context.router.root.push(
        GameRoute(
          definition: daily.puzzle,
          dailyChallengeKey: daily.challengeKey,
          repository: _repository,
          recommendationService: _recommendations,
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
    await context.router.root.push(
      GameRoute(
        restore: true,
        repository: _repository,
        recommendationService: _recommendations,
      ),
    );
    if (mounted) await _reload();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: MichiWordmark(),
              ),
              const SizedBox(height: MichiSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  context.t.home.greeting,
                  style: MichiTypography.display,
                ),
              ),
              const SizedBox(height: MichiSpacing.xl),
              if (_loading) ...[
                const SizedBox(height: MichiSpacing.sm),
                Text(context.t.home.loading, style: MichiTypography.secondary),
              ] else if (_loadFailed) ...[
                const SizedBox(height: MichiSpacing.lg),
                Text(context.t.home.storageUnavailable),
              ],
              if (!_loading && !_loadFailed && _daily != null) ...[
                const SizedBox(height: MichiSpacing.sm),
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
              if (!_loading &&
                  _active != null &&
                  (_active!.dailyChallengeKey == null ||
                      _active!.dailyChallengeKey != _daily?.challengeKey)) ...[
                const SizedBox(height: MichiSpacing.sm),
                _ContinueCard(summary: _active!, onTap: _continue),
              ],
              if (_focus case final focus?) ...[
                const SizedBox(height: MichiSpacing.sm),
                _FocusRow(recommendation: focus, onTap: _openFocus),
              ],
              const SizedBox(height: MichiSpacing.sm),
              _HomeActionRow(
                label: context.t.home.newPuzzle,
                onTap: _loading || _loadFailed ? null : _startNew,
              ),
              const SizedBox(height: MichiSpacing.xxl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.t.home.weekTitle,
                        style: MichiTypography.heading,
                      ),
                    ),
                    TextButton(
                      key: const ValueKey('week-details'),
                      onPressed: () => context.router.root.push(
                        WeekRoute(games: _repository, clock: _clock),
                      ),
                      child: Text(context.t.home.weekDetails),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: MichiSpacing.md),
              _WeekStrip(
                todayIndex: _clock.now().toLocal().weekday - 1,
                activity: _week,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

final class _FocusRow extends StatelessWidget {
  const _FocusRow({required this.recommendation, required this.onTap});

  final LearningRecommendation recommendation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final title = t.recommendation.focusTitle(
      technique: TechniqueCopy.name(t, recommendation.technique),
    );
    final detail = RecommendationCopy.detail(t, recommendation);
    return Semantics(
      button: true,
      label: '$title. ${RecommendationCopy.action(t, recommendation)}. $detail',
      child: InkWell(
        key: const ValueKey('daily-learning-focus'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MichiSpacing.md),
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: MichiColors.coralTint,
                  borderRadius: BorderRadius.circular(MichiRadius.small),
                ),
                child: const SizedBox.square(
                  dimension: 48,
                  child: Icon(Icons.pets, color: MichiColors.coralText),
                ),
              ),
              const SizedBox(width: MichiSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MichiTypography.body.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MichiTypography.secondary,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

final class _HomeActionRow extends StatelessWidget {
  const _HomeActionRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        vertical: MichiSpacing.md,
        horizontal: MichiSpacing.sm,
      ),
      child: Row(
        children: [
          const SizedBox.square(
            dimension: 48,
            child: Icon(Icons.grid_on_outlined, color: MichiColors.indigo),
          ),
          const SizedBox(width: MichiSpacing.md),
          Expanded(
            child: Text(
              label,
              style: MichiTypography.body.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: MichiColors.textSecondary,
          ),
        ],
      ),
    ),
  );
}

final class _WeekStrip extends StatelessWidget {
  const _WeekStrip({required this.todayIndex, required this.activity});

  final int todayIndex;
  final WeeklyActivity? activity;

  String _statusLabel(BuildContext context, int index, String weekday) {
    final status = activity?.days[index].isActive == true
        ? context.t.home.weekStatusDone
        : context.t.home.weekStatusEmpty;
    return index == todayIndex
        ? '$weekday, ${context.t.home.weekStatusToday}, $status'
        : '$weekday, $status';
  }

  @override
  Widget build(BuildContext context) {
    final labels = context.t.home.weekdaysShort.split('|');
    return Row(
      children: [
        for (var index = 0; index < 7; index++)
          Expanded(
            child: Semantics(
              label: _statusLabel(context, index, labels[index]),
              child: ExcludeSemantics(
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: activity?.days[index].isActive == true
                            ? MichiColors.indigo
                            : MichiColors.cream,
                        border: index == todayIndex
                            ? Border.all(color: MichiColors.indigo, width: 2)
                            : null,
                      ),
                      child: SizedBox.square(
                        dimension: 30,
                        child: activity?.days[index].isActive == true
                            ? const Icon(
                                Icons.pets,
                                size: 16,
                                color: MichiColors.ivory,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: MichiSpacing.xs),
                    Text(labels[index], style: MichiTypography.meta),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
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
    final difficulty = switch (daily.puzzle.difficulty) {
      PuzzleDifficulty.easy => context.t.home.easy,
      PuzzleDifficulty.medium => context.t.home.medium,
      PuzzleDifficulty.advanced => context.t.home.advanced,
      PuzzleDifficulty.expert => context.t.home.expert,
      null => throw StateError('Daily catalog puzzle has no difficulty.'),
    };
    final techniques = daily.puzzle.requiredTechniques
        .where((technique) => technique != SudokuTechnique.nakedSingle)
        .map((technique) => _techniqueName(context, technique))
        .join(' · ');
    return Semantics(
      label: '${context.t.home.dailyTitle}, $label',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: MichiColors.indigo,
          borderRadius: BorderRadius.circular(MichiRadius.hero),
        ),
        child: Padding(
          padding: const EdgeInsets.all(MichiSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 138),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 110),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            style: MichiTypography.editorialTitle.copyWith(
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
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: MichiMascot(
                        state: MichiMascotState.calm,
                        size: 126,
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
                SizedBox(
                  width: double.infinity,
                  child: MichiButton(
                    key: const ValueKey('daily-action'),
                    label: label,
                    variant: MichiButtonVariant.secondary,
                    onPressed: onTap,
                  ),
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
        SudokuTechnique.hiddenPair => context.t.coach.hiddenPair,
        SudokuTechnique.boxLineReduction => context.t.coach.boxLineReduction,
        SudokuTechnique.nakedTriple => context.t.coach.nakedTriple,
        SudokuTechnique.xWing => context.t.coach.xWing,
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
