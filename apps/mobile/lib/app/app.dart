import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

final class MichiApp extends StatelessWidget {
  const MichiApp({required this.router, super.key});

  final AppRouter router;

  @override
  Widget build(BuildContext context) => TranslationProvider(
    child: Builder(
      builder: (context) => MaterialApp.router(
        title: context.t.appName,
        theme: AppTheme.light,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router.config(),
      ),
    ),
  );
}
