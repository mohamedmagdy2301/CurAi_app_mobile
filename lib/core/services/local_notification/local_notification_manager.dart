import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:toastification/toastification.dart';

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/$fileName';
  final response = await http.get(Uri.parse(url));
  final file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

class LocalNotificationService {
  factory LocalNotificationService() => _instance;
  LocalNotificationService._();

  static final LocalNotificationService _instance =
      LocalNotificationService._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String notificationPrefsKey = 'appointment_notifications';

  /// Initialize Local Notification
  Future<void> initialize() async {
    tz.initializeTimeZones();
    final localTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimeZone));

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/icon_notification2'),
      iOS: DarwinInitializationSettings(),
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'appointment_scheduled_channel',
            'Appointment Scheduled Notifications',
            description: 'Reminders for scheduled appointments',
            importance: Importance.max,
          ),
        );

    // Request notification permissions (iOS)
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>() !=
        null) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    // No need to request notification permissions on Android here.
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  /// Show Scheduled Notification
  Future<void> showScheduledNotification(
    BuildContext context, {
    required int id,
    required String title,
    required String body,
    required String imageUrl,
    required int day,
    required int hour,
    required int minute,
    int second = 0,
  }) async {
    try {
      final bigPicturePath =
          await _downloadAndSaveFile(imageUrl, 'big_picture_$id.jpg');

      final notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'appointment_scheduled_channel',
          'Appointment Scheduled Notifications',
          importance: Importance.max,
          priority: Priority.high,
          enableLights: true,
          icon: '@drawable/icon_notification2',
          sound: const RawResourceAndroidNotificationSound('sound_test'),
          styleInformation: BigPictureStyleInformation(
            FilePathAndroidBitmap(bigPicturePath),
            largeIcon: const DrawableResourceAndroidBitmap(
              '@drawable/icon_notification2',
            ),
          ),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      final currentTime = tz.TZDateTime.now(tz.local);
      var scheduledDateTime = DateTime(
        currentTime.year,
        currentTime.month,
        day,
        hour,
        minute,
        second,
      );

      if (day < currentTime.day &&
          (hour < currentTime.hour ||
              (hour == currentTime.hour && minute < currentTime.minute))) {
        scheduledDateTime = DateTime(
          currentTime.year,
          currentTime.month + 1,
          day,
          hour,
          minute,
        );
      }

      final scheduledTime = tz.TZDateTime.from(scheduledDateTime, tz.local);

      if (scheduledTime.isBefore(currentTime.add(const Duration(seconds: 5)))) {
        return;
      }

      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: '$id',
      );
      await _saveNotificationStatus(id: id, isActive: true);
    } on Exception catch (e) {
      if (context.mounted) {
        showMessage(
          context,
          message: e.toString(),
          type: ToastificationType.error,
        );
      }
    }
  }

  /// Save notification status to SharedPreferences
  Future<void> _saveNotificationStatus({
    required int id,
    required bool isActive,
  }) async {
    try {
      await di.sl<CacheDataManager>().setData(
            key: '$notificationPrefsKey-$id',
            value: isActive,
          );
    } on Exception catch (e) {
      if (kDebugMode) log('Error saving notification preference: $e');
    }
  }

  /// Get notification status from SharedPreferences
  Future<bool> getNotificationStatus({required int id}) async {
    try {
      return (di
              .sl<CacheDataManager>()
              .getData(key: '$notificationPrefsKey-$id') ??
          false) as bool;
    } on Exception catch (e) {
      if (kDebugMode) log('Error getting notification preference: $e');
      return false;
    }
  }

  /// Cancel All Notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    // Clear preferences
    try {
      final keys = di.sl<CacheDataManager>().getKeys();
      for (final key in keys) {
        if (key.startsWith(notificationPrefsKey)) {
          await di.sl<CacheDataManager>().removeData(key: key);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) log('Error clearing notification preferences: $e');
    }
  }

  /// Cancel Notification By Id
  Future<void> cancelNotificationById(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);

    // Also cancel the day-before reminder
    await flutterLocalNotificationsPlugin.cancel(id + 10000);

    // Update preferences
    await _saveNotificationStatus(id: id, isActive: false);

    if (kDebugMode) log('Cancelled notification with id: $id');
  }

  /// Check if notifications are pending
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }
}
