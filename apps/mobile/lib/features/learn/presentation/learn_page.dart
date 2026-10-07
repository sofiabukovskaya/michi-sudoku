import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class LearnPage extends StatelessWidget {
  const LearnPage({super.key});

  @override
  Widget build(BuildContext context) => const RoutePlaceholder(
    title: 'Навчання',
    subtitle: 'Уроки технік з’являться пізніше.',
  );
}
