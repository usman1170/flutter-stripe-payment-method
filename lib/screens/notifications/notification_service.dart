// ignore_for_file: unrelated_type_equality_checks
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:payments/main.dart';
import 'package:payments/screens/notifications/second_screen.dart';

// Add this key in main file in MyApp stl
// static GlobalKey<NavigatorState> navigatgorKey = GlobalKey<NavigatorState>();

class NotificationService {
  AwesomeNotifications awesomeNotifications = AwesomeNotifications();
  Future<void> initNotification() async {
    await awesomeNotifications.initialize(
      null,
      [
        NotificationChannel(
          channelKey: "High_key",
          channelName: "Notification",
          channelDescription: "Hello world",
          defaultColor: Colors.blue,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: "High_group_key",
          channelGroupName: "group 1",
        ),
      ],
      debug: true,
    );
    await awesomeNotifications.isNotificationAllowed().then((value) async {
      if (!value) {
        await awesomeNotifications.requestPermissionToSendNotifications();
      }
    });
    await awesomeNotifications.setListeners(
      onActionReceivedMethod: onActionMethod,
      onNotificationCreatedMethod: onNotificationCreate,
      onDismissActionReceivedMethod: onDismissActionReceived,
      onNotificationDisplayedMethod: onNotificationDisplayed,
    );
  }

  static Future<void> onNotificationCreate(
      ReceivedNotification receiveNotification) async {
    log("Notification Create method");
  }

  static Future<void> onNotificationDisplayed(
      ReceivedNotification receiveNotification) async {
    log("Notification display method");
  }

  static Future<void> onDismissActionReceived(
      ReceivedAction receivedAction) async {
    log("Dissmiss Action method");
  }

  static Future<void> onActionMethod(ReceivedAction receivedAction) async {
    log("Action method");
    final payloads = receivedAction.payload ?? {};
    if (payloads["navigate"] == true) {
      MyApp.navigatgorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => const SecondNotificationsScreen(),
        ),
      );
    }
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    final String? summry,
    final Map<String, String>? payloads,
    final NotificationLayout notificationlayout = NotificationLayout.Default,
    final ActionType actionType = ActionType.Default,
    final NotificationCategory? notificationCatagory,
    final String? image,
    final List<NotificationActionButton>? actionButtons,
    final bool schedule = false,
    final int? interval,
  }) async {
    assert(!schedule || (schedule && interval != null));
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: "High_key",
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationlayout,
        summary: summry,
        category: notificationCatagory,
        payload: payloads,
        bigPicture: image,
      ),
      actionButtons: actionButtons,
      schedule: schedule
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
