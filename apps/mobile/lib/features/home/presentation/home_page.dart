import 'dart:async';
import 'dart:developer' as developer;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/navigation/active_tab_tickers.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/app/widgets/michi_reveal.dart';
import 'package:michi_mobile/app/widgets/michi_wordmark.dart';
import 'package:michi_mobile/app/widgets/mini_board.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/core/time/game_clock.dart';
import 'package:michi_mobile/features/game/application/game_preparation.dart';
import 'package:michi_mobile/features/game/domain/game_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/onboarding/data/onboarding_store.dart';
import 'package:michi_mobile/features/progress/domain/daily_streak.dart';
import 'package:michi_mobile/features/progress/domain/weekly_activity.dart';
import 'package:michi_mobile/features/puzzle/data/published_puzzle_repository.dart';
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
    this.launchAction,
    this.recommendationService,
    super.key,
  });

  /// Tests may supply a repository; normal navigation uses DI.
  final GameRepository? repository;
  final PuzzleRepository? puzzleRepository;
  final GameClock? clock;
  final String? launchAction;
  final LearningRecommendationService? recommendationService;

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late final GameRepository _repository;
  late final PuzzleRepository _puzzles;
  late final GameClock _clock;
  final OnboardingStore _onboarding = OnboardingStore();
  LearningRecommendationService? _recommendations;
  LearningRecommendation? _focus;
  ActiveGameSummary? _active;
  DailyPuzzle? _daily;
  WeeklyActivity? _week;
  int _streak = 0;
  StoredGame? _activeGame;
  bool _dailyCompleted = false;
  bool _dailyFailed = false;
  bool _loading = true;
  bool _loadFailed = false;
  int _reloadSequence = 0;
  bool _handledLaunch = false;

  Future<void> _handleLaunch() async {
    if (!mounted || _handledLaunch || widget.launchAction == null) return;
    _handledLaunch = true;
    switch (widget.launchAction) {
      case 'daily':
        await _startDaily();
      case 'continue':
        if (_active != null) await _continue();
      case 'scan':
        await _openScanner();
    }
  }

  Future<void> _openScanner() async {
    await context.router.root.push(
      ScannerRoute(
        cubit: getIt<ScannerCubit>(),
        beforeImport: _confirmReplacement,
      ),
    );
    if (mounted) await _reload();
  }

  SyncCoordinator? _sync;
  int _syncRevision = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _repository = widget.repository ?? getIt<GameRepository>();
    _puzzles = widget.puzzleRepository ?? getIt<PuzzleRepository>();
    if (_puzzles case final PublishedPuzzleRepository published) {
      unawaited(published.refresh());
    }
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

  /// Loads Home without staged flicker: the Daily card keeps its exact
  /// size while loading, rows never appear and then vanish, and a
  /// background refresh (resume, sync, return from a game) updates content
  /// in place without clearing what is shown.
  Future<void> _reload() async {
    final sequence = ++_reloadSequence;
    try {
      final active = await _repository.loadActiveSummary();
      if (!mounted || sequence != _reloadSequence) return;
      setState(() {
        _active = active;
        _loadFailed = false;
        _loading = false;
      });
      if (active != null) unawaited(_loadActiveBoard(sequence));
      if (widget.launchAction != 'daily') unawaited(_handleLaunch());
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
        _dailyFailed = false;
      });
      if (widget.puzzleRepository == null &&
          getIt.isRegistered<GamePreparation>()) {
        // Warm only the visible Daily; failures are handled by Game's error UI.
        unawaited(
          getIt<GamePreparation>()
              .prepare(daily.puzzle.initialBoard)
              .then<void>((_) {}, onError: (Object _, StackTrace _) {}),
        );
      }
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        unawaited(_publishDaily(daily));
      }
      unawaited(_handleLaunch());
    } on Object catch (error, stackTrace) {
      developer.log(
        'Unable to load bundled Daily content',
        name: 'michi.home',
        error: error,
        stackTrace: stackTrace,
      );
      if (!mounted || sequence != _reloadSequence) return;
      // A failed refresh keeps a Daily that is already shown.
      if (_daily == null) setState(() => _dailyFailed = true);
    }
  }

  Future<void> _publishDaily(DailyPuzzle daily) async {
    try {
      await const MethodChannel('michi/daily').invokeMethod<void>('publish', {
        'day': daily.date.toString(),
        'difficulty': daily.puzzle.difficulty?.name,
      });
    } on MissingPluginException {
      // Widget extensions are optional in embedded/test runners.
    } on PlatformException catch (error) {
      developer.log('Daily widget update unavailable', error: error);
    }
  }

  Future<void> _loadFocus(int sequence) async {
    final service = _recommendations;
    if (service == null) return;
    final focus = await service.today();
    if (!mounted || sequence != _reloadSequence) return;
    setState(() => _focus = focus);
  }

  /// The saved board makes the Continue row's thumbnail truthful.
  Future<void> _loadActiveBoard(int sequence) async {
    try {
      final game = await _repository.loadActiveGame();
      if (!mounted || sequence != _reloadSequence) return;
      setState(() => _activeGame = game);
    } on Object {
      // The row stays usable with its plain tile.
    }
  }

  Future<void> _loadWeek(int sequence) async {
    try {
      final games = await _repository.loadRecentCompletedGames(limit: 1000);
      if (!mounted || sequence != _reloadSequence) return;
      final now = _clock.now();
      setState(() {
        _week = WeeklyActivity.current(now, games);
        _streak = DailyStreak.count(now, games);
      });
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
    final suggested = OnboardingStore.suggestedDifficulty(
      await _onboarding.level(),
    );
    if (!mounted) return;
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
                for (final (difficulty, label) in [
                  (PuzzleDifficulty.easy, sheetContext.t.home.easy),
                  (PuzzleDifficulty.medium, sheetContext.t.home.medium),
                  (PuzzleDifficulty.advanced, sheetContext.t.home.advanced),
                  (PuzzleDifficulty.expert, sheetContext.t.home.expert),
                ]) ...[
                  if (difficulty != PuzzleDifficulty.easy)
                    const SizedBox(height: MichiSpacing.sm),
                  // The level chosen in onboarding is the filled default.
                  MichiButton(
                    key: ValueKey('difficulty-${difficulty.name}'),
                    label: label,
                    variant: difficulty == suggested
                        ? MichiButtonVariant.primary
                        : MichiButtonVariant.secondary,
                    onPressed: () => Navigator.of(sheetContext).pop(difficulty),
                  ),
                ],
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
      await _openScanner();
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

  Widget _focusRow(Translations t, LearningRecommendation focus) {
    final title = t.recommendation.focusTitle(
      technique: TechniqueCopy.name(t, focus.technique),
    );
    final detail = RecommendationCopy.detail(t, focus);
    return MichiReveal(
      key: ValueKey(focus.technique),
      child: MichiListRow(
        key: const ValueKey('daily-learning-focus'),
        icon: Icons.pets,
        tone: MichiRowTone.coral,
        title: title,
        subtitle: detail,
        semanticLabel:
            '$title. ${RecommendationCopy.action(t, focus)}. $detail',
        onTap: _openFocus,
      ),
    );
  }

  List<Widget> _rows(BuildContext context) {
    final t = context.t;
    final rows = <Widget>[
      // A Daily in progress continues from the Daily card. Until the Daily
      // is known, its row waits, so it never appears and then vanishes.
      if (!_loading &&
          _active != null &&
          (_active!.dailyChallengeKey == null ||
              (_daily != null &&
                  _active!.dailyChallengeKey != _daily!.challengeKey)))
        _ContinueRow(
          summary: _active!,
          game: _activeGame?.gameId == _active!.gameId ? _activeGame : null,
          onTap: _continue,
        ),
      if (_focus case final focus?) _focusRow(t, focus),
      MichiListRow(
        key: const ValueKey('home-new-puzzle'),
        icon: Icons.grid_on_outlined,
        title: t.home.newPuzzle,
        subtitle: t.home.scanInvite,
        onTap: _loading || _loadFailed ? null : _startNew,
      ),
    ];
    return [
      for (var index = 0; index < rows.length; index++) ...[
        if (index > 0)
          const Divider(
            height: 1,
            thickness: 1,
            indent: MichiSpacing.sm + MichiListRow.tileSize + MichiSpacing.lg,
            endIndent: MichiSpacing.sm,
            color: MichiColors.hairline,
          ),
        rows[index],
      ],
    ];
  }

  @override
  Widget build(BuildContext context) => ActiveTabTickers(
    index: 0,
    child: Scaffold(
      backgroundColor: MichiColors.paper,
      body: SafeArea(
        child: MichiContentFrame(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              MichiLayout.cardGutter,
              MichiSpacing.md,
              MichiLayout.cardGutter,
              MichiLayout.sectionGap,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: MichiLayout.textInset,
                    vertical: MichiSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      const MichiWordmark(),
                      const Spacer(),
                      // Shown only for a real, current Daily streak.
                      if (_streak > 0) _StreakBadge(days: _streak),
                    ],
                  ),
                ),
                const SizedBox(height: MichiSpacing.lg),
                if (_loadFailed)
                  _HomeNotice(text: context.t.home.storageUnavailable)
                else if (_daily != null && !_loading)
                  // Keyed by day only: finishing or starting today's Daily
                  // updates the card in place instead of re-entering it.
                  MichiReveal(
                    key: ValueKey(_daily!.challengeKey),
                    child: _DailyCard(
                      daily: _daily!,
                      completed: _dailyCompleted,
                      inProgress:
                          _active?.dailyChallengeKey == _daily!.challengeKey,
                      onTap: _startDaily,
                    ),
                  )
                else if (_dailyFailed)
                  _HomeNotice(text: context.t.home.contentUnavailable)
                else
                  const _DailySkeleton(),
                const SizedBox(height: MichiSpacing.sm),
                ..._rows(context),
                const SizedBox(height: MichiLayout.sectionGap),
                Padding(
                  padding: const EdgeInsets.only(left: MichiLayout.textInset),
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
    ),
  );
}

final class _HomeNotice extends StatelessWidget {
  const _HomeNotice({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: MichiColors.cream,
      borderRadius: BorderRadius.circular(MichiRadius.card),
    ),
    child: Padding(
      padding: const EdgeInsets.all(MichiSpacing.lg),
      child: Text(text, style: MichiTypography.secondary),
    ),
  );
}

/// Daily loading state: the card's own shape and size (so nothing moves
/// when it fills in) with MICHI's paw loader inside.
final class _DailySkeleton extends StatelessWidget {
  const _DailySkeleton();

  @override
  Widget build(BuildContext context) => DecoratedBox(
    key: const ValueKey('daily-loading'),
    decoration: BoxDecoration(
      color: MichiColors.indigo,
      borderRadius: BorderRadius.circular(MichiRadius.hero),
    ),
    child: Padding(
      padding: const EdgeInsets.all(MichiSpacing.lg),
      child: Column(
        children: [
          SizedBox(
            height: 138,
            width: double.infinity,
            child: Center(
              child: MichiPawLoader(
                label: context.t.home.loading,
                showLabel: false,
                color: MichiColors.ivory,
              ),
            ),
          ),
          const SizedBox(height: MichiSpacing.sm),
          // Where the action button will be, at its exact height.
          DecoratedBox(
            decoration: BoxDecoration(
              color: MichiColors.ivory.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(MichiRadius.control),
            ),
            child: const SizedBox(height: 52, width: double.infinity),
          ),
        ],
      ),
    ),
  );
}

final class _ContinueRow extends StatelessWidget {
  const _ContinueRow({
    required this.summary,
    required this.game,
    required this.onTap,
  });

  final ActiveGameSummary summary;
  final StoredGame? game;
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
    final saved = game;
    return MichiListRow(
      key: const ValueKey('continue-game'),
      icon: Icons.play_arrow_rounded,
      leading: saved == null
          ? null
          : MiniBoard(
              key: const ValueKey('continue-thumbnail'),
              givens: saved.initialBoard,
              current: saved.currentBoard,
            ),
      tone: MichiRowTone.indigo,
      title: context.t.home.continueGame,
      subtitle: context.t.home.continueDetails(
        date: started,
        progress: (summary.progress * 100).round(),
        time: time,
      ),
      onTap: onTap,
    );
  }
}

/// The approved streak chip: a paw and the count of Daily days in a row.
final class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${context.t.home.streakMeaning}: ${context.t.home.streak(n: days)}',
    child: ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.pets, size: 16, color: MichiColors.indigo),
          const SizedBox(width: MichiSpacing.xs),
          Text(
            context.t.home.streak(n: days),
            key: const ValueKey('home-streak'),
            style: MichiTypography.meta.copyWith(
              color: MichiColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
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
                constraints: const BoxConstraints(
                  minHeight: 138,
                  minWidth: double.infinity,
                ),
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
                    Positioned(
                      right: 0,
                      bottom: 0,
                      // Quiet life while today's Daily waits; a finished Daily
                      // keeps its static happy pose (no replayed reward).
                      child: completed
                          ? const MichiMascot(
                              state: MichiMascotState.happy,
                              size: 138,
                            )
                          : const MichiMotionMascot(
                              asset: MichiMotionAsset.idle,
                              size: 138,
                              playback: MichiMotionPlayback.occasional,
                              fallback: MichiMascot(
                                state: MichiMascotState.calm,
                                size: 138,
                              ),
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
