import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luna/core/db/app_database.dart';
import 'package:luna/core/db/repositories/log_repository.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('settings row is seeded with defaults on create', () async {
    final settings = await db.select(db.appSettings).getSingle();
    expect(settings.id, 0);
    expect(settings.avgCycleLength, 28);
    expect(settings.lutealPhaseLength, 14);
    expect(settings.onboardingComplete, isFalse);
  });

  test('daily log upsert stores and reloads symptoms/moods', () async {
    final repo = LogRepository(db);
    await repo.upsert(
      date: DateTime(2026, 6, 2),
      flow: FlowIntensity.medium,
      symptoms: const [Symptom.cramps, Symptom.headache],
      moods: const [Mood.tired],
      notes: 'rough day',
    );

    // Upsert again for the same day overwrites (date is the primary key).
    await repo.upsert(
      date: DateTime(2026, 6, 2),
      flow: FlowIntensity.light,
      symptoms: const [Symptom.bloating],
      moods: const [Mood.calm],
    );

    final log = await repo.getByDate(DateTime(2026, 6, 2));
    expect(log!.flow, FlowIntensity.light);
    expect(log.symptoms, const [Symptom.bloating]);
    expect(log.moods, const [Mood.calm]);

    final all = await repo.watchAll().first;
    expect(all, hasLength(1));
  });
}
