import 'package:drift/drift.dart';

import '../models/enums.dart';
import 'connection/connection.dart';
import 'converters.dart';
import 'tables.dart';

export '../models/enums.dart';
export 'tables.dart';

part 'app_database.g.dart';

/// The app's local Drift database. All personal health data is stored here and
/// never leaves the device.
@DriftDatabase(tables: [DailyLogs, Reminders, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openConnection());

  /// In-memory/testing constructor that bypasses the encrypted file connection.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed the single settings row.
          await into(appSettings).insert(
            const AppSettingsCompanion(id: Value(0)),
          );
        },
        onUpgrade: (m, from, to) async {
          // v2: add the language preference column.
          if (from < 2) {
            await m.addColumn(appSettings, appSettings.languageCode);
          }
        },
        beforeOpen: (details) async {
          // Defensive: guarantee the settings row exists on every open.
          final count = await (selectOnly(appSettings)
                ..addColumns([appSettings.id.count()]))
              .map((r) => r.read(appSettings.id.count()))
              .getSingle();
          if ((count ?? 0) == 0) {
            await into(appSettings)
                .insert(const AppSettingsCompanion(id: Value(0)));
          }
        },
      );
}
