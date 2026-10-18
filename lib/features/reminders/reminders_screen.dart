import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/theme/luna_palette.dart';
import '../../core/utils/pickers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/luna_ui.dart';
import 'reminder_editor.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final remindersAsync = ref.watch(remindersProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(l10n.remindersTitle)),
      floatingActionButton: GlowButton(
        onPressed: () => showReminderEditor(context),
        icon: Icons.add_alarm_outlined,
        label: l10n.addReminder,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 110),
            children: [
              if (kIsWeb) const _WebNotice(),
              settingsAsync.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => Text('$e'),
                data: (s) => _CycleNotifications(settings: s),
              ),
              SectionLabel(l10n.yourReminders),
              remindersAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (e, _) => Text('$e'),
                data: (reminders) => reminders.isEmpty
                    ? const _EmptyReminders()
                    : Column(
                        children: [
                          for (final r in reminders) _ReminderTile(reminder: r),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebNotice extends StatelessWidget {
  const _WebNotice();
  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      tint: context.luna.accentEnd,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: context.luna.accentEnd),
          const SizedBox(width: 12),
          Expanded(child: Text(AppLocalizations.of(context).webNotice)),
        ],
      ),
    );
  }
}

class _CycleNotifications extends ConsumerWidget {
  const _CycleNotifications({required this.settings});
  final AppSetting settings;

  void _patch(WidgetRef ref, AppSettingsCompanion patch) {
    ref.read(settingsRepositoryProvider).update(patch);
  }

  Future<void> _maybeAskPermission(WidgetRef ref, bool turningOn) async {
    if (turningOn) {
      await ref.read(notificationServiceProvider).requestPermissions();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final time = TimeOfDay(
      hour: settings.reminderHour,
      minute: settings.reminderMinute,
    );

    Widget toggle(
      String title,
      bool value,
      AppSettingsCompanion Function(bool) build,
    ) {
      return SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Text(title),
        value: value,
        onChanged: (v) {
          _patch(ref, build(v));
          _maybeAskPermission(ref, v);
        },
      );
    }

    return GlassPanel(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 2),
            child: Text(
              l10n.cycleNotifications,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: Text(l10n.notificationTime),
            trailing: GradientText(
              time.format(context),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            onTap: () async {
              final picked = await pickTime(context, time);
              if (picked != null) {
                _patch(
                  ref,
                  AppSettingsCompanion(
                    reminderHour: Value(picked.hour),
                    reminderMinute: Value(picked.minute),
                  ),
                );
              }
            },
          ),
          const Divider(height: 1),
          toggle(
            l10n.togglePeriodSoon,
            settings.notifyPeriodSoon,
            (v) => AppSettingsCompanion(notifyPeriodSoon: Value(v)),
          ),
          toggle(
            l10n.togglePeriodStart,
            settings.notifyPeriodStart,
            (v) => AppSettingsCompanion(notifyPeriodStart: Value(v)),
          ),
          toggle(
            l10n.toggleFertileStart,
            settings.notifyFertileWindow,
            (v) => AppSettingsCompanion(notifyFertileWindow: Value(v)),
          ),
          toggle(
            l10n.toggleOvulation,
            settings.notifyOvulation,
            (v) => AppSettingsCompanion(notifyOvulation: Value(v)),
          ),
          toggle(
            l10n.togglePms,
            settings.notifyPms,
            (v) => AppSettingsCompanion(notifyPms: Value(v)),
          ),
          toggle(
            l10n.togglePeriodLate,
            settings.notifyPeriodLate,
            (v) => AppSettingsCompanion(notifyPeriodLate: Value(v)),
          ),
        ],
      ),
    );
  }
}

class _ReminderTile extends ConsumerWidget {
  const _ReminderTile({required this.reminder});
  final Reminder reminder;

  String _subtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final time = TimeOfDay(
      hour: reminder.hour,
      minute: reminder.minute,
    ).format(context);
    final repeat = switch (reminder.repeat) {
      ReminderRepeat.once => l10n.repeatOnce,
      ReminderRepeat.daily => l10n.repeatDaily,
      ReminderRepeat.weekly => l10n.repeatWeekly,
    };
    return l10n.reminderSubtitle(time, repeat);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(reminder.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Icon(Icons.delete_outline),
      ),
      onDismissed: (_) {
        ref.read(reminderRepositoryProvider).delete(reminder.id);
        ref.read(notificationSchedulerProvider).cancelReminder(reminder.id);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 6, 12, 6),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.luna.accentEnd.withValues(alpha: 0.16),
            ),
            child: Icon(
              Icons.notifications_active_outlined,
              color: context.luna.accentEnd,
              size: 20,
            ),
          ),
          title: Text(
            reminder.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(_subtitle(context)),
          trailing: Switch(
            value: reminder.enabled,
            onChanged: (v) =>
                ref.read(reminderRepositoryProvider).setEnabled(reminder.id, v),
          ),
          onTap: () => showReminderEditor(context, existing: reminder),
        ),
      ),
    );
  }
}

class _EmptyReminders extends StatelessWidget {
  const _EmptyReminders();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 48,
            color: context.luna.accentEnd.withValues(alpha: 0.7),
          ),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context).noCustomReminders,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
