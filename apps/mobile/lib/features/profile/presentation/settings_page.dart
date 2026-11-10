import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';

@RoutePage()
final class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _languageNames = <AppLocale, String>{
    AppLocale.en: 'English',
    AppLocale.uk: 'Українська',
    AppLocale.cs: 'Čeština',
    AppLocale.es: 'Español',
    AppLocale.fr: 'Français',
    AppLocale.de: 'Deutsch',
  };

  Future<void> _chooseLanguage(BuildContext context) async {
    final locale = await showModalBottomSheet<AppLocale>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => MichiBottomSheet(
        child: SizedBox(
          height: MediaQuery.sizeOf(sheetContext).height * 0.6,
          child: Material(
            type: MaterialType.transparency,
            child: ListView(
              children: [
                Text(
                  sheetContext.t.settings.language,
                  style: MichiTypography.heading,
                ),
                const SizedBox(height: MichiSpacing.md),
                for (final option in AppLocale.values)
                  ListTile(
                    title: Text(_languageNames[option]!),
                    trailing: option == LocaleSettings.currentLocale
                        ? const Icon(Icons.check, color: MichiColors.indigo)
                        : null,
                    onTap: () => Navigator.of(sheetContext).pop(option),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
    if (locale == null) return;
    await LocaleSettings.setLocale(locale);
    await LocalePreferenceStore().save(locale);
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final accepted = await _confirm(
      context,
      title: context.t.auth.signOutTitle,
      body: context.t.auth.signOutBody,
      action: context.t.sync.signOut,
    );
    if (accepted && context.mounted) {
      await context.read<AuthCubit>().signOut();
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final accepted = await _confirm(
      context,
      title: context.t.sync.deleteTitle,
      body: context.t.sync.deleteBody,
      action: context.t.sync.deleteConfirm,
    );
    if (!accepted || !context.mounted) return;
    final coordinator = context.read<SyncCoordinator?>();
    final auth = context.read<AuthCubit>();
    final deleted = coordinator == null
        ? await auth.deleteAccount()
        : await coordinator.deleteAccount();
    if (!context.mounted) return;
    if (deleted) {
      await context.router.root.replaceAll([const WelcomeRoute()]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.t.sync.deleteFailed)),
      );
    }
  }

  Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String body,
    required String action,
  }) async =>
      await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => MichiBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: MichiTypography.heading),
              const SizedBox(height: MichiSpacing.sm),
              Text(body, style: MichiTypography.secondary),
              const SizedBox(height: MichiSpacing.xl),
              MichiButton(
                label: action,
                onPressed: () => Navigator.of(sheetContext).pop(true),
              ),
              const SizedBox(height: MichiSpacing.sm),
              MichiButton(
                label: sheetContext.t.auth.cancel,
                variant: MichiButtonVariant.secondary,
                onPressed: () => Navigator.of(sheetContext).pop(false),
              ),
            ],
          ),
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    final account = context.watch<AuthCubit>().state.account;
    final sync = context.read<SyncCoordinator?>();
    return Scaffold(
      backgroundColor: MichiColors.paper,
      appBar: AppBar(title: Text(context.t.settings.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(MichiSpacing.xl),
          children: [
            Text(context.t.settings.language, style: MichiTypography.heading),
            const SizedBox(height: MichiSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                color: MichiColors.ivory,
                border: Border.all(color: MichiColors.hairline),
                borderRadius: BorderRadius.circular(MichiRadius.card),
              ),
              child: Material(
                type: MaterialType.transparency,
                child: ListTile(
                  leading: const Icon(
                    Icons.language_outlined,
                    color: MichiColors.textSecondary,
                  ),
                  title: Text(
                    context.t.settings.language,
                    style: MichiTypography.body,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _languageNames[LocaleSettings.currentLocale]!,
                        style: MichiTypography.secondary,
                      ),
                      const SizedBox(width: MichiSpacing.xs),
                      const Icon(
                        Icons.chevron_right,
                        color: MichiColors.textSecondary,
                      ),
                    ],
                  ),
                  onTap: () => _chooseLanguage(context),
                ),
              ),
            ),
            const SizedBox(height: MichiSpacing.xxl),
            Text(context.t.sync.account, style: MichiTypography.heading),
            const SizedBox(height: MichiSpacing.md),
            DecoratedBox(
              decoration: BoxDecoration(
                color: MichiColors.ivory,
                border: Border.all(color: MichiColors.hairline),
                borderRadius: BorderRadius.circular(MichiRadius.card),
              ),
              child: Material(
                type: MaterialType.transparency,
                child: account == null
                    ? ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                          color: MichiColors.textSecondary,
                        ),
                        title: Text(context.t.sync.guest),
                      )
                    : Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.mail_outline,
                              color: MichiColors.textSecondary,
                            ),
                            title: Text(context.t.sync.email),
                            subtitle: Text(account.email ?? ''),
                          ),
                          const Divider(height: 1, color: MichiColors.hairline),
                          if (sync != null)
                            AnimatedBuilder(
                              animation: sync,
                              builder: (context, _) => ListTile(
                                leading: const Icon(
                                  Icons.sync,
                                  color: MichiColors.textSecondary,
                                ),
                                title: Text(context.t.sync.synchronization),
                                subtitle: Text(_syncDetail(context, sync)),
                                trailing:
                                    sync.status == SyncStatus.error ||
                                        sync.status == SyncStatus.offline ||
                                        sync.status == SyncStatus.pending
                                    ? TextButton(
                                        onPressed: sync.retry,
                                        child: Text(context.t.sync.retry),
                                      )
                                    : null,
                              ),
                            ),
                          const Divider(height: 1, color: MichiColors.hairline),
                          ListTile(
                            leading: const Icon(
                              Icons.chevron_left,
                              color: MichiColors.textSecondary,
                            ),
                            title: Text(context.t.sync.signOut),
                            onTap: () => _confirmSignOut(context),
                          ),
                          const Divider(height: 1, color: MichiColors.hairline),
                          ListTile(
                            leading: const Icon(
                              Icons.close,
                              color: MichiColors.coralText,
                            ),
                            title: Text(
                              context.t.sync.deleteAccount,
                              style: MichiTypography.body.copyWith(
                                color: MichiColors.coralText,
                              ),
                            ),
                            onTap: () => _confirmDelete(context),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _syncDetail(BuildContext context, SyncCoordinator sync) =>
      switch (sync.status) {
        SyncStatus.disabledGuest => context.t.sync.guest,
        SyncStatus.initialMerge || SyncStatus.syncing => context.t.sync.syncing,
        SyncStatus.pending => context.t.sync.pending,
        SyncStatus.offline => context.t.sync.offline,
        SyncStatus.error => context.t.sync.error,
        SyncStatus.synced =>
          sync.lastSynced == null
              ? context.t.sync.synced
              : context.t.sync.lastSynced(
                  time: TimeOfDay.fromDateTime(
                    sync.lastSynced!.toLocal(),
                  ).format(context),
                ),
      };
}
