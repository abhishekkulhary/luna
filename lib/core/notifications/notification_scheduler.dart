import 'dart:ui';

import '../../l10n/app_localizations.dart';
import '../cycle/cycle_forecast.dart';
import '../db/app_database.dart';
import 'notification_service.dart';

/// Translates the cycle forecast, settings and custom reminders into concrete
/// scheduled notifications, cancelling and re-adding on every sync so the
/// schedule always reflects the latest predictions.
class NotificationScheduler {
  NotificationScheduler(this._service);

  final NotificationService _service;

  // Stable id bases per cycle-notification type (+ cycle offset 0.._ahead-1).
  static const _periodSoon = 100;
  static const _periodStart = 200;
  static const _fertileStart = 300;
  static const _ovulation = 400;
  static const _pms = 500;
  static const _periodLate = 600;
  static const _ahead = 3;

  static int reminderNotifId(String uuid) => 1000000 + (uuid.hashCode & 0xFFFFF);

  Future<void> syncCycle(CycleForecast forecast, AppSetting s) async {
    for (final base in [
      _periodSoon,
      _periodStart,
      _fertileStart,
      _ovulation,
      _pms,
      _periodLate,
    ]) {
      for (var i = 0; i < _ahead; i++) {
        await _service.cancel(base + i);
      }
    }
    if (!forecast.hasData) return;

    // Localize notification text to the user's chosen language (or the system
    // locale when unset), independent of any widget BuildContext.
    final l = lookupAppLocalizations(_localeFor(s.languageCode));

    DateTime at(DateTime day) =>
        DateTime(day.year, day.month, day.day, s.reminderHour, s.reminderMinute);

    final cycles = forecast.cycles.take(_ahead).toList();
    for (var i = 0; i < cycles.length; i++) {
      final c = cycles[i];

      if (s.notifyPeriodSoon) {
        await _schedule(_periodSoon + i, at(_minus(c.periodStart, 1)),
            l.notifPeriodSoonTitle, l.notifPeriodSoonBody);
      }
      if (s.notifyPeriodStart) {
        await _schedule(_periodStart + i, at(c.periodStart),
            l.notifPeriodStartTitle, l.notifPeriodStartBody);
      }
      if (s.notifyPms) {
        await _schedule(_pms + i, at(_minus(c.periodStart, 3)),
            l.notifPmsTitle, l.notifPmsBody);
      }
      if (s.notifyPeriodLate) {
        await _schedule(_periodLate + i, at(_plus(c.periodStart, 2)),
            l.notifPeriodLateTitle, l.notifPeriodLateBody);
      }
      if (s.notifyFertileWindow) {
        await _schedule(_fertileStart + i, at(c.fertileWindow.start),
            l.notifFertileTitle, l.notifFertileBody);
      }
      if (s.notifyOvulation) {
        await _schedule(_ovulation + i, at(c.ovulationDay),
            l.notifOvulationTitle, l.notifOvulationBody);
      }
    }
  }

  /// Resolves the locale for notification text, clamped to supported languages.
  Locale _localeFor(String? code) {
    final lang = code ?? PlatformDispatcher.instance.locale.languageCode;
    return Locale(lang == 'de' ? 'de' : 'en');
  }

  Future<void> _schedule(int id, DateTime when, String title, String body) {
    return _service.schedule(id: id, title: title, body: body, when: when);
  }

  /// Cancels then (re)schedules notifications for the given custom reminders.
  /// Reminders removed elsewhere must be cancelled via [cancelReminder].
  Future<void> syncReminders(List<Reminder> reminders) async {
    for (final r in reminders) {
      final id = reminderNotifId(r.id);
      await _service.cancel(id);
      if (!r.enabled) continue;

      final when = _nextOccurrence(r);
      final kind = switch (r.repeat) {
        ReminderRepeat.once => NotifRepeatKind.once,
        ReminderRepeat.daily => NotifRepeatKind.daily,
        ReminderRepeat.weekly => NotifRepeatKind.weekly,
      };
      await _service.schedule(
        id: id,
        title: r.title,
        body: r.body ?? '',
        when: when,
        isCycle: false,
        repeat: kind,
      );
    }
  }

  Future<void> cancelReminder(String uuid) =>
      _service.cancel(reminderNotifId(uuid));

  DateTime _nextOccurrence(Reminder r) {
    final now = DateTime.now();
    var date = DateTime(now.year, now.month, now.day, r.hour, r.minute);
    if (r.repeat == ReminderRepeat.weekly && r.weekday != null) {
      while (date.weekday != r.weekday || !date.isAfter(now)) {
        date = date.add(const Duration(days: 1));
      }
    } else if (!date.isAfter(now)) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }

  DateTime _minus(DateTime d, int days) =>
      DateTime(d.year, d.month, d.day - days);
  DateTime _plus(DateTime d, int days) =>
      DateTime(d.year, d.month, d.day + days);
}
