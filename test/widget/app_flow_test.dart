// Integration test for the cycle pipeline wiring: bleeding days flow through
// period grouping and the predictor into the forecast. Uses a ProviderContainer
// with the upstream bleeding-days provider overridden (no Drift streams).
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/cycle/cycle_providers.dart';
import 'package:luna/core/db/app_database.dart';
import 'package:luna/core/db/providers.dart';
import 'package:luna/core/utils/date_helpers.dart';

void main() {
  test('bleeding days produce a forecast through the provider pipeline', () {
    final container = ProviderContainer(
      overrides: [
        bleedingDaysProvider.overrideWithValue([
          addDays(today(), -2),
          addDays(today(), -1),
          today(),
        ]),
        // The forecast also watches settings. Left real, that opens the
        // encrypted database in the background, which fails intermittently on
        // the Linux CI runner; an empty stream keeps the default settings.
        settingsProvider.overrideWith((ref) => const Stream<AppSetting>.empty()),
      ],
    );
    addTearDown(container.dispose);

    final spans = container.read(periodSpansProvider);
    expect(spans, hasLength(1));
    expect(spans.single.start, addDays(today(), -2));
    expect(spans.single.end, today());

    final forecast = container.read(cycleForecastProvider);
    expect(forecast.hasData, isTrue);
    expect(forecast.cycleLength, 28); // single span -> default cycle length
    expect(forecast.periodLength, 3); // derived from the 3-day logged span
    expect(forecast.nextPeriodStart, addDays(today(), 26)); // start + 28
    expect(forecast.phaseOn(today()), isNotNull);
  });
}
