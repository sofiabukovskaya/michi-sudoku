import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/firebase/firebase_runtime.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/features/legal/domain/legal_document.dart';
import 'package:michi_mobile/features/legal/presentation/legal_link.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class LegalAboutSection extends StatefulWidget {
  const LegalAboutSection({super.key});

  @override
  State<LegalAboutSection> createState() => _LegalAboutSectionState();
}

final class _LegalAboutSectionState extends State<LegalAboutSection> {
  late final Future<PackageInfo> _version = PackageInfo.fromPlatform();
  late final FirebaseRuntime _runtime = getIt<FirebaseRuntime>();
  late Future<bool> _saved;
  bool? _choice;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _saved = _runtime.shareCrashReports();
  }

  Future<void> _change(bool value) async {
    setState(() => _saving = true);
    try {
      await _runtime.setShareCrashReports(enabled: value);
      if (mounted) setState(() => _choice = value);
    } on Object {
      if (!mounted) return;
      setState(() {
        _choice = null;
        _saved = _runtime.shareCrashReports();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.legal.saveFailed)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final copy = context.t.legal;
    const contact = LegalVersion.contact;
    final hasContact = contact.contains('@') && !contact.contains('{');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(copy.about, style: MichiTypography.heading),
        const SizedBox(height: MichiSpacing.md),
        Card(
          margin: EdgeInsets.zero,
          color: MichiColors.ivory,
          child: Column(
            children: [
              for (final document in LegalDocument.values)
                ListTile(
                  title: Text(
                    document == LegalDocument.privacy
                        ? copy.privacy
                        : copy.terms,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      context.router.push(LegalRoute(document: document)),
                ),
              ListTile(
                title: Text(copy.licenses),
                trailing: const Icon(Icons.chevron_right),
                onTap: () =>
                    showLicensePage(context: context, applicationName: 'MICHI'),
              ),
              FutureBuilder<bool>(
                future: _saved,
                builder: (context, snapshot) => SwitchListTile(
                  key: const ValueKey('share-crash-reports'),
                  title: Text(copy.crashes),
                  subtitle: Text(
                    snapshot.hasError ? copy.unavailable : copy.crashDetail,
                  ),
                  value: _choice ?? snapshot.data ?? false,
                  onChanged: _saving || !snapshot.hasData ? null : _change,
                ),
              ),
              ListTile(
                title: Text(copy.contact),
                subtitle: Text(hasContact ? contact : copy.contactPending),
                onTap: hasContact
                    ? () => openLegalLink(
                        context,
                        Uri(scheme: 'mailto', path: contact),
                      )
                    : null,
              ),
            ],
          ),
        ),
        const SizedBox(height: MichiSpacing.lg),
        FutureBuilder<PackageInfo>(
          future: _version,
          builder: (context, snapshot) {
            final info = snapshot.data;
            if (info == null) return const SizedBox.shrink();
            return Text(
              'MICHI ${info.version} (${info.buildNumber})',
              textAlign: TextAlign.center,
              style: MichiTypography.meta,
            );
          },
        ),
      ],
    );
  }
}
