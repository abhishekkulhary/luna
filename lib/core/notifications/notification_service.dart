import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// How a scheduled notification repeats.
enum NotifRepeatKind { once, daily, weekly }

/// Thin wrapper around flutter_local_notifications.
///
/// All methods are no-ops on web (the plugin has no web backend); notifications
/// are a mobile/desktop feature. See README "Platform notes".
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const _cycleChannelId = 'cycle';
  static const _reminderChannelId = 'reminders';

  Future<void> init() async {
    if (kIsWeb || _ready) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const linux = LinuxInitializationSettings(defaultActionName: 'Open');

    try {
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: android,
          iOS: darwin,
          macOS: darwin,
          linux: linux,
        ),
      );
      _ready = true;
    } catch (_) {
      // No platform implementation (e.g. unsupported desktop, tests): degrade
      // to a no-op rather than crashing the app.
      _ready = false;
    }
  }

  /// Asks the OS for notification permission. Returns true if (likely) granted.
  Future<bool> requestPermissions() async {
    if (kIsWeb) return false;
    await init();
    if (!_ready) return false;

    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }

    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }

    final macos = _plugin.resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>();
    if (macos != null) {
      return await macos.requestPermissions(alert: true, badge: true, sound: true) ??
          false;
    }
    return true;
  }

  NotificationDetails _details({required bool isCycle}) {
    final channelId = isCycle ? _cycleChannelId : _reminderChannelId;
    final channelName = isCycle ? 'Cycle reminders' : 'Custom reminders';
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Period, fertility and custom reminders',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
      linux: const LinuxNotificationDetails(),
    );
  }

  /// Schedules a notification at [when] (local time). For repeating kinds the
  /// time-of-day (and weekday for weekly) is matched on each occurrence.
  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required DateTime when,
    bool isCycle = true,
    NotifRepeatKind repeat = NotifRepeatKind.once,
  }) async {
    if (kIsWeb) return;
    await init();
    if (!_ready) return;
    if (when.isBefore(DateTime.now()) && repeat == NotifRepeatKind.once) {
      return; // don't schedule one-off notifications in the past
    }

    final match = switch (repeat) {
      NotifRepeatKind.once => null,
      NotifRepeatKind.daily => DateTimeComponents.time,
      NotifRepeatKind.weekly => DateTimeComponents.dayOfWeekAndTime,
    };

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(when, tz.local),
      notificationDetails: _details(isCycle: isCycle),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: match,
    );
  }

  Future<void> cancel(int id) async {
    if (kIsWeb) return;
    await init();
    if (!_ready) return;
    await _plugin.cancel(id: id);
  }

  Future<void> cancelAll() async {
    if (kIsWeb) return;
    await init();
    if (!_ready) return;
    await _plugin.cancelAll();
  }

  Future<List<PendingNotificationRequest>> pending() async {
    if (kIsWeb) return const [];
    return _plugin.pendingNotificationRequests();
  }
}
