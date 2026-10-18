import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';

/// Read/write access to user-created custom [Reminders].
class ReminderRepository {
  ReminderRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<Reminder>> watchAll() {
    return (_db.select(_db.reminders)
          ..orderBy([
            (t) => OrderingTerm.asc(t.hour),
            (t) => OrderingTerm.asc(t.minute),
          ]))
        .watch();
  }

  Future<List<Reminder>> getEnabled() {
    return (_db.select(_db.reminders)..where((t) => t.enabled.equals(true)))
        .get();
  }

  Future<String> create({
    required String title,
    String? body,
    required int hour,
    required int minute,
    required ReminderRepeat repeat,
    int? weekday,
  }) async {
    final id = _uuid.v4();
    await _db.into(_db.reminders).insert(
          RemindersCompanion.insert(
            id: id,
            title: title,
            body: Value(body),
            hour: hour,
            minute: minute,
            repeat: repeat,
            weekday: Value(weekday),
            createdAt: DateTime.now(),
          ),
        );
    return id;
  }

  Future<void> update(Reminder reminder) =>
      _db.update(_db.reminders).replace(reminder);

  Future<void> updateDetails({
    required String id,
    required String title,
    String? body,
    required int hour,
    required int minute,
    required ReminderRepeat repeat,
    int? weekday,
  }) {
    return (_db.update(_db.reminders)..where((t) => t.id.equals(id))).write(
      RemindersCompanion(
        title: Value(title),
        body: Value(body),
        hour: Value(hour),
        minute: Value(minute),
        repeat: Value(repeat),
        weekday: Value(weekday),
      ),
    );
  }

  Future<void> setEnabled(String id, bool enabled) {
    return (_db.update(_db.reminders)..where((t) => t.id.equals(id)))
        .write(RemindersCompanion(enabled: Value(enabled)));
  }

  Future<void> delete(String id) =>
      (_db.delete(_db.reminders)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAll() => _db.delete(_db.reminders).go();
}
