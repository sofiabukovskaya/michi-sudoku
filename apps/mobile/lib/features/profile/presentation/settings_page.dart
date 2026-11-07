import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';

@RoutePage()
final class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const names = <AppLocale, String>{
      AppLocale.en: 'English',
      AppLocale.uk: 'Українська',
      AppLocale.cs: 'Čeština',
      AppLocale.es: 'Español',
      AppLocale.fr: 'Français',
      AppLocale.de: 'Deutsch',
    };
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(title: Text(context.t.settings.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(MichiSpacing.xl),
          children: [
            Text(context.t.settings.language, style: MichiTypography.heading),
            const SizedBox(height: MichiSpacing.xs),
            Text(
              context.t.settings.languageDetail,
              style: MichiTypography.secondary,
            ),
            const SizedBox(height: MichiSpacing.lg),
            DecoratedBox(
              decoration: BoxDecoration(
                color: MichiColors.ivory,
                border: Border.all(color: MichiColors.hairline),
                borderRadius: BorderRadius.circular(MichiRadius.card),
              ),
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    for (final locale in AppLocale.values) ...[
                      if (locale != AppLocale.values.first)
                        const Divider(height: 1, color: MichiColors.hairline),
                      ListTile(
                        title: Text(names[locale]!),
                        trailing: LocaleSettings.currentLocale == locale
                            ? const Icon(
                                Icons.check_circle,
                                color: MichiColors.indigo,
                              )
                            : const Icon(
                                Icons.circle_outlined,
                                color: MichiColors.inputLine,
                              ),
                        onTap: () async {
                          await LocaleSettings.setLocale(locale);
                          await LocalePreferenceStore().save(locale);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
