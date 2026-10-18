import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'app.dart';
import 'core/notifications/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initTimezone();
  await NotificationService.instance.init();
  runApp(const ProviderScope(child: PeriodTrackerApp()));
}

/// Loads the timezone database and sets the device's local zone so scheduled
/// notifications fire at the right wall-clock time. No-op / best-effort on web.
void _initTimezone() {
  if (kIsWeb) return;
  try {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(_deviceLocation());
  } catch (_) {
    // Fall back to UTC if the zone can't be resolved.
  }
}

/// Picks a timezone whose current UTC offset matches the device, in pure Dart —
/// this avoids a native timezone plugin (and its legacy Kotlin Gradle Plugin).
///
/// One-shot cycle notifications are scheduled at an absolute instant, so they
/// are always exact regardless of this; the local zone only affects DST handling
/// of repeating reminders, which is correct for any zone sharing the device's
/// offset and DST rules.
tz.Location _deviceLocation() {
  final offset = DateTime.now().timeZoneOffset;
  for (final location in tz.timeZoneDatabase.locations.values) {
    if (tz.TZDateTime.now(location).timeZoneOffset == offset) return location;
  }
  return tz.UTC;
}
