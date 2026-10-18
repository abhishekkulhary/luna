import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../db/app_database.dart';
import '../db/providers.dart';
import '../utils/date_helpers.dart';
import 'cycle_forecast.dart';
import 'cycle_models.dart';
import 'cycle_predictor.dart';
import 'period_grouping.dart';

/// All days (normalized) that have logged bleeding (flow != none).
final bleedingDaysProvider = Provider<List<DateTime>>((ref) {
  final logs = ref.watch(allLogsProvider).value ?? const <DailyLog>[];
  return [
    for (final l in logs)
      if (l.flow != FlowIntensity.none) dateOnly(l.date),
  ];
});

/// Period spans derived from bleeding days, feeding the predictor and calendar.
final periodSpansProvider = Provider<List<PeriodInput>>((ref) {
  return groupBleedingDays(ref.watch(bleedingDaysProvider));
});

/// Runs the [CyclePredictor] over the derived period spans + user settings and
/// exposes the resulting [CycleForecast]. Recomputes when logs or settings change.
final cycleForecastProvider = Provider<CycleForecast>((ref) {
  final spans = ref.watch(periodSpansProvider);
  final s = ref.watch(settingsProvider).value;

  final settings = s == null
      ? const CycleSettings()
      : CycleSettings(
          defaultCycleLength: s.avgCycleLength,
          defaultPeriodLength: s.avgPeriodLength,
          lutealPhaseLength: s.lutealPhaseLength,
          adaptFromHistory: s.adaptFromHistory,
        );

  return const CyclePredictor().forecast(periods: spans, settings: settings);
});
