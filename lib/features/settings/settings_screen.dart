import 'package:drift/drift.dart' show Value;
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/data/backup.dart';
import '../../core/data/backup_file.dart';
import '../../core/db/app_database.dart';
import '../../core/db/providers.dart';
import '../../core/notifications/notification_providers.dart';
import '../../core/security/lock_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/app_logo.dart';
import '../../shared/widgets/luna_ui.dart';
import '../get_the_app/build_stamp.dart';
import '../lock/pin_setup.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _patch(AppSettingsCompanion patch) =>
      ref.read(settingsRepositoryProvider).update(patch);

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: settingsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (s) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              children: [
                _Group(
                  title: l10n.sectionCycle,
                  children: [
                    _NumberTile(
                      title: l10n.avgCycleLength,
                      value: s.avgCycleLength,
                      min: 21,
                      max: 40,
                      onChanged: (v) =>
                          _patch(AppSettingsCompanion(avgCycleLength: Value(v))),
                    ),
                    _NumberTile(
                      title: l10n.avgPeriodLength,
                      value: s.avgPeriodLength,
                      min: 2,
                      max: 10,
                      onChanged: (v) => _patch(
                          AppSettingsCompanion(avgPeriodLength: Value(v))),
                    ),
                    _NumberTile(
                      title: l10n.lutealPhaseLength,
                      value: s.lutealPhaseLength,
                      min: 10,
                      max: 16,
                      onChanged: (v) => _patch(
                          AppSettingsCompanion(lutealPhaseLength: Value(v))),
                    ),
                    SwitchListTile(
                      title: Text(l10n.adaptToHistory),
                      subtitle: Text(l10n.adaptToHistorySub),
                      value: s.adaptFromHistory,
                      onChanged: (v) => _patch(
                          AppSettingsCompanion(adaptFromHistory: Value(v))),
                    ),
                  ],
                ),
                _Group(
                  title: l10n.sectionAppearance,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: SegmentedButton<ThemeModeSetting>(
                        showSelectedIcon: false,
                        segments: [
                          ButtonSegment(
                              value: ThemeModeSetting.system,
                              icon: const Icon(Icons.brightness_auto_outlined),
                              label: Text(l10n.themeSystem)),
                          ButtonSegment(
                              value: ThemeModeSetting.light,
                              icon: const Icon(Icons.light_mode_outlined),
                              label: Text(l10n.themeLight)),
                          ButtonSegment(
                              value: ThemeModeSetting.dark,
                              icon: const Icon(Icons.dark_mode_outlined),
                              label: Text(l10n.themeDark)),
                        ],
                        selected: {s.themeMode},
                        onSelectionChanged: (sel) => _patch(
                            AppSettingsCompanion(themeMode: Value(sel.first))),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.language_outlined),
                      title: Text(l10n.language),
                      subtitle: Text(_languageName(l10n, s.languageCode)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _chooseLanguage(s.languageCode),
                    ),
                  ],
                ),
                _Group(
                  title: l10n.sectionPrivacySecurity,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.lock_outline),
                      title: Text(l10n.appLock),
                      subtitle: Text(_lockLabel(l10n, s.lockType)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _chooseLock(s.lockType),
                    ),
                  ],
                ),
                _Group(
                  title: l10n.sectionData,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.save_alt),
                      title: Text(l10n.exportBackup),
                      subtitle: Text(l10n.exportBackupSub),
                      onTap: _exportToFile,
                    ),
                    ListTile(
                      leading: const Icon(Icons.file_open_outlined),
                      title: Text(l10n.importBackup),
                      subtitle: Text(l10n.importBackupSub),
                      onTap: _importFromFile,
                    ),
                    ListTile(
                      leading: const Icon(Icons.copy_all_outlined),
                      title: Text(l10n.copyAsJson),
                      subtitle: Text(l10n.copyAsJsonSub),
                      onTap: _exportData,
                    ),
                    ListTile(
                      leading: const Icon(Icons.content_paste_outlined),
                      title: Text(l10n.importFromClipboard),
                      subtitle: Text(l10n.importFromClipboardSub),
                      onTap: _importFromClipboard,
                    ),
                    ListTile(
                      leading: Icon(Icons.delete_forever_outlined,
                          color: Theme.of(context).colorScheme.error),
                      title: Text(l10n.deleteAllData,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.error)),
                      onTap: _deleteAll,
                    ),
                  ],
                ),
                _Group(
                  title: l10n.sectionAbout,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                      leading: const AppLogo(size: 44),
                      title: GradientText('Luna',
                          style: Theme.of(context).textTheme.titleLarge),
                      subtitle: Text(l10n.aboutSubtitle('1.0.0')),
                    ),
                    ListTile(
                      leading: const Icon(Icons.shield_outlined),
                      title: Text(l10n.privacyData),
                      subtitle: Text(l10n.privacyDataSub),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _showPrivacy,
                    ),
                    ListTile(
                      leading: const Icon(Icons.medical_information_outlined),
                      title: Text(l10n.medicalDisclaimer),
                      subtitle: Text(l10n.medicalDisclaimerSub),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _showDisclaimer,
                    ),
                  ],
                ),
                _Footnote(l10n.privacyNote),
                _Footnote(l10n.medicalDisclaimerNote),
                const SizedBox(height: 20),
                const Center(child: BuildStamp()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDisclaimer() {
    final l10n = AppLocalizations.of(context);
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.medical_information_outlined),
        title: Text(l10n.medicalDisclaimer),
        content: SingleChildScrollView(
          child: Text(l10n.disclaimerDialogBody),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.gotIt),
          ),
        ],
      ),
    );
  }

  Future<void> _showPrivacy() {
    final l10n = AppLocalizations.of(context);
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.lock_outline),
        title: Text(l10n.privacyDialogTitle),
        content: SingleChildScrollView(
          child: Text(l10n.privacyDialogBody),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.gotIt),
          ),
        ],
      ),
    );
  }

  String _lockLabel(AppLocalizations l10n, AppLockType type) => switch (type) {
        AppLockType.none => l10n.lockOff,
        AppLockType.pin => l10n.lockPin,
        AppLockType.biometric => l10n.lockBiometric,
      };

  String _languageName(AppLocalizations l10n, String? code) => switch (code) {
        'en' => 'English',
        'de' => 'Deutsch',
        _ => l10n.languageSystemDefault,
      };

  Future<void> _chooseLanguage(String? current) async {
    final l10n = AppLocalizations.of(context);
    // null = follow system; 'en'/'de' = explicit choice.
    const options = <String?>[null, 'en', 'de'];
    final choice = await showModalBottomSheet<Object?>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final code in options)
              ListTile(
                title: Text(_languageName(l10n, code)),
                trailing: code == current ? const Icon(Icons.check) : null,
                // Wrap in a list so a null selection is distinguishable from a
                // dismissed sheet (which returns null).
                onTap: () => Navigator.of(sheetContext).pop([code]),
              ),
          ],
        ),
      ),
    );
    if (choice is! List) return; // dismissed
    final code = choice.first as String?;
    if (code == current) return;
    _patch(AppSettingsCompanion(languageCode: Value(code)));
  }

  Future<void> _chooseLock(AppLockType current) async {
    final l10n = AppLocalizations.of(context);
    final choice = await showModalBottomSheet<AppLockType>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final t in AppLockType.values)
              ListTile(
                title: Text(_lockLabel(l10n, t)),
                trailing: t == current ? const Icon(Icons.check) : null,
                onTap: () => Navigator.of(sheetContext).pop(t),
              ),
          ],
        ),
      ),
    );
    if (choice == null || choice == current) return;
    await _applyLock(choice);
  }

  Future<void> _applyLock(AppLockType target) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final secure = ref.read(secureStoreProvider);

    if (target == AppLockType.none) {
      await secure.clearPin();
      _patch(const AppSettingsCompanion(lockType: Value(AppLockType.none)));
      ref.read(isLockedProvider.notifier).unlock();
      return;
    }

    // PIN is required for both pin and biometric (biometric falls back to PIN).
    if (!await secure.hasPin()) {
      if (!mounted) return;
      final ok = await showPinSetup(context);
      if (!ok) return;
    }

    var resolved = target;
    if (target == AppLockType.biometric) {
      final available = await ref.read(biometricAuthProvider).isAvailable();
      if (!available) {
        resolved = AppLockType.pin;
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.biometricsUnavailable),
        ));
      }
    }
    _patch(AppSettingsCompanion(lockType: Value(resolved)));
  }

  Future<String> _backupJson() async {
    final logs = await ref.read(logRepositoryProvider).getAll();
    final settings = await ref.read(settingsRepositoryProvider).get();
    return buildBackupJson(settings: settings, logs: logs);
  }

  Future<void> _exportData() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: await _backupJson()));
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.dataCopiedToClipboard)),
    );
  }

  Future<void> _exportToFile() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final json = await _backupJson();
    final fileName =
        'luna_backup_${DateTime.now().toIso8601String().substring(0, 10)}.json';

    final String path;
    try {
      path = await saveBackupFile(fileName, json);
    } catch (_) {
      // Web / write failure: fall back to clipboard.
      await Clipboard.setData(ClipboardData(text: json));
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.couldntSaveFile),
      ));
      return;
    }
    if (!mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle_outline),
        title: Text(l10n.backupSaved),
        content: SelectableText(path),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: path));
              Navigator.pop(dialogContext);
            },
            child: Text(l10n.copyPath),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.done),
          ),
        ],
      ),
    );
  }

  Future<void> _importFromFile() async {
    final typeGroup = XTypeGroup(
      label: AppLocalizations.of(context).backupFileTypeLabel,
      extensions: const ['json'],
      mimeTypes: const ['application/json'],
      uniformTypeIdentifiers: const ['public.json'],
    );
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file == null) return;
    await _restoreFrom(await file.readAsString());
  }

  Future<void> _importFromClipboard() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final clip = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clip?.text;
    if (text == null || text.trim().isEmpty) {
      messenger
          .showSnackBar(SnackBar(content: Text(l10n.clipboardEmpty)));
      return;
    }
    await _restoreFrom(text);
  }

  Future<void> _restoreFrom(String source) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final BackupData data;
    try {
      data = parseBackupJson(source);
    } on FormatException {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.notLunaBackup)),
      );
      return;
    }
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.importBackupQuestion),
        content: Text(l10n.importBackupBody(data.logs.length)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.importAction),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final logRepo = ref.read(logRepositoryProvider);
    for (final l in data.logs) {
      await logRepo.upsert(
        date: l.date,
        flow: l.flow,
        symptoms: l.symptoms,
        moods: l.moods,
        notes: l.notes,
        temperature: l.temperature,
        intimacy: l.intimacy,
      );
    }
    await ref.read(settingsRepositoryProvider).update(AppSettingsCompanion(
          avgCycleLength: data.avgCycleLength == null
              ? const Value.absent()
              : Value(data.avgCycleLength!),
          avgPeriodLength: data.avgPeriodLength == null
              ? const Value.absent()
              : Value(data.avgPeriodLength!),
          lutealPhaseLength: data.lutealPhaseLength == null
              ? const Value.absent()
              : Value(data.lutealPhaseLength!),
        ));
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.importedDays(data.logs.length))),
    );
  }

  Future<void> _deleteAll() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteAllQuestion),
        content: Text(l10n.deleteAllBody),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.deleteEverything),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    // Capture providers and reset lock state before the settings write, which
    // flips onboardingComplete -> false, swaps the gate and unmounts this screen.
    final logRepo = ref.read(logRepositoryProvider);
    final reminderRepo = ref.read(reminderRepositoryProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final secure = ref.read(secureStoreProvider);
    final settingsRepo = ref.read(settingsRepositoryProvider);
    ref.read(isLockedProvider.notifier).unlock();

    await logRepo.deleteAll();
    await reminderRepo.deleteAll();
    await notificationService.cancelAll();
    await secure.clearPin();
    await settingsRepo.update(
      const AppSettingsCompanion(
        avgCycleLength: Value(28),
        avgPeriodLength: Value(5),
        lutealPhaseLength: Value(14),
        lockType: Value(AppLockType.none),
        onboardingComplete: Value(false),
      ),
    );
  }
}

/// A titled group of settings rows on one glass card.
class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(title),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

class _Footnote extends StatelessWidget {
  const _Footnote(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      ),
    );
  }
}

class _NumberTile extends StatelessWidget {
  const _NumberTile({
    required this.title,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String title;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: value > min ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove_circle_outline_rounded),
          ),
          SizedBox(
            width: 48,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          IconButton(
            onPressed: value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
    );
  }
}
