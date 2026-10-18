import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart' hide isSameDay;

import '../../core/cycle/cycle_models.dart';
import '../../core/cycle/cycle_providers.dart';
import '../../core/db/providers.dart';
import '../../core/models/enum_labels.dart';
import '../../core/models/enums.dart';
import '../../core/theme/cycle_colors.dart';
import '../../core/utils/date_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../get_the_app/get_the_app_screen.dart';
import '../get_the_app/get_the_app_strings.dart';
import '../logging/log_editor.dart';
import 'calendar_markers.dart';

/// Maps a cycle phase to its accent color from the shared cycle palette.
Color phaseColor(BuildContext context, CyclePhase phase) {
  final c = context.cycleColors;
  return switch (phase) {
    CyclePhase.menstruation => c.period,
    CyclePhase.fertile => c.fertile,
    CyclePhase.ovulation => c.ovulation,
    CyclePhase.luteal => c.pms,
    CyclePhase.follicular => Theme.of(context).colorScheme.secondary,
  };
}

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  CalendarFormat _format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = today();
    _selectedDay = today();
  }

  @override
  Widget build(BuildContext context) {
    final markers = ref.watch(calendarMarkersProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calendarTitle),
        actions: [
          // The native apps are offered from the web build only.
          if (kIsWeb)
            IconButton(
              tooltip: GetTheAppStrings.of(context).getTheApp,
              icon: const Icon(Icons.download_outlined),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const GetTheAppScreen(appName: 'Luna'),
                ),
              ),
            ),
          IconButton(
            tooltip: l10n.today,
            icon: const Icon(Icons.today_outlined),
            onPressed: () => setState(() {
              _focusedDay = today();
              _selectedDay = today();
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showLogEditorSheet(context, _selectedDay),
        icon: const Icon(Icons.edit_calendar_outlined),
        label: Text(isSameDay(_selectedDay, today()) ? l10n.logToday : l10n.logDay),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          const _CycleStatusHeader(),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: _buildCalendar(markers),
            ),
          ),
          const _Legend(),
          _SelectedDayDetail(date: _selectedDay),
        ],
      ),
    );
  }

  Widget _buildCalendar(CalendarMarkers markers) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return TableCalendar<void>(
      firstDay: DateTime(today().year - 3),
      lastDay: DateTime(today().year + 3, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _format,
      locale: l10n.localeName,
      availableCalendarFormats: {
        CalendarFormat.month: l10n.calendarFormatMonth,
        CalendarFormat.week: l10n.calendarFormatWeek,
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
      onDaySelected: (selected, focused) => setState(() {
        _selectedDay = dateOnly(selected);
        _focusedDay = focused;
      }),
      onFormatChanged: (f) => setState(() => _format = f),
      onPageChanged: (focused) => _focusedDay = focused,
      headerStyle: HeaderStyle(
        formatButtonShowsNext: false,
        titleCentered: true,
        titleTextStyle: theme.textTheme.titleMedium!,
        formatButtonDecoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) => _DayCell(day: day, markers: markers),
        todayBuilder: (context, day, _) =>
            _DayCell(day: day, markers: markers, isToday: true),
        selectedBuilder: (context, day, _) =>
            _DayCell(day: day, markers: markers, isSelected: true),
        outsideBuilder: (context, day, _) =>
            _DayCell(day: day, markers: markers, isOutside: true),
      ),
    );
  }
}

