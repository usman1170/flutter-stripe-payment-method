import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:payments/screens/notifications/notification_button.dart';
import 'package:payments/screens/notifications/notification_service.dart';
import 'package:payments/screens/notifications/schedule_notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NotificationButton(
              title: "Simple Notification",
              ontap: () async {
                await NotificationService.showNotification(
                  title: "title of notification",
                  body: "body of notification",
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Progress Notification",
              ontap: () async {
                await NotificationService.showNotification(
                  title: "title of notification",
                  body: "body of notification",
                  notificationlayout: NotificationLayout.ProgressBar,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Messaging Notification",
              ontap: () async {
                await NotificationService.showNotification(
                  title: "title of notification",
                  body: "body of notification",
                  notificationlayout: NotificationLayout.Messaging,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Media Notification",
              ontap: () async {
                await NotificationService.showNotification(
                  title: "title of notification",
                  body: "body of notification",
                  notificationlayout: NotificationLayout.MediaPlayer,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Action Notification",
              ontap: () async {
                await NotificationService.showNotification(
                  title: "title of notification",
                  body: "body of notification",
                  payloads: {
                    "navigate": "true",
                  },
                  actionButtons: [
                    NotificationActionButton(
                      key: "check",
                      label: "Check this out",
                      actionType: ActionType.SilentAction,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Schedule Notification",
              ontap: () async {
                ScheduleNotification.sheduleNotification(
                  "Hello",
                  "fore Notification",
                  5,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            NotificationButton(
              title: "Background Schedule Notification",
              ontap: () async {
                ScheduleNotification.sheduleNotification(
                  "Hello",
                  "Background Notification",
                  30,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
