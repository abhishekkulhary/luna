import 'package:drift/drift.dart';

import '../models/enums.dart';
import 'converters.dart';

/// Per-day log of flow, symptoms, mood and notes. The calendar day is the
/// primary key, giving exactly one row per day and clean upsert-by-date.
class DailyLogs extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get flow =>
      textEnum<FlowIntensity>().withDefault(Constant(FlowIntensity.none.name))();
  TextColumn get symptoms =>
      text().map(const SymptomListConverter()).withDefault(const Constant(''))();
  TextColumn get moods =>
      text().map(const MoodListConverter()).withDefault(const Constant(''))();
  TextColumn get notes => text().nullable()();
  RealColumn get temperature => real().nullable()();
  BoolColumn get intimacy => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {date};
}

/// User-created custom reminders (e.g. contraception, hydration, log nudges).
/// Cycle notifications are derived from predictions and not stored here.
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get body => text().nullable()();
  IntColumn get hour => integer()();
  IntColumn get minute => integer()();
  TextColumn get repeat => textEnum<ReminderRepeat>()();
  IntColumn get weekday => integer().nullable()(); // 1=Mon..7=Sun for weekly
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Single-row settings table (always id = 0).
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  IntColumn get avgCycleLength => integer().withDefault(const Constant(28))();
  IntColumn get avgPeriodLength => integer().withDefault(const Constant(5))();
  IntColumn get lutealPhaseLength => integer().withDefault(const Constant(14))();
  BoolColumn get adaptFromHistory =>
      boolean().withDefault(const Constant(true))();
  TextColumn get themeMode => textEnum<ThemeModeSetting>()
      .withDefault(Constant(ThemeModeSetting.system.name))();
  // BCP-47 language code (e.g. 'en', 'de'); null follows the system locale.
  TextColumn get languageCode => text().nullable()();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lockType =>
      textEnum<AppLockType>().withDefault(Constant(AppLockType.none.name))();
  BoolColumn get notifyPeriodSoon =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyPeriodStart =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyFertileWindow =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyOvulation =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyPeriodLate =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get notifyPms => boolean().withDefault(const Constant(false))();
  IntColumn get reminderHour => integer().withDefault(const Constant(9))();
  IntColumn get reminderMinute => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
