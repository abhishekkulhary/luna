import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/cycle/cycle_providers.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/utils/date_helpers.dart';

/// One historical cycle for the insights history/chart.
class CycleRecord {
  const CycleRecord({
    required this.startDate,
    required this.periodLength,
    required this.cycleLength,
  });

  final DateTime startDate;
  final int periodLength;

  /// Length to the next period start; null for the latest (ongoing) cycle.
  final int? cycleLength;
}

/// Aggregated analytics derived from logged data.
class InsightsData {
  const InsightsData({
    required this.hasData,
    required this.avgCycleLength,
    required this.avgPeriodLength,
    required this.cycleLengthStdDev,
    required this.isRegular,
    required this.cyclesTracked,
    required this.records,
    required this.topSymptoms,
  });

  final bool hasData;
  final int avgCycleLength;
  final int avgPeriodLength;
  final double? cycleLengthStdDev;
  final bool isRegular;
  final int cyclesTracked;
  final List<CycleRecord> records;
  final List<MapEntry<Symptom, int>> topSymptoms;
}

final insightsProvider = Provider<InsightsData>((ref) {
  final spans = ref.watch(periodSpansProvider);
  final forecast = ref.watch(cycleForecastProvider);
  final logs = ref.watch(allLogsProvider).value ?? const <DailyLog>[];

  final records = <CycleRecord>[];
  for (var i = 0; i < spans.length; i++) {
    final span = spans[i];
    final periodLength = daysBetween(span.start, span.end ?? span.start) + 1;
    final cycleLength =
        i < spans.length - 1 ? daysBetween(span.start, spans[i + 1].start) : null;
    records.add(CycleRecord(
      startDate: span.start,
      periodLength: periodLength,
      cycleLength: cycleLength,
    ));
  }

  final symptomCounts = <Symptom, int>{};
  for (final log in logs) {
    for (final s in log.symptoms) {
      symptomCounts.update(s, (v) => v + 1, ifAbsent: () => 1);
    }
  }
  final topSymptoms = symptomCounts.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return InsightsData(
    hasData: forecast.hasData,
    avgCycleLength: forecast.cycleLength,
    avgPeriodLength: forecast.periodLength,
    cycleLengthStdDev: forecast.cycleLengthStdDev,
    isRegular: forecast.isRegular,
    cyclesTracked: records.where((r) => r.cycleLength != null).length,
    records: records,
    topSymptoms: topSymptoms.take(6).toList(),
  );
});
