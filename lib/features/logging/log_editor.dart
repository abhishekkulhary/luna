import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/models/enum_labels.dart';
import '../../core/theme/cycle_colors.dart';
import '../../core/utils/date_helpers.dart';
import '../../l10n/app_localizations.dart';

/// Opens the daily log editor for [date] as a modal bottom sheet.
Future<void> showLogEditorSheet(
  BuildContext context,
  DateTime date,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => _LogEditorSheet(date: dateOnly(date)),
  );
}

class _LogEditorSheet extends ConsumerStatefulWidget {
  const _LogEditorSheet({required this.date});

  final DateTime date;

  @override
  ConsumerState<_LogEditorSheet> createState() => _LogEditorSheetState();
}

class _LogEditorSheetState extends ConsumerState<_LogEditorSheet> {
  FlowIntensity _flow = FlowIntensity.none;
  final Set<Symptom> _symptoms = {};
  final Set<Mood> _moods = {};
  final _notesController = TextEditingController();
  bool _intimacy = false;
  bool _loading = true;
  bool _existing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final log = await ref.read(logRepositoryProvider).getByDate(widget.date);
    if (!mounted) return;
    setState(() {
      if (log != null) {
        _existing = true;
        _flow = log.flow;
        _symptoms.addAll(log.symptoms);
        _moods.addAll(log.moods);
        _notesController.text = log.notes ?? '';
        _intimacy = log.intimacy;
      }
      _loading = false;
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  bool get _isEmpty =>
      _flow == FlowIntensity.none &&
      _symptoms.isEmpty &&
      _moods.isEmpty &&
      _notesController.text.trim().isEmpty &&
      !_intimacy;

  Future<void> _save() async {
    final repo = ref.read(logRepositoryProvider);
    if (_isEmpty) {
      await repo.deleteByDate(widget.date);
    } else {
      await repo.upsert(
        date: widget.date,
        flow: _flow,
        symptoms: _symptoms.toList(),
        moods: _moods.toList(),
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        intimacy: _intimacy,
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    await ref.read(logRepositoryProvider).deleteByDate(widget.date);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final dateLabel =
        DateFormat('EEEE, d MMMM', l10n.localeName).format(widget.date);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: _loading
            ? const SizedBox(
                height: 240,
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(dateLabel, style: theme.textTheme.titleLarge),
                        ),
                        if (_existing)
                          IconButton(
                            tooltip: l10n.deleteLog,
                            onPressed: _delete,
                            icon: const Icon(Icons.delete_outline),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _SectionLabel(l10n.sectionFlow),
                    _FlowSelector(
                      value: _flow,
                      onChanged: (f) => setState(() => _flow = f),
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel(l10n.sectionSymptoms),
                    _ChipWrap(
                      children: [
                        for (final s in Symptom.values)
                          FilterChip(
                            label: Text(s.label(l10n)),
                            selected: _symptoms.contains(s),
                            onSelected: (sel) => setState(
                              () => sel ? _symptoms.add(s) : _symptoms.remove(s),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel(l10n.sectionMood),
                    _ChipWrap(
                      children: [
                        for (final m in Mood.values)
                          FilterChip(
                            avatar: Text(m.emoji),
                            label: Text(m.label(l10n)),
                            selected: _moods.contains(m),
                            onSelected: (sel) => setState(
                              () => sel ? _moods.add(m) : _moods.remove(m),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SectionLabel(l10n.sectionNotes),
                    TextField(
                      controller: _notesController,
                      minLines: 2,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n.notesHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(l10n.intimacy),
                      secondary: const Icon(Icons.favorite_outline),
                      value: _intimacy,
                      onChanged: (v) => setState(() => _intimacy = v),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _save,
                        icon: const Icon(Icons.check),
                        label: Text(l10n.save),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _ChipWrap extends StatelessWidget {
  const _ChipWrap({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: children);
  }
}

class _FlowSelector extends StatelessWidget {
  const _FlowSelector({required this.value, required this.onChanged});

  final FlowIntensity value;
  final ValueChanged<FlowIntensity> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final period = context.cycleColors.period;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final f in FlowIntensity.values)
          ChoiceChip(
            avatar: Icon(
              f.icon,
              size: 18,
              color: value == f ? Colors.white : period,
            ),
            label: Text(f.label(l10n)),
            selected: value == f,
            selectedColor: period,
            labelStyle: TextStyle(
              color: value == f ? Colors.white : null,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => onChanged(f),
          ),
      ],
    );
  }
}
