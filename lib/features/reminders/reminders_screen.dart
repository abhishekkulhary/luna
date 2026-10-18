import 'package:drift/drift.dart' show Value;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/utils/pickers.dart';
import '../../l10n/app_localizations.dart';
import 'reminder_editor.dart';

class RemindersScreen extends ConsumerWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsProvider);
    final remindersAsync = ref.watch(remindersProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.remindersTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showReminderEditor(context),
        icon: const Icon(Icons.add_alarm_outlined),
        label: Text(l10n.addReminder),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Text(l10n.yourReminders,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
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
    );
  }
}

class _WebNotice extends StatelessWidget {
  const _WebNotice();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(width: 12),
            Expanded(
              child: Text(AppLocalizations.of(context).webNotice),
            ),
          ],
        ),
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
    if (turningOn) await ref.read(notificationServiceProvider).requestPermissions();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final time = TimeOfDay(hour: settings.reminderHour, minute: settings.reminderMinute);

    Widget toggle(String title, bool value, AppSettingsCompanion Function(bool) build) {
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(l10n.cycleNotifications,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: Text(l10n.notificationTime),
              trailing: Text(time.format(context),
                  style: Theme.of(context).textTheme.titleMedium),
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
            toggle(l10n.togglePeriodSoon, settings.notifyPeriodSoon,
                (v) => AppSettingsCompanion(notifyPeriodSoon: Value(v))),
            toggle(l10n.togglePeriodStart, settings.notifyPeriodStart,
                (v) => AppSettingsCompanion(notifyPeriodStart: Value(v))),
            toggle(l10n.toggleFertileStart, settings.notifyFertileWindow,
                (v) => AppSettingsCompanion(notifyFertileWindow: Value(v))),
            toggle(l10n.toggleOvulation, settings.notifyOvulation,
                (v) => AppSettingsCompanion(notifyOvulation: Value(v))),
            toggle(l10n.togglePms, settings.notifyPms,
                (v) => AppSettingsCompanion(notifyPms: Value(v))),
            toggle(l10n.togglePeriodLate, settings.notifyPeriodLate,
                (v) => AppSettingsCompanion(notifyPeriodLate: Value(v))),
          ],
        ),
      ),
    );
  }
}

class _ReminderTile extends ConsumerWidget {
  const _ReminderTile({required this.reminder});
  final Reminder reminder;

  String _subtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final time = TimeOfDay(hour: reminder.hour, minute: reminder.minute)
        .format(context);
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
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline),
      ),
      onDismissed: (_) {
        ref.read(reminderRepositoryProvider).delete(reminder.id);
        ref.read(notificationSchedulerProvider).cancelReminder(reminder.id);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: const Icon(Icons.notifications_active_outlined),
          title: Text(reminder.title),
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
          Icon(Icons.notifications_none,
              size: 48, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context).noCustomReminders,
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
