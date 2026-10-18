import '../utils/date_helpers.dart';

/// The biological phase of a given day within a cycle.
enum CyclePhase { menstruation, follicular, fertile, ovulation, luteal }

/// An inclusive range of whole days.
class DateRange {
  DateRange(DateTime start, DateTime end)
      : start = dateOnly(start),
        end = dateOnly(end);

  final DateTime start;
  final DateTime end;

  bool contains(DateTime day) {
    final d = dateOnly(day);
    return !d.isBefore(start) && !d.isAfter(end);
  }

  int get lengthInDays => daysBetween(start, end) + 1;

  List<DateTime> get days =>
      [for (var i = 0; i < lengthInDays; i++) addDays(start, i)];

  @override
  String toString() => 'DateRange($start..$end)';
}

/// Raw period input for the predictor (decoupled from the Drift row type so the
/// engine stays free of Flutter/Drift dependencies).
class PeriodInput {
  const PeriodInput(this.start, [this.end]);
  final DateTime start;
  final DateTime? end;
}

/// Cycle parameters and whether to adapt them from logged history.
class CycleSettings {
  const CycleSettings({
    this.defaultCycleLength = 28,
    this.defaultPeriodLength = 5,
    this.lutealPhaseLength = 14,
    this.adaptFromHistory = true,
  });

  final int defaultCycleLength;
  final int defaultPeriodLength;
  final int lutealPhaseLength;
  final bool adaptFromHistory;
}

/// One projected cycle: its period span, ovulation day and fertile window.
class PredictedCycle {
  const PredictedCycle({
    required this.periodStart,
    required this.periodEnd,
    required this.ovulationDay,
    required this.fertileWindow,
    required this.isActual,
  });

  final DateTime periodStart;
  final DateTime periodEnd;
  final DateTime ovulationDay;
  final DateRange fertileWindow;

  /// True when this cycle's period corresponds to the last *logged* period
  /// (the current cycle), false for purely forecast future cycles.
  final bool isActual;

  DateRange get periodRange => DateRange(periodStart, periodEnd);
}
