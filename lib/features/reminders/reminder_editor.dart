import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/utils/pickers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/luna_ui.dart';

String _weekdayLabel(AppLocalizations l, int weekday) => switch (weekday) {
  1 => l.weekdayMon,
  2 => l.weekdayTue,
  3 => l.weekdayWed,
  4 => l.weekdayThu,
  5 => l.weekdayFri,
  6 => l.weekdaySat,
  _ => l.weekdaySun,
};

/// Opens the add/edit sheet for a custom reminder.
Future<void> showReminderEditor(BuildContext context, {Reminder? existing}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    // Above the bottom navigation bar, like a full-screen sheet.
    useRootNavigator: true,
    builder: (_) => _ReminderEditor(existing: existing),
  );
}

class _ReminderEditor extends ConsumerStatefulWidget {
  const _ReminderEditor({this.existing});
  final Reminder? existing;

  @override
  ConsumerState<_ReminderEditor> createState() => _ReminderEditorState();
}

class _ReminderEditorState extends ConsumerState<_ReminderEditor> {
  late final TextEditingController _title;
  late final TextEditingController _body;
  late TimeOfDay _time;
  late ReminderRepeat _repeat;
  late int _weekday;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _title = TextEditingController(text: e?.title ?? '');
    _body = TextEditingController(text: e?.body ?? '');
    _time = e != null
        ? TimeOfDay(hour: e.hour, minute: e.minute)
        : const TimeOfDay(hour: 9, minute: 0);
    _repeat = e?.repeat ?? ReminderRepeat.daily;
    _weekday = e?.weekday ?? DateTime.now().weekday;
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _title.text.trim();
    if (title.isEmpty) return;
    final repo = ref.read(reminderRepositoryProvider);
    final weekday = _repeat == ReminderRepeat.weekly ? _weekday : null;
    final body = _body.text.trim().isEmpty ? null : _body.text.trim();

    if (widget.existing == null) {
      await repo.create(
        title: title,
        body: body,
        hour: _time.hour,
        minute: _time.minute,
        repeat: _repeat,
        weekday: weekday,
      );
    } else {
      await repo.updateDetails(
        id: widget.existing!.id,
        title: title,
        body: body,
        hour: _time.hour,
        minute: _time.minute,
        repeat: _repeat,
        weekday: weekday,
      );
    }
    await ref.read(notificationServiceProvider).requestPermissions();
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientText(
                widget.existing == null ? l10n.newReminder : l10n.editReminder,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _title,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: l10n.fieldTitle,
                  hintText: l10n.titleHint,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _body,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(labelText: l10n.noteOptional),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(l10n.timeLabel),
                trailing: GradientText(
                  _time.format(context),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                onTap: () async {
                  final picked = await pickTime(context, _time);
                  if (picked != null) setState(() => _time = picked);
                },
              ),
              const SizedBox(height: 8),
              SegmentedButton<ReminderRepeat>(
                segments: [
                  ButtonSegment(
                    value: ReminderRepeat.once,
                    label: Text(l10n.repeatOnce),
                  ),
                  ButtonSegment(
                    value: ReminderRepeat.daily,
                    label: Text(l10n.repeatDaily),
                  ),
                  ButtonSegment(
                    value: ReminderRepeat.weekly,
                    label: Text(l10n.repeatWeekly),
                  ),
                ],
                selected: {_repeat},
                onSelectionChanged: (s) => setState(() => _repeat = s.first),
              ),
              if (_repeat == ReminderRepeat.weekly) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  children: [
                    for (var d = 1; d <= 7; d++)
                      ChoiceChip(
                        label: Text(_weekdayLabel(l10n, d)),
                        selected: _weekday == d,
                        onSelected: (_) => setState(() => _weekday = d),
                      ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              GlowButton(
                expand: true,
                onPressed: _save,
                icon: Icons.check_rounded,
                label: l10n.saveReminder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
