import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timeZone;
import 'package:timezone/data/latest_all.dart' as timeZone;

class ScheduleNotification {
  static final _notification = FlutterLocalNotificationsPlugin();
  static init() {
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      ),
    );
    timeZone.initializeTimeZones();
  }

  static sheduleNotification(String title, String body, int interval) async {
    await _notification.zonedSchedule(
      0,
      title,
      body,
      timeZone.TZDateTime.now(timeZone.local).add(
        Duration(seconds: interval),
      ),
      const NotificationDetails(
          android: AndroidNotificationDetails(
            "Imp_notification",
            "Mobile",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
          ),
          iOS: DarwinNotificationDetails()),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
