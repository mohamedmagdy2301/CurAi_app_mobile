// import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';

// /// Manages the persistence of notification preferences for appointments
// class NotificationCacheManager {
//   static const String _notificationPrefsKey = 'appointment_notifications';

//   /// Save notification preference for an appointment
//   static Future<void> saveNotificationPreference({
//     required bool isEnabled,
//     required int appointmentId,
//   }) async {
//     await CacheDataHelper.setData(
//       key: '$_notificationPrefsKey-$appointmentId',
//       value: isEnabled,
//     );
//   }

//   /// Get notification preference for an appointment
//   static Future<bool> getNotificationPreference({
//     required int appointmentId,
//   }) async {
//     return (CacheDataHelper.getData(
//           key: '$_notificationPrefsKey-$appointmentId',
//         ) ??
//         false) as bool;
//   }

//   static Future<Map<int, bool>> loadAllNotificationPreferences() async {
//     try {
//       final preferencesMap = <int, bool>{};

//       final keys = CacheDataHelper.getKeys();
//       for (final key in keys) {
//         if (key.startsWith(_notificationPrefsKey)) {
//           final appointmentId = int.parse(key.split('-')[1]);
//           final isEnabled =
//               (CacheDataHelper.getData(key: key) ?? false) as bool;
//           preferencesMap[appointmentId] = isEnabled;
//         }
//       }

//       return preferencesMap;
//     } on Exception catch (_) {
//       return {};
//     }
//   }

//   /// Clear preference for a specific appointment
//   static Future<void> clearNotificationPreference(int appointmentId) async {
//     await CacheDataHelper.removeData(
//       key: '$_notificationPrefsKey-$appointmentId',
//     );
//   }

//   /// Clear all notification preferences
//   static Future<void> clearAllNotificationPreferences() async {
//     final keys = CacheDataHelper.getKeys();
//     for (final key in keys) {
//       if (key.startsWith(_notificationPrefsKey)) {
//         await CacheDataHelper.removeData(key: key);
//       }
//     }
//   }
// }
