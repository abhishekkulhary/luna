import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';
import 'repositories/log_repository.dart';
import 'repositories/reminder_repository.dart';
import 'repositories/settings_repository.dart';

/// The singleton database, closed when the provider scope is disposed.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final logRepositoryProvider = Provider<LogRepository>(
  (ref) => LogRepository(ref.watch(appDatabaseProvider)),
);

final reminderRepositoryProvider = Provider<ReminderRepository>(
  (ref) => ReminderRepository(ref.watch(appDatabaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(appDatabaseProvider)),
);

/// Reactive streams consumed by the feature screens.
final settingsProvider = StreamProvider<AppSetting>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);

final remindersProvider = StreamProvider<List<Reminder>>(
  (ref) => ref.watch(reminderRepositoryProvider).watchAll(),
);

final allLogsProvider = StreamProvider<List<DailyLog>>(
  (ref) => ref.watch(logRepositoryProvider).watchAll(),
);

/// Watches the single day's log for [date].
final logForDateProvider =
    StreamProvider.family<DailyLog?, DateTime>((ref, date) {
  return ref.watch(logRepositoryProvider).watchByDate(date);
});
