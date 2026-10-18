import 'package:drift/drift.dart';

import '../../utils/date_helpers.dart';
import '../app_database.dart';

/// Read/write access to per-day [DailyLogs].
class LogRepository {
  LogRepository(this._db);

  final AppDatabase _db;

  /// Watches all logs whose date is within [from]..[to] (inclusive).
  Stream<List<DailyLog>> watchRange(DateTime from, DateTime to) {
    return (_db.select(_db.dailyLogs)
          ..where((t) => t.date.isBetweenValues(dateOnly(from), dateOnly(to)))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch();
  }

  Stream<List<DailyLog>> watchAll() {
    return (_db.select(_db.dailyLogs)
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .watch();
  }

  Future<List<DailyLog>> getAll() {
    return (_db.select(_db.dailyLogs)
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  Future<DailyLog?> getByDate(DateTime date) {
    return (_db.select(_db.dailyLogs)..where((t) => t.date.equals(dateOnly(date))))
        .getSingleOrNull();
  }

  Stream<DailyLog?> watchByDate(DateTime date) {
    return (_db.select(_db.dailyLogs)..where((t) => t.date.equals(dateOnly(date))))
        .watchSingleOrNull();
  }

  /// Inserts or updates the log for its date (date is unique).
  Future<void> upsert({
    required DateTime date,
    required FlowIntensity flow,
    required List<Symptom> symptoms,
    required List<Mood> moods,
    String? notes,
    double? temperature,
    bool intimacy = false,
  }) {
    return _db.into(_db.dailyLogs).insertOnConflictUpdate(
          DailyLogsCompanion.insert(
            date: dateOnly(date),
            flow: Value(flow),
            symptoms: Value(symptoms),
            moods: Value(moods),
            notes: Value(notes),
            temperature: Value(temperature),
            intimacy: Value(intimacy),
            updatedAt: DateTime.now(),
          ),
        );
  }

  Future<void> deleteByDate(DateTime date) =>
      (_db.delete(_db.dailyLogs)..where((t) => t.date.equals(dateOnly(date))))
          .go();

  Future<void> deleteAll() => _db.delete(_db.dailyLogs).go();
}
