import 'dart:math';

import '../utils/date_helpers.dart';
import 'cycle_forecast.dart';
import 'cycle_models.dart';

/// Pure-Dart menstrual-cycle predictor.
///
/// Derives the average cycle and period length from logged history (falling
/// back to the user's defaults) and projects the current plus upcoming cycles,
/// each with its ovulation day and fertile window.
class CyclePredictor {
  const CyclePredictor();

  /// Plausible bounds used to ignore obvious logging gaps/outliers.
  static const _minCycle = 15;
  static const _maxCycle = 60;
  static const _cycleClampLow = 20;
  static const _cycleClampHigh = 45;
  static const _maxPeriodLength = 15;

  CycleForecast forecast({
    required List<PeriodInput> periods,
    CycleSettings settings = const CycleSettings(),
    DateTime? asOf,
    int upcomingCount = 6,
  }) {
    if (periods.isEmpty) return CycleForecast.empty(settings);

    final starts = periods.map((p) => dateOnly(p.start)).toList()..sort();
    final lastStart = starts.last;

    final cycleStats = _cycleLength(starts, settings);
    final periodLength = _periodLength(periods, settings);
    final luteal = settings.lutealPhaseLength;
    final cycleLength = cycleStats.length;

    final cycles = <PredictedCycle>[];
    for (var n = 0; n <= upcomingCount; n++) {
      final start = addDays(lastStart, cycleLength * n);
      final nextStart = addDays(start, cycleLength);
      final ovulation = addDays(nextStart, -luteal);
      cycles.add(
        PredictedCycle(
          periodStart: start,
          periodEnd: addDays(start, periodLength - 1),
          ovulationDay: ovulation,
          fertileWindow: DateRange(addDays(ovulation, -5), addDays(ovulation, 1)),
          isActual: n == 0,
        ),
      );
    }

    return CycleForecast(
      cycleLength: cycleLength,
      periodLength: periodLength,
      lutealPhaseLength: luteal,
      cycleLengthStdDev: cycleStats.stdDev,
      historyCycleCount: cycleStats.sampleCount,
      lastPeriodStart: lastStart,
      cycles: cycles,
    );
  }

  ({int length, double? stdDev, int sampleCount}) _cycleLength(
    List<DateTime> sortedStarts,
    CycleSettings settings,
  ) {
    final gaps = <int>[];
    for (var i = 1; i < sortedStarts.length; i++) {
      final g = daysBetween(sortedStarts[i - 1], sortedStarts[i]);
      if (g >= _minCycle && g <= _maxCycle) gaps.add(g);
    }

    if (!settings.adaptFromHistory || gaps.isEmpty) {
      return (length: settings.defaultCycleLength, stdDev: null, sampleCount: 0);
    }

    final mean = gaps.reduce((a, b) => a + b) / gaps.length;
    final length = mean.round().clamp(_cycleClampLow, _cycleClampHigh).toInt();

    double? stdDev;
    if (gaps.length >= 2) {
      final variance =
          gaps.map((g) => pow(g - mean, 2)).reduce((a, b) => a + b) /
              gaps.length;
      stdDev = sqrt(variance);
    }
    return (length: length, stdDev: stdDev, sampleCount: gaps.length);
  }

  int _periodLength(List<PeriodInput> periods, CycleSettings settings) {
    final lengths = <int>[];
    for (final p in periods) {
      if (p.end == null) continue;
      final len = daysBetween(p.start, p.end!) + 1;
      if (len >= 1 && len <= _maxPeriodLength) lengths.add(len);
    }
    if (!settings.adaptFromHistory || lengths.isEmpty) {
      return settings.defaultPeriodLength;
    }
    final mean = lengths.reduce((a, b) => a + b) / lengths.length;
    return mean.round().clamp(1, 14).toInt();
  }
}
