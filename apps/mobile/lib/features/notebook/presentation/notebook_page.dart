import 'dart:async';
import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/widgets/michi_page_state.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:michi_mobile/features/notebook/data/notebook_stamps.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

final class _NotebookData {
  const _NotebookData(this.progress, this.fresh);

  final Map<SudokuTechnique, TechniqueProgress> progress;

  /// Mastered since the last visit: their stamp lands now, once.
  final Set<SudokuTechnique> fresh;
}

/// MICHI's notebook: one page per technique; mastering one earns its paw
/// stamp. A calm collection to complete, built on real mastery only.
@RoutePage()
final class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

final class _NotebookPageState extends State<NotebookPage> {
  final _stamps = NotebookStamps();
  late Future<_NotebookData> _data = _load();

  Future<_NotebookData> _load() async {
    final progress = await getIt<TechniqueProgressRepository>().loadAll();
    final mastered = {
      for (final entry in progress.entries)
        if (entry.value.mastery == TechniqueMastery.mastered) entry.key,
    };
    final seen = await _stamps.seen();
    // Remember now: leaving mid-animation never replays a stamp.
    await _stamps.markSeen(mastered);
    return _NotebookData(progress, mastered.difference(seen));
  }

  Future<void> _openLesson(SudokuTechnique technique) async {
    await context.router.push(TechniqueLessonRoute(technique: technique));
    if (mounted) setState(() => _data = _load());
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(
        backgroundColor: MichiColors.paper,
        title: Text(t.notebook.title, style: MichiTypography.heading),
      ),
      body: SafeArea(
        top: false,
        child: MichiContentFrame(
          child: FutureBuilder<_NotebookData>(
            future: _data,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null) {
                return snapshot.hasError
                    ? MichiProblemState(
                        message: t.common.loadProblem,
                        actionLabel: t.common.retry,
                        onAction: () => setState(() => _data = _load()),
                      )
                    : MichiLoadingState(label: t.common.justAMoment);
              }
              const techniques = SudokuTechniqueOrder.supported;
              final stamped = techniques
                  .where(
                    (technique) =>
                        data.progress[technique]?.mastery ==
                        TechniqueMastery.mastered,
                  )
                  .length;
              return LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 600 ? 4 : 2;
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          MichiLayout.cardGutter,
                          MichiSpacing.md,
                          MichiLayout.cardGutter,
                          MichiSpacing.lg,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: _NotebookHeader(
                            stamped: stamped,
                            total: techniques.length,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(
                          MichiLayout.cardGutter,
                          0,
                          MichiLayout.cardGutter,
                          MichiLayout.sectionGap,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                mainAxisSpacing: MichiSpacing.md,
                                crossAxisSpacing: MichiSpacing.md,
                                childAspectRatio: 0.72,
                              ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final technique = techniques[index];
                              // Several new stamps land one after another.
                              final before = data.fresh
                                  .where(
                                    (other) =>
                                        techniques.indexOf(other) < index,
                                  )
                                  .length;
                              return _NotebookPageCard(
                                number: index + 1,
                                technique: technique,
                                progress: data.progress[technique],
                                fresh: data.fresh.contains(technique),
                                delay: Duration(
                                  milliseconds: 300 + 350 * before,
                                ),
                                onTap: () => unawaited(_openLesson(technique)),
                              );
                            },
                            childCount: techniques.length,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

final class _NotebookHeader extends StatelessWidget {
  const _NotebookHeader({required this.stamped, required this.total});

  final int stamped;
  final int total;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.notebook.intro, style: MichiTypography.secondary),
        const SizedBox(height: MichiSpacing.md),
        Row(
          children: [
            const Icon(Icons.pets, size: 16, color: MichiColors.coral),
            const SizedBox(width: MichiSpacing.xs),
            Text(
              t.notebook.count(n: stamped, total: total),
              key: const ValueKey('notebook-count'),
              style: MichiTypography.body.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: MichiSpacing.sm),
        MichiProgressBar(value: total == 0 ? 0 : stamped / total),
      ],
    );
  }
}

final class _NotebookPageCard extends StatelessWidget {
  const _NotebookPageCard({
    required this.number,
    required this.technique,
    required this.progress,
    required this.fresh,
    required this.delay,
    required this.onTap,
  });

  final int number;
  final SudokuTechnique technique;
  final TechniqueProgress? progress;
  final bool fresh;
  final Duration delay;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final mastery = progress?.mastery ?? TechniqueMastery.newTechnique;
    final mastered = mastery == TechniqueMastery.mastered;
    final percent = progress?.masteryPercent ?? 0;
    final name = TechniqueCopy.name(t, technique);
    final status = mastered
        ? t.notebook.stampedLabel
        : mastery == TechniqueMastery.newTechnique
        ? t.notebook.notStarted
        : t.progress.mastery(percent: percent);
    return Semantics(
      button: true,
      label: '$name, $status',
      child: ExcludeSemantics(
        child: Material(
          color: MichiColors.ivory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MichiRadius.card),
            side: const BorderSide(color: MichiColors.hairline),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            key: ValueKey('notebook-${technique.name}'),
            onTap: onTap,
            child: CustomPaint(
              painter: const _RuledPaper(),
              child: Padding(
                padding: const EdgeInsets.all(MichiSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$number',
                      style: MichiTypography.meta.copyWith(
                        color: MichiColors.textSecondary,
                      ),
                    ),
                    Text(
                      name,
                      style: MichiTypography.heading,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: MichiSpacing.xs),
                    Expanded(
                      child: Text(
                        TechniqueCopy.description(t, technique),
                        style: MichiTypography.meta,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox.square(
                        dimension: 72,
                        child: mastered
                            ? (fresh
                                  ? MichiMotionMascot(
                                      asset: MichiMotionAsset.dailyStamp,
                                      size: 72,
                                      startDelay: delay,
                                      fallback: const _PawStamp(),
                                    )
                                  : const _PawStamp())
                            : _Unstamped(
                                started:
                                    mastery != TechniqueMastery.newTechnique,
                                percent: percent,
                              ),
                      ),
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
}

/// The settled stamp: a coral ring and paw, slightly turned like ink.
final class _PawStamp extends StatelessWidget {
  const _PawStamp();

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: -0.18,
    child: Container(
      key: const ValueKey('notebook-stamp'),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: MichiColors.coral.withValues(alpha: 0.85),
          width: 3,
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.pets,
        size: 34,
        color: MichiColors.coral.withValues(alpha: 0.9),
      ),
    ),
  );
}

/// An empty stamp place: a dashed ring with progress once started.
final class _Unstamped extends StatelessWidget {
  const _Unstamped({required this.started, required this.percent});

  final bool started;
  final int percent;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _DashedRing(progress: started ? percent / 100 : 0),
    child: Center(
      child: started
          ? Text('$percent%', style: MichiTypography.meta)
          : const Icon(Icons.pets, size: 22, color: MichiColors.hairline),
    ),
  );
}

final class _DashedRing extends CustomPainter {
  const _DashedRing({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final ring = rect.deflate(3);
    final dash = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = MichiColors.hairline;
    const dashes = 18;
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(
        ring,
        i * 2 * math.pi / dashes,
        math.pi / dashes,
        false,
        dash,
      );
    }
    if (progress > 0) {
      canvas.drawArc(
        ring,
        -math.pi / 2,
        2 * math.pi * progress.clamp(0, 1),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round
          ..color = MichiColors.coral.withValues(alpha: 0.6),
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRing oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Faint notebook lines behind each page.
final class _RuledPaper extends CustomPainter {
  const _RuledPaper();

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = MichiColors.hairline.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    for (var y = 44.0; y < size.height; y += 22) {
      canvas.drawLine(Offset(12, y), Offset(size.width - 12, y), line);
    }
  }

  @override
  bool shouldRepaint(_RuledPaper oldDelegate) => false;
}
