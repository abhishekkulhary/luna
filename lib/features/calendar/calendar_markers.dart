import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cycle/cycle_providers.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/utils/date_helpers.dart';

/// Pre-computed day sets used to paint the calendar quickly without recomputing
/// per cell. Combines logged flow/logs with the forecast.
class CalendarMarkers {
  const CalendarMarkers({
    required this.actualPeriod,
    required this.predictedPeriod,
    required this.fertile,
    required this.ovulation,
    required this.logged,
  });

  final Set<DateTime> actualPeriod;
  final Set<DateTime> predictedPeriod;
  final Set<DateTime> fertile;
  final Set<DateTime> ovulation;
  final Set<DateTime> logged;

  bool isActualPeriod(DateTime d) => actualPeriod.contains(dateOnly(d));
  bool isPredictedPeriod(DateTime d) => predictedPeriod.contains(dateOnly(d));
  bool isFertile(DateTime d) => fertile.contains(dateOnly(d));
  bool isOvulation(DateTime d) => ovulation.contains(dateOnly(d));
  bool hasLog(DateTime d) => logged.contains(dateOnly(d));
}

final calendarMarkersProvider = Provider<CalendarMarkers>((ref) {
  final logs = ref.watch(allLogsProvider).value ?? const <DailyLog>[];
  final forecast = ref.watch(cycleForecastProvider);

  final actual = <DateTime>{
    for (final l in logs)
      if (l.flow != FlowIntensity.none) dateOnly(l.date),
  };

  final predicted = <DateTime>{};
  final fertile = <DateTime>{};
  final ovulation = <DateTime>{};
  for (final c in forecast.cycles) {
    if (!c.isActual) predicted.addAll(c.periodRange.days);
    fertile.addAll(c.fertileWindow.days);
    ovulation.add(c.ovulationDay);
  }

  // Logged bleeding days win over any forecast overlay.
  predicted.removeAll(actual);
  fertile.removeAll(actual);
  ovulation.removeWhere(actual.contains);

  final logged = {for (final l in logs) dateOnly(l.date)};

  return CalendarMarkers(
    actualPeriod: actual,
    predictedPeriod: predicted,
    fertile: fertile,
    ovulation: ovulation,
    logged: logged,
  );
});
