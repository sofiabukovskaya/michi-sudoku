import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) => const RoutePlaceholder(
    title: 'Прогрес',
    subtitle: 'Майстерність технік з’явиться пізніше.',
  );
}
