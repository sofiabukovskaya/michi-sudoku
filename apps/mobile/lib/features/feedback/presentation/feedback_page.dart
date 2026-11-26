import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/widgets/michi_mascot.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:michi_mobile/features/feedback/application/feedback_cubit.dart';
import 'package:michi_mobile/features/feedback/data/feedback_repository.dart';
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';

@RoutePage()
final class FeedbackPage extends StatelessWidget {
  const FeedbackPage({this.category, super.key});

  final FeedbackCategory? category;

  @override
  Widget build(BuildContext context) {
    final repository = getIt<FeedbackRepository>();
    return BlocProvider(
      create: (_) => FeedbackCubit(repository)..load(category).ignore(),
      child: Scaffold(
        backgroundColor: MichiColors.paper,
        appBar: AppBar(title: Text(context.t.feedback.title)),
        body: SafeArea(
          child: MichiContentFrame(
            maxWidth: MichiLayout.focusedWidth,
            child: BlocBuilder<FeedbackCubit, FeedbackState>(
              builder: (context, state) {
                final copy = context.t.feedback;
                if (!state.loaded) {
                  return Center(
                    child: MichiPawLoader(
                      label: context.t.common.justAMoment,
                      size: MichiPawLoaderSize.screen,
                    ),
                  );
                }
                if (state.sent) {
                  return ListView(
                    padding: const EdgeInsets.all(MichiSpacing.xl),
                    children: [
                      const Center(
                        child: MichiMascot(
                          state: MichiMascotState.happy,
                          size: 112,
                        ),
                      ),
                      const SizedBox(height: MichiSpacing.lg),
                      Semantics(
                        liveRegion: true,
                        child: Text(
                          copy.thanks,
                          style: MichiTypography.heading,
                        ),
                      ),
                      const SizedBox(height: MichiSpacing.xl),
                      MichiButton(
                        label: copy.done,
                        onPressed: () => context.router.maybePop(),
                      ),
                    ],
                  );
                }
                return _FeedbackForm(repository: repository, state: state);
              },
            ),
          ),
        ),
      ),
    );
  }
}

final class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm({required this.repository, required this.state});
  final FeedbackRepository repository;
  final FeedbackState state;

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

final class _FeedbackFormState extends State<_FeedbackForm> {
  bool _checked = false;
  Map<String, Object>? _details;

  @override
  void initState() {
    super.initState();
    unawaited(_loadDetails());
  }

  Future<void> _loadDetails() async {
    final data = await widget.repository.details(
      language: LocaleSettings.currentLocale.languageCode,
      signedIn: context.read<AuthCubit?>()?.state.account != null,
    );
    if (mounted) setState(() => _details = data);
  }

  String _detailLine(BuildContext context, String key, Object value) {
    final copy = context.t.feedback;
    final label = switch (key) {
      'appVersion' => copy.appVersion,
      'build' => copy.build,
      'platform' => copy.platform,
      'osVersion' => copy.os,
      'deviceModel' => copy.model,
      'language' => copy.language,
      _ => copy.account,
    };
    final display = value is bool
        ? (value ? copy.signedIn : copy.guest)
        : value;
    return '$label: $display';
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final draft = state.draft;
    final cubit = context.read<FeedbackCubit>();
    final copy = context.t.feedback;
    final issue = switch (state.failure) {
      FeedbackFailure.unavailable => copy.unavailable,
      FeedbackFailure.limited => copy.limited,
      FeedbackFailure.retry => copy.retry,
      FeedbackFailure.tooLarge => copy.tooLarge,
      null => state.unavailable ? copy.unavailable : null,
    };
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(MichiSpacing.xl),
      children: [
        Text(copy.intro, style: MichiTypography.body),
        const SizedBox(height: MichiSpacing.lg),
        Wrap(
          spacing: MichiSpacing.sm,
          runSpacing: MichiSpacing.xs,
          children: [
            for (final category in FeedbackCategory.values)
              ChoiceChip(
                label: Text(switch (category) {
                  FeedbackCategory.idea => copy.idea,
                  FeedbackCategory.broken => copy.broken,
                  FeedbackCategory.scanner => copy.scanner,
                  FeedbackCategory.learning => copy.learning,
                  FeedbackCategory.other => copy.other,
                }),
                selected: draft.category == category,
                onSelected: state.sending
                    ? null
                    : (_) => cubit.update(draft.copyWith(category: category)),
              ),
          ],
        ),
        if (_checked && draft.category == null)
          Text(
            copy.categoryError,
            style: const TextStyle(color: MichiColors.coralText),
          ),
        const SizedBox(height: MichiSpacing.lg),
        TextFormField(
          key: const ValueKey('feedback-message'),
          initialValue: draft.message,
          enabled: !state.sending,
          minLines: 4,
          maxLines: 8,
          onChanged: (value) => cubit.update(draft.copyWith(message: value)),
          decoration: InputDecoration(
            labelText: copy.message,
            counterText: copy.counter(count: draft.length),
            errorText: _checked && !draft.validMessage
                ? copy.messageError
                : null,
          ),
        ),
        const SizedBox(height: MichiSpacing.lg),
        TextFormField(
          key: const ValueKey('feedback-email'),
          initialValue: draft.replyEmail,
          enabled: !state.sending,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => cubit.update(draft.copyWith(replyEmail: value)),
          decoration: InputDecoration(
            labelText: copy.reply,
            helperText: copy.replyDetail,
            helperMaxLines: 2,
            errorText: _checked && !draft.validEmail ? copy.emailError : null,
          ),
        ),
        const SizedBox(height: MichiSpacing.lg),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(copy.include),
          value: draft.includeDetails,
          onChanged: state.sending
              ? null
              : (value) => cubit.update(draft.copyWith(includeDetails: value)),
        ),
        ExpansionTile(
          key: const ValueKey('feedback-preview'),
          tilePadding: EdgeInsets.zero,
          title: Text(copy.preview),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(copy.alwaysIncluded),
            if (draft.replyEmail.trim().isNotEmpty)
              Text('${copy.reply}: ${draft.replyEmail.trim()}'),
            if (draft.includeDetails && _details == null)
              Text(context.t.common.justAMoment),
            if (draft.includeDetails && _details != null)
              for (final MapEntry(:key, :value) in _details!.entries)
                Text(_detailLine(context, key, value)),
          ],
        ),
        if (state.storageError)
          Semantics(liveRegion: true, child: Text(copy.draftError)),
        if (issue != null) ...[
          const SizedBox(height: MichiSpacing.md),
          Semantics(liveRegion: true, child: Text(issue)),
        ],
        const SizedBox(height: MichiSpacing.xl),
        MichiButton(
          key: const ValueKey('feedback-send'),
          label: copy.send,
          isLoading: state.sending,
          onPressed: state.sending || (draft.includeDetails && _details == null)
              ? null
              : () {
                  setState(() => _checked = true);
                  if (draft.category == null ||
                      !draft.validMessage ||
                      !draft.validEmail) {
                    return;
                  }
                  FocusScope.of(context).unfocus();
                  unawaited(cubit.send(_details ?? const {}));
                },
        ),
      ],
    );
  }
}
