import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:michi_mobile/app/router/app_router.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

@module
abstract class AppModule {
  @lazySingleton
  AppRouter get router => AppRouter();
}
