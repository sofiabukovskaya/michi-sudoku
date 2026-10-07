import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) => const RoutePlaceholder(
    title: 'Акаунт',
    subtitle: 'Синхронізація прогресу з’явиться пізніше.',
  );
}
