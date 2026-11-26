import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/features/review/data/review_service.dart';
import 'package:michi_mobile/features/review/domain/review_policy.dart';

/// Only a settled and still visible milestone may reach the native sheet.
final class ReviewOpportunity extends StatefulWidget {
  const ReviewOpportunity({
    required this.ready,
    required this.moments,
    required this.child,
    this.completedDailyId,
    this.requireInViewport = false,
    super.key,
  });

  final bool ready;
  final Set<ReviewMoment> moments;
  final String? completedDailyId;
  final bool requireInViewport;
  final Widget child;

  @override
  State<ReviewOpportunity> createState() => _ReviewOpportunityState();
}

final class _ReviewOpportunityState extends State<ReviewOpportunity> {
  Timer? _timer;
  bool _offered = false;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  @override
  void didUpdateWidget(ReviewOpportunity oldWidget) {
    super.didUpdateWidget(oldWidget);
    _schedule();
  }

  void _schedule() {
    if (!widget.ready ||
        (widget.moments.isEmpty && widget.completedDailyId == null)) {
      _timer?.cancel();
      _timer = null;
      return;
    }
    if (_offered || _timer != null) return;
    _timer = Timer(const Duration(milliseconds: 1500), () {
      _timer = null;
      _offered = true;
      if (!_visible() || !getIt.isRegistered<ReviewService>()) return;
      unawaited(
        getIt<ReviewService>().consider(
          moments: widget.moments,
          completedDailyId: widget.completedDailyId,
          isVisible: _visible,
        ),
      );
    });
  }

  bool _visible() =>
      mounted &&
      widget.ready &&
      WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed &&
      TickerMode.valuesOf(context).enabled &&
      (ModalRoute.of(context)?.isCurrent ?? false) &&
      (!widget.requireInViewport || _inViewport());

  bool _inViewport() {
    final target = context.findRenderObject();
    final viewport = Scrollable.maybeOf(context)?.context.findRenderObject();
    if (target is! RenderBox ||
        viewport is! RenderBox ||
        !target.attached ||
        !viewport.attached ||
        !target.hasSize ||
        !viewport.hasSize) {
      return false;
    }
    final place = target.localToGlobal(Offset.zero) & target.size;
    final window = viewport.localToGlobal(Offset.zero) & viewport.size;
    return window.overlaps(place);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
