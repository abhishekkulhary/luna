import '../utils/date_helpers.dart';
import 'cycle_models.dart';

/// The result of running the predictor: averaged cycle parameters plus the
/// current and upcoming projected cycles. All dates are day-normalized.
class CycleForecast {
  const CycleForecast({
    required this.cycleLength,
    required this.periodLength,
    required this.lutealPhaseLength,
    required this.cycleLengthStdDev,
    required this.historyCycleCount,
    required this.lastPeriodStart,
    required this.cycles,
  });

  /// Empty forecast used when there is no logged period yet.
  factory CycleForecast.empty(CycleSettings settings) => CycleForecast(
        cycleLength: settings.defaultCycleLength,
        periodLength: settings.defaultPeriodLength,
        lutealPhaseLength: settings.lutealPhaseLength,
        cycleLengthStdDev: null,
        historyCycleCount: 0,
        lastPeriodStart: null,
        cycles: const [],
      );

  final int cycleLength;
  final int periodLength;
  final int lutealPhaseLength;

  /// Standard deviation of historical cycle lengths (null with <2 gaps).
  final double? cycleLengthStdDev;

  /// Number of cycle gaps used to compute the average (0 = using defaults).
  final int historyCycleCount;

  final DateTime? lastPeriodStart;

  /// Current cycle (index 0) followed by upcoming forecast cycles.
  final List<PredictedCycle> cycles;

  bool get hasData => lastPeriodStart != null;

  /// A cycle is considered regular when its length varies little.
  bool get isRegular => cycleLengthStdDev != null && cycleLengthStdDev! <= 3.0;

  /// Forecast start of the next period.
  DateTime? get nextPeriodStart =>
      lastPeriodStart == null ? null : addDays(lastPeriodStart!, cycleLength);

  /// 1-based day number within the current cycle for [asOf], or null with no data.
  int? currentCycleDay([DateTime? asOf]) {
    if (lastPeriodStart == null) return null;
    final day = daysBetween(lastPeriodStart!, asOf ?? DateTime.now());
    return day < 0 ? null : day + 1;
  }

  /// Days from [asOf] until the next predicted period (negative if overdue).
  int? daysUntilNextPeriod([DateTime? asOf]) {
    final next = nextPeriodStart;
    if (next == null) return null;
    return daysBetween(asOf ?? DateTime.now(), next);
  }

  /// The forecast cycle whose span [periodStart, nextStart) contains [date].
  PredictedCycle? cycleContaining(DateTime date) {
    final d = dateOnly(date);
    for (final c in cycles) {
      final nextStart = addDays(c.periodStart, cycleLength);
      if (!d.isBefore(c.periodStart) && d.isBefore(nextStart)) return c;
    }
    return null;
  }

  /// The phase for [date], or null when no forecast cycle covers it.
  CyclePhase? phaseOn(DateTime date) {
    final c = cycleContaining(date);
    if (c == null) return null;
    final d = dateOnly(date);
    if (c.periodRange.contains(d)) return CyclePhase.menstruation;
    if (isSameDay(d, c.ovulationDay)) return CyclePhase.ovulation;
    if (c.fertileWindow.contains(d)) return CyclePhase.fertile;
    if (d.isAfter(c.ovulationDay)) return CyclePhase.luteal;
    return CyclePhase.follicular;
  }
}
