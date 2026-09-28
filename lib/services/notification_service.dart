import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
class NotificationService {
  static final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    const WindowsInitializationSettings windowsSettings =
        WindowsInitializationSettings(
      appName: 'Car Care',
      appUserModelId: 'com.carcare.app',
      guid: 'd49b0314-ee7a-4626-bf79-97cdb8a991bb',
    );

    const InitializationSettings settings = InitializationSettings(
      windows: windowsSettings,
    );

    await notifications.initialize(
      settings: settings,
    );
  }
 static Future<void> showTestNotification() async {
  const NotificationDetails details = NotificationDetails(
    windows: WindowsNotificationDetails(),
  );

  await notifications.show(
    id: 1,
    title: 'Car Care',
    body: 'Test Notification',
    notificationDetails: details,
  );
}
static Future<void> scheduleNotification({
  required int id,
  required String title,
  required String body,
  required tz.TZDateTime scheduledDate,
}) async {
  const NotificationDetails details = NotificationDetails(
    windows: WindowsNotificationDetails(),
  );

  await notifications.zonedSchedule(
  id: id,
  title: title,
  body: body,
  scheduledDate: scheduledDate,
  notificationDetails: details,
  androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
);
}
static Future<void> scheduleDocumentReminders({
  required int baseId,
  required String documentName,
  required tz.TZDateTime expiryDate,
}) async {
  final reminders = [
    {
      'days': 30,
      'id': baseId + 1,
    },
    {
      'days': 14,
      'id': baseId + 2,
    },
    {
      'days': 7,
      'id': baseId + 3,
    },
  ];

  for (final reminder in reminders) {
    final days = reminder['days'] as int;
    final id = reminder['id'] as int;

    final notificationDate = expiryDate.subtract(
  Duration(days: days),
);

    if (notificationDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await scheduleNotification(
        id: id,
        title: 'Car Care Reminder',
        body: '$documentName expires in $days days',
        scheduledDate: notificationDate,
      );
    }
  }
}
}