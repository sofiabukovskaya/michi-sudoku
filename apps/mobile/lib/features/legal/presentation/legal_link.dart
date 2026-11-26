import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle get legalLinkStyle => MichiTypography.body.copyWith(
  color: MichiColors.indigo,
  decoration: TextDecoration.underline,
);

final class LegalLink extends StatelessWidget {
  const LegalLink({required this.label, required this.onTap, super.key});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    link: true,
    child: InkWell(
      onTap: onTap,
      child: Text(label, style: legalLinkStyle),
    ),
  );
}

Future<void> openLegalLink(BuildContext context, Uri uri) async {
  try {
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) return;
  } on Object {
    // Some devices do not have a handler configured for mailto links.
  }
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(context.t.legal.openFailed)),
  );
}
