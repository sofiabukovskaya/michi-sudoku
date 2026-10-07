import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) => const RoutePlaceholder(
    title: 'Гра',
    subtitle: 'Ігрове поле з’явиться у наступній фазі.',
  );
}
