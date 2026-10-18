import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// Shows a compact wheel-based time picker.
///
/// We deliberately avoid Material's `showTimePicker`: its clock dial has a fixed
/// minimum height that, in a slightly short dialog area, produces non-normalized
/// constraints and crashes (it lays the dial out even in keyboard-entry mode).
/// This picker is built from scrollable wheels, so it never overflows.
Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay initial) {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (_) => _WheelTimePicker(initial: initial),
  );
}

class _WheelTimePicker extends StatefulWidget {
  const _WheelTimePicker({required this.initial});

  final TimeOfDay initial;

  @override
  State<_WheelTimePicker> createState() => _WheelTimePickerState();
}

class _WheelTimePickerState extends State<_WheelTimePicker> {
  late int _hour = widget.initial.hour; // 0-23, the source of truth
  late int _minute = widget.initial.minute;

  FixedExtentScrollController? _hourCtrl;
  late final _minuteCtrl = FixedExtentScrollController(initialItem: _minute);
  bool _use24 = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hourCtrl == null) {
      _use24 = MediaQuery.of(context).alwaysUse24HourFormat;
      _hourCtrl =
          FixedExtentScrollController(initialItem: _use24 ? _hour : _hour % 12);
    }
  }

  @override
  void dispose() {
    _hourCtrl?.dispose();
    _minuteCtrl.dispose();
    super.dispose();
  }

  // Wheel values for the hour column.
  List<int> get _hourLabels => _use24
      ? List<int>.generate(24, (i) => i)
      : List<int>.generate(12, (i) => i == 0 ? 12 : i);

  bool get _isPm => _hour >= 12;

  void _onHourIndex(int index) {
    setState(() {
      if (_use24) {
        _hour = index;
      } else {
        final base = _hourLabels[index] % 12; // 12 -> 0
        _hour = _isPm ? base + 12 : base;
      }
    });
  }

  void _setPm(bool pm) {
    setState(() {
      final base = _hour % 12;
      _hour = pm ? base + 12 : base;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.pickTimeTitle),
      content: SizedBox(
        width: 280,
        height: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Wheel(
              controller: _hourCtrl!,
              count: _hourLabels.length,
              label: (i) => _hourLabels[i].toString().padLeft(2, '0'),
              onChanged: _onHourIndex,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(':', style: theme.textTheme.headlineMedium),
            ),
            _Wheel(
              controller: _minuteCtrl,
              count: 60,
              label: (i) => i.toString().padLeft(2, '0'),
              onChanged: (i) => setState(() => _minute = i),
            ),
            if (!_use24) ...[
              const SizedBox(width: 16),
              _AmPmToggle(isPm: _isPm, onChanged: _setPm),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () =>
              Navigator.pop(context, TimeOfDay(hour: _hour, minute: _minute)),
          child: Text(l10n.ok),
        ),
      ],
    );
  }
}

class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.controller,
    required this.count,
    required this.label,
    required this.onChanged,
  });

  final FixedExtentScrollController controller;
  final int count;
  final String Function(int) label;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 56,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 46,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 1.4,
        overAndUnderCenterOpacity: 0.35,
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: count,
          builder: (context, i) => Center(
            child: Text(
              label(i),
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class _AmPmToggle extends StatelessWidget {
  const _AmPmToggle({required this.isPm, required this.onChanged});

  final bool isPm;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final pm in [false, true])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: ChoiceChip(
              label: Text(pm ? 'PM' : 'AM'),
              selected: isPm == pm,
              onSelected: (_) => onChanged(pm),
            ),
          ),
      ],
    );
  }
}
