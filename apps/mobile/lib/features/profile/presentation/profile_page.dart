import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';

@RoutePage()
final class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => const RoutePlaceholder(
    title: 'Профіль',
    subtitle: 'Налаштування профілю з’являться пізніше.',
  );
}
