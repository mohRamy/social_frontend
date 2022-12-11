// import 'package:amazon_flutter/features/auth/auth_ctrl/auth_ctrl.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// class NotificationHelper {
//   static Future<void> initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//         const AndroidInitializationSettings('notification_icon');
//     // var iOSInitialize = const IOSInitializationSettings();
//     var initializationsSettings =
//         InitializationSettings(android: androidInitialize);
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings,
//         onSelectNotification: (String? payload) {
//       try {
//         if (payload != null && payload.isNotEmpty) {
//         } else {}
//       } catch (e) {
//         if (kDebugMode) {
//           print(e.toString());
//         }
//       }
//       return;
//     });
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("................onMessage...............");
//       print("onMessage: ${message.notification?.title}"
//           "/${message.notification?.body}"
//           "/${message.notification?.titleLocKey}");

//       NotificationHelper.showNotification(
//           message, flutterLocalNotificationsPlugin);

//       if (Get.find<AuthCtrl>().userLoggedIn()) {}
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("onMessage: ${message.notification?.title}"
//           "/${message.notification?.body}"
//           "/${message.notification?.titleLocKey}");
//       try {
//         if (message.notification?.titleLocKey != null) {
//         } else {}
//       } catch (e) {
//         print(e.toString);
//       }
//     });
//   }

//   static Future<void> showNotification(
//     RemoteMessage msg,
//     FlutterLocalNotificationsPlugin fln,
//   ) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       msg.notification!.body!, htmlFormatBigText: true,
//       contentTitle: msg.notification!.title!, htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel_id_1','dbfood', importance: Importance.high,
//       styleInformation: bigTextStyleInformation, priority: Priority.high,
//       playSound: true,
//     );
//     NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, msg.notification!.title, msg.notification!.body, platformChannelSpecifics);
//   }
// }
