import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/features/feedback/data/feedback_repository.dart';
import 'package:michi_mobile/features/feedback/domain/feedback_draft.dart';

typedef FeedbackState = ({
  FeedbackDraft draft,
  bool loaded,
  bool sending,
  bool sent,
  bool unavailable,
  bool storageError,
  FeedbackFailure? failure,
});

final class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._repository)
    : super((
        draft: const FeedbackDraft(),
        loaded: false,
        sending: false,
        sent: false,
        unavailable: false,
        storageError: false,
        failure: null,
      ));

  final FeedbackRepository _repository;
  var _edit = 0;

  Future<void> load(FeedbackCategory? category) async {
    FeedbackDraft draft;
    var storageError = false;
    try {
      draft = await _repository.loadDraft();
    } on Object {
      draft = const FeedbackDraft();
      storageError = true;
    }
    if (isClosed) return;
    if (category != null) draft = draft.copyWith(category: category);
    _emit(draft: draft, loaded: true, storageError: storageError);
    final available = await _repository.available;
    if (!isClosed && !state.sent) {
      _emit(unavailable: !available, failure: state.failure);
    }
  }

  void update(FeedbackDraft value) {
    if (state.sending || state.sent) return;
    _emit(draft: value);
    final version = ++_edit;
    unawaited(_persist(value, version));
  }

  Future<void> _persist(FeedbackDraft draft, int version) async {
    var error = false;
    try {
      await _repository.saveDraft(draft);
    } on Object {
      error = true;
    }
    if (!isClosed && version == _edit && !state.sent) {
      _emit(storageError: error, failure: state.failure);
    }
  }

  Future<void> send(Map<String, Object> details) async {
    final draft = state.draft;
    if (state.sending ||
        state.sent ||
        draft.category == null ||
        !draft.validMessage ||
        !draft.validEmail) {
      return;
    }
    _emit(sending: true);
    try {
      try {
        await _repository.saveDraft(draft);
      } on Object {
        if (!isClosed) _emit(storageError: true);
      }
      await _repository.submit(draft, details);
    } on Object catch (error) {
      if (!isClosed) {
        _emit(
          sending: false,
          failure: error is FeedbackFailure ? error : FeedbackFailure.retry,
        );
      }
      return;
    }
    try {
      await _repository.clearSentDraft(draft);
    } on Object {
      // The submission was saved remotely. Never invite a duplicate retry.
    }
    if (!isClosed) _emit(sending: false, sent: true);
  }

  void _emit({
    FeedbackDraft? draft,
    bool? loaded,
    bool? sending,
    bool? sent,
    bool? unavailable,
    bool? storageError,
    FeedbackFailure? failure,
  }) => emit((
    draft: draft ?? state.draft,
    loaded: loaded ?? state.loaded,
    sending: sending ?? state.sending,
    sent: sent ?? state.sent,
    unavailable: unavailable ?? state.unavailable,
    storageError: storageError ?? state.storageError,
    failure: failure,
  ));
}
