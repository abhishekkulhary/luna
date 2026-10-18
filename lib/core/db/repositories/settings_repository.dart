import '../app_database.dart';

/// Read/write access to the single-row [AppSettings].
class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  static const _id = 0;

  Stream<AppSetting> watch() {
    return (_db.select(_db.appSettings)..where((t) => t.id.equals(_id)))
        .watchSingle();
  }

  Future<AppSetting> get() {
    return (_db.select(_db.appSettings)..where((t) => t.id.equals(_id)))
        .getSingle();
  }

  /// Applies a partial update to the settings row.
  Future<void> update(AppSettingsCompanion patch) {
    return (_db.update(_db.appSettings)..where((t) => t.id.equals(_id)))
        .write(patch);
  }
}