/// One day in the calendar grid, styled by its cycle markers.
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.markers,
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
  });

  final DateTime day;
  final CalendarMarkers markers;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;

  @override
  Widget build(BuildContext context) {
    final cc = context.cycleColors;
    final scheme = Theme.of(context).colorScheme;

    Color? fill;
    Color? borderColor;
    Color textColor = isOutside ? scheme.onSurfaceVariant.withValues(alpha: 0.4) : scheme.onSurface;

    if (markers.isActualPeriod(day)) {
      fill = cc.period;
      textColor = Colors.white;
    } else if (markers.isOvulation(day)) {
      fill = cc.ovulation;
      textColor = Colors.white;
    } else if (markers.isPredictedPeriod(day)) {
      borderColor = cc.predictedPeriod;
      textColor = cc.period;
    } else if (markers.isFertile(day)) {
      fill = cc.fertileContainer;
      textColor = isOutside ? textColor : scheme.onSurface;
    }

    final ringColor = isSelected
        ? scheme.primary
        : isToday
            ? scheme.primary.withValues(alpha: 0.55)
            : null;

    final showDot = markers.hasLog(day) && fill == null;

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: fill,
        shape: BoxShape.circle,
        border: ringColor != null
            ? Border.all(color: ringColor, width: isSelected ? 2 : 1.5)
            : borderColor != null
                ? Border.all(color: borderColor, width: 1.5)
                : null,
      ),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '${day.day}',
            style: TextStyle(
              color: textColor,
              fontWeight:
                  isToday || isSelected ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
          if (showDot)
            Positioned(
              bottom: 4,
              child: Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Header card summarizing the current cycle state.
class _CycleStatusHeader extends ConsumerWidget {
  const _CycleStatusHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(cycleForecastProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (!forecast.hasData) {
      return Card(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.water_drop_outlined,
                  color: context.cycleColors.period, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  l10n.noPredictionsYet,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final phase = forecast.phaseOn(today());
    final cycleDay = forecast.currentCycleDay();
    final daysUntil = forecast.daysUntilNextPeriod();
    final accent =
        phase != null ? phaseColor(context, phase) : theme.colorScheme.primary;

    final String subtitle;
    if (daysUntil == null) {
      subtitle = '';
    } else if (daysUntil > 0) {
      subtitle = l10n.nextPeriodIn(daysUntil);
    } else if (daysUntil == 0) {
      subtitle = l10n.periodExpectedToday;
    } else {
      subtitle = l10n.periodLateBy(-daysUntil);
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [accent.withValues(alpha: 0.22), accent.withValues(alpha: 0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(
                cycleDay != null ? '$cycleDay' : '–',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phase != null ? phase.label(l10n) : l10n.calendarTitle,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  if (cycleDay != null)
                    Text(l10n.cycleDayOf(cycleDay),
                        style: theme.textTheme.bodyMedium),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(subtitle,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Legend explaining the calendar colors.
class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final cc = context.cycleColors;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          _LegendItem(color: cc.period, label: l10n.legendPeriod),
          _LegendItem(
              color: cc.predictedPeriod, label: l10n.legendPredicted, outline: true),
          _LegendItem(color: cc.fertileContainer, label: l10n.legendFertile),
          _LegendItem(color: cc.ovulation, label: l10n.legendOvulation),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    this.outline = false,
  });

  final Color color;
  final String label;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: outline ? null : color,
            shape: BoxShape.circle,
            border: outline ? Border.all(color: color, width: 2) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

/// Detail card for the selected day: phase, markers and logged data.
class _SelectedDayDetail extends ConsumerWidget {
  const _SelectedDayDetail({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final markers = ref.watch(calendarMarkersProvider);
    final forecast = ref.watch(cycleForecastProvider);
    final logAsync = ref.watch(logForDateProvider(date));
    final phase = forecast.phaseOn(date);

    final tags = <Widget>[
      if (markers.isActualPeriod(date))
        _Tag(l10n.legendPeriod, context.cycleColors.period),
      if (markers.isPredictedPeriod(date))
        _Tag(l10n.tagPredictedPeriod, context.cycleColors.predictedPeriod),
      if (markers.isOvulation(date))
        _Tag(l10n.legendOvulation, context.cycleColors.ovulation),
      if (markers.isFertile(date) && !markers.isOvulation(date))
        _Tag(l10n.legendFertile, context.cycleColors.fertile),
      if (phase != null && tagsEmpty(markers, date))
        _Tag(phase.label(l10n), phaseColor(context, phase)),
    ];

    return Card(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, d MMMM', l10n.localeName).format(date),
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            if (tags.isNotEmpty)
              Wrap(spacing: 8, runSpacing: 8, children: tags),
            logAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (log) {
                if (log == null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(l10n.noLogForDay,
                        style: theme.textTheme.bodyMedium),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (log.flow != FlowIntensity.none)
                        _DetailRow(
                          icon: log.flow.icon,
                          text: l10n.flowValueLabel(log.flow.label(l10n)),
                        ),
                      if (log.symptoms.isNotEmpty)
                        _DetailRow(
                          icon: Icons.healing_outlined,
                          text: log.symptoms.map((s) => s.label(l10n)).join(', '),
                        ),
                      if (log.moods.isNotEmpty)
                        _DetailRow(
                          icon: Icons.mood,
                          text: log.moods
                              .map((m) => '${m.emoji} ${m.label(l10n)}')
                              .join('  '),
                        ),
                      if ((log.notes ?? '').isNotEmpty)
                        _DetailRow(
                          icon: Icons.sticky_note_2_outlined,
                          text: log.notes!,
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () => showLogEditorSheet(context, date),
                icon: const Icon(Icons.edit_outlined),
                label: Text(l10n.editLog),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool tagsEmpty(CalendarMarkers m, DateTime d) =>
      !m.isActualPeriod(d) &&
      !m.isPredictedPeriod(d) &&
      !m.isOvulation(d) &&
      !m.isFertile(d);
}

class _Tag extends StatelessWidget {
  const _Tag(this.label, this.color);
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
