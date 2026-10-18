import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notification_scheduler.dart';
import 'notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService.instance,
);

final notificationSchedulerProvider = Provider<NotificationScheduler>(
  (ref) => NotificationScheduler(ref.watch(notificationServiceProvider)),
);
