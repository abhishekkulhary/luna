import 'dart:convert';

import '../db/app_database.dart';
import '../utils/date_helpers.dart';

/// One logged day parsed from a backup, decoupled from Drift row types.
class BackupLog {
  const BackupLog({
    required this.date,
    required this.flow,
    required this.symptoms,
    required this.moods,
    required this.intimacy,
    this.notes,
    this.temperature,
  });

  final DateTime date;
  final FlowIntensity flow;
  final List<Symptom> symptoms;
  final List<Mood> moods;
  final bool intimacy;
  final String? notes;
  final double? temperature;
}

/// A parsed Luna backup: cycle settings (optional) and logged days.
class BackupData {
  const BackupData({
    required this.logs,
    this.avgCycleLength,
    this.avgPeriodLength,
    this.lutealPhaseLength,
  });

  final List<BackupLog> logs;
  final int? avgCycleLength;
  final int? avgPeriodLength;
  final int? lutealPhaseLength;
}

/// Serializes all logs + key settings to a pretty JSON string.
String buildBackupJson({
  required AppSetting settings,
  required List<DailyLog> logs,
}) {
  final map = {
    'app': 'Luna',
    'version': 1,
    'exportedAt': DateTime.now().toIso8601String(),
    'settings': {
      'avgCycleLength': settings.avgCycleLength,
      'avgPeriodLength': settings.avgPeriodLength,
      'lutealPhaseLength': settings.lutealPhaseLength,
    },
    'logs': [
      for (final l in logs)
        {
          'date': dateOnly(l.date).toIso8601String(),
          'flow': l.flow.name,
          'symptoms': [for (final s in l.symptoms) s.name],
          'moods': [for (final m in l.moods) m.name],
          'notes': l.notes,
          'temperature': l.temperature,
          'intimacy': l.intimacy,
        },
    ],
  };
  return const JsonEncoder.withIndent('  ').convert(map);
}

/// Parses a Luna backup, tolerating unknown/missing fields. Throws
/// [FormatException] if [source] isn't a recognizable backup.
BackupData parseBackupJson(String source) {
  final Object? decoded;
  try {
    decoded = jsonDecode(source);
  } catch (_) {
    throw const FormatException('Not valid JSON');
  }
  if (decoded is! Map) throw const FormatException('Not a Luna backup');
  final logsRaw = decoded['logs'];
  if (logsRaw is! List) throw const FormatException('Backup has no logs');

  final logs = <BackupLog>[];
  for (final raw in logsRaw) {
    if (raw is! Map) continue;
    final dateStr = raw['date'];
    final date = dateStr is String ? DateTime.tryParse(dateStr) : null;
    if (date == null) continue;
    logs.add(BackupLog(
      date: dateOnly(date),
      flow: _enumByName(FlowIntensity.values, raw['flow'], FlowIntensity.none),
      symptoms: _enumList(Symptom.values, raw['symptoms']),
      moods: _enumList(Mood.values, raw['moods']),
      notes: raw['notes'] is String ? raw['notes'] as String : null,
      temperature: (raw['temperature'] as num?)?.toDouble(),
      intimacy: raw['intimacy'] == true,
    ));
  }

  final settings = decoded['settings'];
  final s = settings is Map ? settings : const <dynamic, dynamic>{};
  return BackupData(
    logs: logs,
    avgCycleLength: (s['avgCycleLength'] as num?)?.toInt(),
    avgPeriodLength: (s['avgPeriodLength'] as num?)?.toInt(),
    lutealPhaseLength: (s['lutealPhaseLength'] as num?)?.toInt(),
  );
}

T _enumByName<T extends Enum>(List<T> values, Object? name, T fallback) {
  for (final v in values) {
    if (v.name == name) return v;
  }
  return fallback;
}

List<T> _enumList<T extends Enum>(List<T> values, Object? raw) {
  if (raw is! List) return <T>[];
  final byName = {for (final v in values) v.name: v};
  final result = <T>[];
  for (final e in raw) {
    final v = byName[e];
    if (v != null) result.add(v);
  }
  return result;
}
