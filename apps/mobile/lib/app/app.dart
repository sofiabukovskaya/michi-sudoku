import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';

final class MichiApp extends StatelessWidget {
  const MichiApp({required this.router, super.key});

  final AppRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'MICHI',
    theme: AppTheme.light,
    routerConfig: router.config(),
  );
}
