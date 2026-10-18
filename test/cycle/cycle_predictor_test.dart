import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/cycle/cycle_models.dart';
import 'package:luna/core/cycle/cycle_predictor.dart';

void main() {
  const predictor = CyclePredictor();
  const settings = CycleSettings(); // 28 / 5 / 14, adaptFromHistory: true

  /// Builds period inputs every 28 days starting at [first], each 5 days long.
  /// Uses calendar (not Duration) arithmetic so it is daylight-saving safe.
  List<PeriodInput> regularPeriods(DateTime first, int count) {
    DateTime at(int offset) =>
        DateTime(first.year, first.month, first.day + offset);
    return [
      for (var i = 0; i < count; i++)
        PeriodInput(at(28 * i), at(28 * i + 4)),
    ];
  }

  group('no data', () {
    test('returns an empty forecast using default parameters', () {
      final f = predictor.forecast(periods: const [], settings: settings);
      expect(f.hasData, isFalse);
      expect(f.cycleLength, 28);
      expect(f.periodLength, 5);
      expect(f.cycles, isEmpty);
      expect(f.nextPeriodStart, isNull);
      expect(f.currentCycleDay(DateTime(2026, 6, 1)), isNull);
    });
  });

  group('single period', () {
    test('uses default cycle length and projects the next start', () {
      final f = predictor.forecast(
        periods: [PeriodInput(DateTime(2026, 6, 1), DateTime(2026, 6, 5))],
        settings: settings,
        asOf: DateTime(2026, 6, 3),
      );
      expect(f.hasData, isTrue);
      expect(f.historyCycleCount, 0);
      expect(f.cycleLength, 28);
      expect(f.cycleLengthStdDev, isNull);
      expect(f.nextPeriodStart, DateTime(2026, 6, 29));
      expect(f.currentCycleDay(DateTime(2026, 6, 3)), 3);
      expect(f.daysUntilNextPeriod(DateTime(2026, 6, 3)), 26);
    });
  });

  group('regular cycles', () {
    final periods = regularPeriods(DateTime(2026, 1, 1), 4); // 4 starts, 28d

    test('derives a 28-day cycle with zero deviation', () {
      final f = predictor.forecast(periods: periods, settings: settings);
      expect(f.cycleLength, 28);
      expect(f.historyCycleCount, 3);
      expect(f.cycleLengthStdDev, closeTo(0, 1e-9));
      expect(f.isRegular, isTrue);
      // last start is Jan 1 + 28*3 = Mar 26
      expect(f.lastPeriodStart, DateTime(2026, 3, 26));
      expect(f.nextPeriodStart, DateTime(2026, 4, 23));
    });

    test('computes ovulation 14 days before the next period', () {
      final f = predictor.forecast(periods: periods, settings: settings);
      final current = f.cycles.first;
      // ovulation = (lastStart + 28) - 14 = lastStart + 14 = Apr 9
      expect(current.ovulationDay, DateTime(2026, 4, 9));
      // fertile window = ovulation - 5 .. ovulation + 1
      expect(current.fertileWindow.start, DateTime(2026, 4, 4));
      expect(current.fertileWindow.end, DateTime(2026, 4, 10));
      expect(current.fertileWindow.lengthInDays, 7);
    });

    test('classifies phases through the current cycle', () {
      final f = predictor.forecast(periods: periods, settings: settings);
      // current cycle starts Mar 26, period Mar 26..Mar 30, fertile Apr 4..10,
      // ovulation Apr 9, next period Apr 23.
      expect(f.phaseOn(DateTime(2026, 3, 26)), CyclePhase.menstruation);
      expect(f.phaseOn(DateTime(2026, 3, 30)), CyclePhase.menstruation);
      expect(f.phaseOn(DateTime(2026, 4, 2)), CyclePhase.follicular);
      expect(f.phaseOn(DateTime(2026, 4, 5)), CyclePhase.fertile);
      expect(f.phaseOn(DateTime(2026, 4, 9)), CyclePhase.ovulation);
      expect(f.phaseOn(DateTime(2026, 4, 15)), CyclePhase.luteal);
    });

    test('projects the requested number of upcoming cycles', () {
      final f = predictor.forecast(
        periods: periods,
        settings: settings,
        upcomingCount: 3,
      );
      expect(f.cycles, hasLength(4)); // current + 3
      expect(f.cycles[1].periodStart, DateTime(2026, 4, 23));
      expect(f.cycles[2].periodStart, DateTime(2026, 5, 21));
      expect(f.cycles[1].isActual, isFalse);
    });
  });

  group('irregular cycles', () {
    test('averages varying gaps and reports deviation', () {
      // Gaps of 26, 30, 34 days -> mean 30.
      final starts = [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 27), // +26
        DateTime(2026, 2, 26), // +30
        DateTime(2026, 4, 1), // +34
      ];
      final f = predictor.forecast(
        periods: [for (final s in starts) PeriodInput(s)],
        settings: settings,
      );
      expect(f.cycleLength, 30);
      expect(f.historyCycleCount, 3);
      expect(f.cycleLengthStdDev, greaterThan(3));
      expect(f.isRegular, isFalse);
    });

    test('ignores implausible gaps (missed logging)', () {
      // A 200-day gap (forgot to log) should be excluded from the average.
      final starts = [
        DateTime(2026, 1, 1),
        DateTime(2026, 1, 29), // +28
        DateTime(2026, 8, 17), // +200 -> ignored
        DateTime(2026, 9, 14), // +28
      ];
      final f = predictor.forecast(
        periods: [for (final s in starts) PeriodInput(s)],
        settings: settings,
      );
      expect(f.cycleLength, 28);
      expect(f.historyCycleCount, 2); // only the two 28-day gaps counted
    });
  });

  group('period length', () {
    test('averages logged period lengths', () {
      // Lengths 4, 6, 5 -> mean 5.
      final periods = [
        PeriodInput(DateTime(2026, 1, 1), DateTime(2026, 1, 4)), // 4
        PeriodInput(DateTime(2026, 1, 29), DateTime(2026, 2, 3)), // 6
        PeriodInput(DateTime(2026, 2, 26), DateTime(2026, 3, 2)), // 5
      ];
      final f = predictor.forecast(periods: periods, settings: settings);
      expect(f.periodLength, 5);
      expect(f.cycles.first.periodRange.lengthInDays, 5);
    });

    test('falls back to default when no period has ended', () {
      final f = predictor.forecast(
        periods: [PeriodInput(DateTime(2026, 6, 1))], // ongoing, no end
        settings: settings,
      );
      expect(f.periodLength, 5);
    });
  });

  group('adaptFromHistory disabled', () {
    test('uses fixed defaults despite history', () {
      final periods = [
        PeriodInput(DateTime(2026, 1, 1), DateTime(2026, 1, 7)),
        PeriodInput(DateTime(2026, 2, 4), DateTime(2026, 2, 10)), // +34
      ];
      final f = predictor.forecast(
        periods: periods,
        settings: const CycleSettings(adaptFromHistory: false),
      );
      expect(f.cycleLength, 28);
      expect(f.periodLength, 5);
      expect(f.historyCycleCount, 0);
    });
  });

  group('date math', () {
    test('handles month and leap-year boundaries', () {
      // Feb 2 -> +28 = Mar 1 (2026 is not a leap year).
      final f = predictor.forecast(
        periods: [PeriodInput(DateTime(2026, 2, 2))],
        settings: settings,
      );
      expect(f.nextPeriodStart, DateTime(2026, 3, 2));

      // 2024 is a leap year: Feb 1 + 28 = Feb 29.
      final leap = predictor.forecast(
        periods: [PeriodInput(DateTime(2024, 2, 1))],
        settings: settings,
      );
      expect(leap.nextPeriodStart, DateTime(2024, 2, 29));
    });

    test('strips time-of-day from inputs', () {
      final f = predictor.forecast(
        periods: [PeriodInput(DateTime(2026, 6, 1, 23, 59))],
        settings: settings,
      );
      expect(f.lastPeriodStart, DateTime(2026, 6, 1));
    });
  });
}
