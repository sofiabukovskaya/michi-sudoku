import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/app/theme/app_theme.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';

final class MichiApp extends StatelessWidget {
  const MichiApp({required this.router, this.authCubit, super.key});

  final AppRouter router;
  final AuthCubit? authCubit;

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: authCubit ?? getIt<AuthCubit>(),
    child: TranslationProvider(
      child: Builder(
        builder: (context) => MaterialApp.router(
          title: context.t.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: router.config(
            navigatorObservers: () => [AutoRouteObserver()],
          ),
        ),
      ),
    ),
  );
}
