import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/data/backup.dart';
import 'package:luna/core/db/app_database.dart';
import 'package:luna/core/db/repositories/log_repository.dart';
import 'package:luna/core/db/repositories/settings_repository.dart';

void main() {
  test('build → parse round-trips logs and settings', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    final logs = LogRepository(db);

    await logs.upsert(
      date: DateTime(2026, 6, 1),
      flow: FlowIntensity.medium,
      symptoms: const [Symptom.cramps, Symptom.headache],
      moods: const [Mood.tired],
      notes: 'rough day',
      intimacy: true,
    );

    final settings = await SettingsRepository(db).get();
    final json = buildBackupJson(settings: settings, logs: await logs.getAll());

    final parsed = parseBackupJson(json);
    expect(parsed.logs, hasLength(1));
    final log = parsed.logs.single;
    expect(log.date, DateTime(2026, 6, 1));
    expect(log.flow, FlowIntensity.medium);
    expect(log.symptoms, const [Symptom.cramps, Symptom.headache]);
    expect(log.moods, const [Mood.tired]);
    expect(log.notes, 'rough day');
    expect(log.intimacy, isTrue);
    expect(parsed.avgCycleLength, 28);
    expect(parsed.lutealPhaseLength, 14);
  });

  test('rejects input that is not a Luna backup', () {
    expect(() => parseBackupJson('not json'), throwsFormatException);
    expect(() => parseBackupJson('{"hello":1}'), throwsFormatException);
  });

  test('tolerates unknown enum values and missing fields', () {
    final parsed = parseBackupJson(
      '{"logs":[{"date":"2026-06-01","flow":"banana",'
      '"symptoms":["unknown","cramps"]}]}',
    );
    expect(parsed.logs, hasLength(1));
    expect(parsed.logs.single.flow, FlowIntensity.none); // unknown -> fallback
    expect(parsed.logs.single.symptoms, const [Symptom.cramps]); // junk dropped
    expect(parsed.avgCycleLength, isNull); // no settings block
  });
}
