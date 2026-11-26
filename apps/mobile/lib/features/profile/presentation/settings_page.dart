import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_design_system/michi_design_system.dart';
import 'package:michi_mobile/app/router/app_router.dart';
import 'package:michi_mobile/core/di/injection.dart';
import 'package:michi_mobile/core/localization/locale_preference_store.dart';
import 'package:michi_mobile/core/localization/translations.g.dart';
import 'package:michi_mobile/core/notifications/reminder_registration.dart';
import 'package:michi_mobile/core/notifications/streak_reminder.dart';
import 'package:michi_mobile/core/sync/sync_coordinator.dart';
import 'package:michi_mobile/features/auth/application/auth_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

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
        child: MichiContentFrame(
          child: ListView(
            padding: const EdgeInsets.all(MichiSpacing.xl),
            children: [
              Text(context.t.settings.general, style: MichiTypography.heading),
              const SizedBox(height: MichiSpacing.md),
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
                      ListTile(
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
                      const Divider(height: 1, color: MichiColors.hairline),
                      _RemindersTile(uid: account?.uid),
                    ],
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
                            const Divider(
                              height: 1,
                              color: MichiColors.hairline,
                            ),
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
                            const Divider(
                              height: 1,
                              color: MichiColors.hairline,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.chevron_left,
                                color: MichiColors.textSecondary,
                              ),
                              title: Text(context.t.sync.signOut),
                              onTap: () => _confirmSignOut(context),
                            ),
                            const Divider(
                              height: 1,
                              color: MichiColors.hairline,
                            ),
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

final class _RemindersTile extends StatefulWidget {
  const _RemindersTile({required this.uid});

  final String? uid;

  @override
  State<_RemindersTile> createState() => _RemindersTileState();
}

final class _RemindersTileState extends State<_RemindersTile>
    with WidgetsBindingObserver {
  bool _enabled = false;
  bool _permitted = true;
  bool _busy = false;

  StreakReminder get _reminder => getIt<StreakReminder>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_load());
  }

  @override
  void didUpdateWidget(covariant _RemindersTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.uid != oldWidget.uid) unawaited(_load());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) unawaited(_load());
  }

  Future<void> _load() async {
    try {
      final uid = widget.uid;
      var enabled = await _reminder.isEnabled();
      final permitted = await _reminder.permitted();
      // The old 08:00 push becomes the local streak reminder, so nobody
      // gets both.
      if (uid != null && mounted) {
        final registration = context.read<ReminderRegistration>();
        final server = await registration.load(uid);
        if (server.enabled) {
          await registration.disable(uid);
          if (!enabled && permitted) enabled = await _reminder.enable();
        }
      }
      if (mounted) {
        setState(() {
          _enabled = enabled;
          _permitted = permitted || !enabled;
        });
      }
    } on Object {
      // Settings remain usable with the last displayed state.
    }
  }

  Future<void> _setEnabled(bool enabled) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      if (enabled) {
        final on = await _reminder.enable();
        final uid = widget.uid;
        if (on && uid != null && mounted) {
          await context.read<ReminderRegistration>().disable(uid);
        }
        if (mounted) {
          setState(() {
            _enabled = on;
            _permitted = on;
          });
        }
      } else {
        await _reminder.disable();
        if (mounted) setState(() => _enabled = false);
      }
    } on Object {
      if (mounted) await _load();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final denied = !_permitted;
    return Column(
      children: [
        SwitchListTile(
          key: const ValueKey('streak-reminder'),
          secondary: const Icon(
            Icons.access_time_rounded,
            color: MichiColors.textSecondary,
          ),
          title: Text(
            context.t.settings.reminders,
            style: MichiTypography.body,
          ),
          subtitle: Text(
            denied
                ? context.t.settings.reminderPermission
                : context.t.settings.streakReminderDetail,
          ),
          value: _enabled,
          activeThumbColor: MichiColors.ivory,
          activeTrackColor: MichiColors.indigo,
          inactiveThumbColor: MichiColors.ivory,
          inactiveTrackColor: MichiColors.cream,
          onChanged: _busy ? null : _setEnabled,
        ),
        if (denied)
          TextButton(
            onPressed: openAppSettings,
            child: Text(context.t.settings.reminderPermission),
          ),
      ],
    );
  }
}
