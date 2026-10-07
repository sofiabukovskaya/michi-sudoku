import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_mobile/app/router/route_placeholder.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) => RoutePlaceholder(
    title: context.t.home.scanner,
    subtitle: context.t.scanner.unavailable,
  );
}
