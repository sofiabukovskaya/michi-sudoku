import 'package:flutter/material.dart';
import 'package:michi_mobile/app/app.dart';
import 'package:michi_mobile/app/bootstrap.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap();
  runApp(MichiApp(router: getIt<AppRouter>()));
}
