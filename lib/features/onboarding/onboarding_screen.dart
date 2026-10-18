import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/utils/date_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/app_logo.dart';

/// First-run flow: collects the last period date and typical cycle/period
/// length, seeds the initial logs, and marks onboarding complete.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  int _page = 0;

  DateTime _lastPeriodStart = addDays(today(), -14);
  int _cycleLength = 28;
  int _periodLength = 5;
  bool _enableNotifications = true;
  bool _saving = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    setState(() => _saving = true);

    // Capture providers up front: completing onboarding flips the gate and
    // unmounts this screen, after which `ref` must not be used.
    final settingsRepo = ref.read(settingsRepositoryProvider);
    final logRepo = ref.read(logRepositoryProvider);
    final notificationService = ref.read(notificationServiceProvider);

    // Seed the initial period from the chosen last-period date.
    final todayDate = today();
    for (var i = 0; i < _periodLength; i++) {
      final d = addDays(_lastPeriodStart, i);
      if (d.isAfter(todayDate)) break; // never log future days
      await logRepo.upsert(
        date: d,
        flow: FlowIntensity.medium,
        symptoms: const [],
        moods: const [],
      );
    }

    if (_enableNotifications) {
      await notificationService.requestPermissions();
    }

    // Persist settings + mark onboarding complete LAST — this swaps the gate to
    // the main app and unmounts this screen, so no `ref` use may follow.
    await settingsRepo.update(
      AppSettingsCompanion(
        avgCycleLength: Value(_cycleLength),
        avgPeriodLength: Value(_periodLength),
        onboardingComplete: const Value(true),
      ),
    );
  }

  static const _pageCount = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isLast = _page == _pageCount - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (p) => setState(() => _page = p),
                children: [
                  const _WelcomePage(),
                  _DetailsPage(
                    lastPeriodStart: _lastPeriodStart,
                    cycleLength: _cycleLength,
                    periodLength: _periodLength,
                    enableNotifications: _enableNotifications,
                    onPickDate: _pickDate,
                    onCycle: (v) => setState(() => _cycleLength = v),
                    onPeriod: (v) => setState(() => _periodLength = v),
                    onNotifications: (v) =>
                        setState(() => _enableNotifications = v),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  _Dots(count: _pageCount, active: _page),
                  const Spacer(),
                  FilledButton(
                    onPressed: _saving
                        ? null
                        : () {
                            if (!isLast) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                              );
                            } else {
                              _finish();
                            }
                          },
                    child: Text(
                        isLast ? l10n.getStarted : l10n.onboardingContinue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastPeriodStart,
      firstDate: addDays(today(), -365),
      lastDate: today(),
    );
    if (picked != null) setState(() => _lastPeriodStart = dateOnly(picked));
  }
}

/// First onboarding step: welcome message + language picker (the language
/// applies immediately so the rest of onboarding shows in the chosen language).
class _WelcomePage extends ConsumerWidget {
  const _WelcomePage();

  void _setLanguage(WidgetRef ref, String code) => ref
      .read(settingsRepositoryProvider)
      .update(AppSettingsCompanion(languageCode: Value(code)));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(settingsProvider).value?.languageCode;
    final active = current ?? Localizations.localeOf(context).languageCode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLogo(size: 72),
          const SizedBox(height: 24),
          Text(l10n.welcomeTitle,
              style: theme.textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text(l10n.welcomeBody, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.lock_outline, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child:
                    Text(l10n.welcomePrivacy, style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(l10n.chooseLanguage,
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 2),
          Text(l10n.chooseLanguageSub,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              )),
          const SizedBox(height: 12),
          _LangOption(
            label: 'English',
            selected: active == 'en',
            onTap: () => _setLanguage(ref, 'en'),
          ),
          const SizedBox(height: 12),
          _LangOption(
            label: 'Deutsch',
            selected: active == 'de',
            onTap: () => _setLanguage(ref, 'de'),
          ),
        ],
      ),
    );
  }
}

class _LangOption extends StatelessWidget {
  const _LangOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: selected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      child: ListTile(
        title: Text(label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            )),
        trailing: selected
            ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
            : const Icon(Icons.radio_button_unchecked),
        onTap: onTap,
      ),
    );
  }
}

class _DetailsPage extends StatelessWidget {
  const _DetailsPage({
    required this.lastPeriodStart,
    required this.cycleLength,
    required this.periodLength,
    required this.enableNotifications,
    required this.onPickDate,
    required this.onCycle,
    required this.onPeriod,
    required this.onNotifications,
  });

  final DateTime lastPeriodStart;
  final int cycleLength;
  final int periodLength;
  final bool enableNotifications;
  final VoidCallback onPickDate;
  final ValueChanged<int> onCycle;
  final ValueChanged<int> onPeriod;
  final ValueChanged<bool> onNotifications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text(l10n.aFewDetails,
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.event_outlined),
            title: Text(l10n.lastPeriodStart),
            subtitle: Text(DateFormat('d MMMM yyyy', l10n.localeName)
                .format(lastPeriodStart)),
            trailing: const Icon(Icons.edit_calendar_outlined),
            onTap: onPickDate,
          ),
        ),
        const SizedBox(height: 16),
        _Stepper(
          label: l10n.avgCycleLength,
          value: cycleLength,
          min: 21,
          max: 40,
          unit: l10n.daysUnit,
          onChanged: onCycle,
        ),
        const SizedBox(height: 12),
        _Stepper(
          label: l10n.avgPeriodLength,
          value: periodLength,
          min: 2,
          max: 10,
          unit: l10n.daysUnit,
          onChanged: onPeriod,
        ),
        const SizedBox(height: 16),
        Card(
          child: SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined),
            title: Text(l10n.enableReminders),
            subtitle: Text(l10n.enableRemindersSub),
            value: enableNotifications,
            onChanged: onNotifications,
          ),
        ),
      ],
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final String unit;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            IconButton.filledTonal(
              onPressed: value > min ? () => onChanged(value - 1) : null,
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 64,
              child: Text(
                '$value',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            IconButton.filledTonal(
              onPressed: value < max ? () => onChanged(value + 1) : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(right: 6),
            width: i == active ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
