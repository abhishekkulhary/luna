import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/theme/luna_palette.dart';
import '../../core/utils/date_helpers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/luna_ui.dart';

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
      body: LunaBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
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
                        GlowButton(
                          onPressed: _saving
                              ? null
                              : () {
                                  if (!isLast) {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOut,
                                    );
                                  } else {
                                    _finish();
                                  }
                                },
                          icon: isLast
                              ? Icons.auto_awesome_rounded
                              : Icons.arrow_forward_rounded,
                          label: isLast
                              ? l10n.getStarted
                              : l10n.onboardingContinue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: context.luna.accentStart.withValues(alpha: 0.5),
                  blurRadius: 36,
                  spreadRadius: -6,
                ),
              ],
            ),
            child: const AppLogo(size: 80),
          ),
          const SizedBox(height: 28),
          GradientText(
            l10n.welcomeTitle,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.welcomeBody,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          GlassPanel(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.lock_outline, color: context.luna.accentEnd),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.welcomePrivacy,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Text(l10n.chooseLanguage, style: theme.textTheme.titleMedium),
          const SizedBox(height: 2),
          Text(
            l10n.chooseLanguageSub,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
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
    final luna = context.luna;
    return GlassPanel(
      tint: selected ? luna.accentStart : null,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ),
          selected
              ? Icon(Icons.check_circle_rounded, color: luna.accentStart)
              : Icon(
                  Icons.radio_button_unchecked,
                  color: Theme.of(context).colorScheme.outline,
                ),
        ],
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
        GradientText(l10n.aFewDetails, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.event_outlined),
            title: Text(l10n.lastPeriodStart),
            subtitle: Text(
              DateFormat(
                'd MMMM yyyy',
                l10n.localeName,
              ).format(lastPeriodStart),
            ),
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
              child: Center(
                child: GradientText(
                  '$value',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
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
            width: i == active ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: i == active ? context.luna.accent : null,
              color: i == active ? null : Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
