import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';

final class FeedbackLink extends StatelessWidget {
  const FeedbackLink({this.category, super.key});

  final FeedbackCategory? category;

  @override
  Widget build(BuildContext context) => Semantics(
    link: true,
    child: InkWell(
      onTap: () => context.router.root.push(FeedbackRoute(category: category)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MichiSpacing.md),
        child: Text(
          context.t.feedback.problemLink,
          textAlign: TextAlign.center,
          style: MichiTypography.meta.copyWith(
            color: MichiColors.indigo,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),
  );
}
