// Widget tests for isolated screens, driven by overridden providers so no live
// database streams are involved. Each host wires the localization delegates so
// screens can resolve AppLocalizations.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/db/app_database.dart';
import 'package:luna/core/db/providers.dart';
import 'package:luna/core/theme/app_theme.dart';
import 'package:luna/core/utils/pickers.dart';
import 'package:luna/features/insights/insights_data.dart';
import 'package:luna/features/insights/insights_screen.dart';
import 'package:luna/features/onboarding/onboarding_screen.dart';
import 'package:luna/l10n/app_localizations.dart';

Widget _wrap(Widget home) => MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

Widget _hostInsights(InsightsData data) => ProviderScope(
      overrides: [insightsProvider.overrideWithValue(data)],
      child: _wrap(const InsightsScreen()),
    );

// Onboarding's language step watches settingsProvider; override it with an empty
// stream so the test never opens the real (encrypted) database.
Widget _hostOnboarding() => ProviderScope(
      overrides: [
        settingsProvider.overrideWith((ref) => const Stream<AppSetting>.empty()),
      ],
      child: _wrap(const OnboardingScreen()),
    );

void main() {
  testWidgets('shows averages and regularity when data exists', (tester) async {
    await tester.pumpWidget(_hostInsights(const InsightsData(
      hasData: true,
      avgCycleLength: 29,
      avgPeriodLength: 5,
      cycleLengthStdDev: 1.2,
      isRegular: true,
      cyclesTracked: 4,
      records: [],
      topSymptoms: [],
    )));
    await tester.pump();

    expect(find.text('29'), findsOneWidget); // avg cycle length
    expect(find.text('Regular'), findsOneWidget);
  });

  testWidgets('shows the empty state with no data', (tester) async {
    await tester.pumpWidget(_hostInsights(const InsightsData(
      hasData: false,
      avgCycleLength: 28,
      avgPeriodLength: 5,
      cycleLengthStdDev: null,
      isRegular: false,
      cyclesTracked: 0,
      records: [],
      topSymptoms: [],
    )));
    await tester.pump();

    expect(find.textContaining('unlock insights'), findsOneWidget);
  });

  testWidgets('onboarding first page shows welcome and language options',
      (tester) async {
    await tester.pumpWidget(_hostOnboarding());
    await tester.pumpAndSettle();

    // Page 0 combines the welcome message and the language chooser.
    expect(tester.takeException(), isNull);
    expect(find.text('Welcome to Luna'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Deutsch'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('onboarding last-period field opens a date picker',
      (tester) async {
    await tester.pumpWidget(_hostOnboarding());
    await tester.pumpAndSettle();

    // Welcome/Language -> Details.
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Last period start'), findsOneWidget);
    await tester.tap(find.text('Last period start'));
    await tester.pumpAndSettle();

    // The date picker opened (requires a Navigator ancestor + valid date range).
    expect(find.byType(DatePickerDialog), findsOneWidget);
  });

  testWidgets('pickTime opens the wheel time picker without a layout crash',
      (tester) async {
    await tester.pumpWidget(
      _wrap(
        Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () =>
                    pickTime(context, const TimeOfDay(hour: 9, minute: 0)),
                child: const Text('pick'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('pick'));
    await tester.pumpAndSettle();

    // The custom wheel picker renders (no Material clock dial to overflow).
    expect(tester.takeException(), isNull);
    expect(find.text('Select time'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);
  });
}
