import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/learn/domain/technique_lesson.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress.dart';
import 'package:michi_mobile/features/learn/domain/technique_progress_repository.dart';
import 'package:michi_mobile/features/learn/presentation/technique_copy.dart';
import 'package:sudoku_engine/sudoku_engine.dart';

@RoutePage()
final class LearnPage extends StatefulWidget {
  const LearnPage({this.progressRepository, super.key});

  final TechniqueProgressRepository? progressRepository;

  @override
  State<LearnPage> createState() => _LearnPageState();
}

final class _LearnPageState extends State<LearnPage>
    with AutoRouteAwareStateMixin<LearnPage> {
  late final TechniqueProgressRepository _repository;
  late Future<Map<SudokuTechnique, TechniqueProgress>> _progress;

  @override
  void initState() {
    super.initState();
    _repository =
        widget.progressRepository ?? getIt<TechniqueProgressRepository>();
    _progress = _repository.loadAll();
  }

  @override
  void didPopNext() {
    setState(() {
      _progress = _repository.loadAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: MichiColors.paper,
    body: SafeArea(
      child: FutureBuilder<Map<SudokuTechnique, TechniqueProgress>>(
        future: _progress,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(context.t.learn.unavailable));
          }
          if (!snapshot.hasData) {
            return Center(child: Text(context.t.learn.loading));
          }
          final values = snapshot.data!;
          final mastered = values.values
              .where((item) => item.mastery == TechniqueMastery.mastered)
              .length;
          return ListView(
            padding: const EdgeInsets.all(MichiSpacing.xl),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(onPressed: () => context.router.maybePop()),
              ),
              const SizedBox(height: MichiSpacing.sm),
              Text(context.t.learn.title, style: MichiTypography.display),
              const SizedBox(height: MichiSpacing.sm),
              Text(
                '$mastered / ${TechniqueLessons.supported.length} · ${context.t.learn.intro}',
                style: MichiTypography.secondary,
              ),
              const SizedBox(height: MichiSpacing.xxl),
              for (final technique in TechniqueLessons.supported)
                _TechniquePathItem(
                  technique: technique,
                  progress:
                      values[technique] ??
                      TechniqueProgress(technique: technique),
                  onTap: () => context.router.push(
                    TechniqueLessonRoute(technique: technique),
                  ),
                ),
            ],
          );
        },
      ),
    ),
  );
}

final class _TechniquePathItem extends StatelessWidget {
  const _TechniquePathItem({
    required this.technique,
    required this.progress,
    required this.onTap,
  });

  final SudokuTechnique technique;
  final TechniqueProgress progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mastered = progress.mastery == TechniqueMastery.mastered;
    final active =
        progress.mastery == TechniqueMastery.learning ||
        progress.mastery == TechniqueMastery.practicing;
    return Semantics(
      button: true,
      label:
          '${TechniqueCopy.name(context.t, technique)}, '
          '${TechniqueCopy.mastery(context.t, progress.mastery)}',
      child: InkWell(
        key: ValueKey('learn-${technique.name}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(MichiRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: MichiSpacing.sm),
          child: Row(
            children: [
              SizedBox(
                width: 54,
                height: 74,
                child: Center(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: mastered
                          ? MichiColors.indigo
                          : active
                          ? MichiColors.coral
                          : MichiColors.ivory,
                      border: Border.all(
                        color: mastered || active
                            ? Colors.transparent
                            : MichiColors.textPrimary,
                        width: 2,
                      ),
                    ),
                    child: SizedBox.square(
                      dimension: 40,
                      child: Icon(
                        mastered
                            ? Icons.check
                            : active
                            ? Icons.pets
                            : null,
                        size: 20,
                        color: MichiColors.ivory,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: MichiSpacing.sm),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: active ? MichiColors.coralTint : MichiColors.ivory,
                    borderRadius: BorderRadius.circular(MichiRadius.card),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(MichiSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TechniqueCopy.name(context.t, technique),
                          style: MichiTypography.heading,
                        ),
                        const SizedBox(height: MichiSpacing.xs),
                        Text(
                          TechniqueCopy.mastery(context.t, progress.mastery),
                          style: MichiTypography.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
