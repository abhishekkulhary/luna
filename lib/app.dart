import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/cycle/cycle_providers.dart';
import 'core/db/providers.dart';
import 'core/models/enums.dart';
import 'core/notifications/notification_providers.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/lock/lock_gate.dart';
import 'features/onboarding/onboarding_gate.dart';
import 'l10n/app_localizations.dart';

/// Root widget: wires the router, themes and notification syncing.
class PeriodTrackerApp extends ConsumerWidget {
  const PeriodTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // Keep scheduled notifications in sync with predictions, settings and reminders.
    ref.listen(cycleForecastProvider, (_, forecast) {
      final s = ref.read(settingsProvider).value;
      if (s != null) {
        ref.read(notificationSchedulerProvider).syncCycle(forecast, s);
      }
    });
    ref.listen(settingsProvider, (_, next) {
      final s = next.value;
      if (s != null) {
        ref
            .read(notificationSchedulerProvider)
            .syncCycle(ref.read(cycleForecastProvider), s);
      }
    });
    ref.listen(remindersProvider, (_, next) {
      final list = next.value;
      if (list != null) {
        ref.read(notificationSchedulerProvider).syncReminders(list);
      }
    });

    final settings = ref.watch(settingsProvider).value;
    final themeMode = switch (settings?.themeMode) {
      ThemeModeSetting.light => ThemeMode.light,
      ThemeModeSetting.dark => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    // A null languageCode follows the system locale.
    final locale =
        settings?.languageCode != null ? Locale(settings!.languageCode!) : null;

    return MaterialApp.router(
      title: 'Luna',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) => LockGate(
        child: OnboardingGate(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
