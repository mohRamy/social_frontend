import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/sizer_custom/sizer.dart';

import '../../core/dialogs/dialog_confirm.dart';
import '../../core/dialogs/dialog_loading.dart';
import '../../routes/app_pages.dart';

Future<String?> getFirebaseMessagingToken() async {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  String? token = await firebaseMessaging.getToken();
  return token;
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    debugPrint('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    debugPrint('User granted provisional permission');
  } else {
    debugPrint('User declined or has not accepted permission');
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
}

handleReceiveNotification() async {
  await requestPermission();
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      handleTouchOnNotification(message);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    dialogAnimationWrapper(
      dismissible: false,
      context: Get.context,
      child: DialogConfirm(
        height: 165.sp,
        title: message.notification!.title!,
        subTitle: message.notification!.body!,
        handleConfirm: () {
          handleTouchOnNotification(message);
        },
      ),
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('A new onMessageOpenedApp event was published!' ' ${message.data.toString()}');

    handleTouchOnNotification(message);
  }).onError((error) => print('Error: $error [\'lambiengcode\']'));
}

handleTouchOnNotification(RemoteMessage? message) {
  if (message != null) {
    AppNavigator.push(AppRoutes.notification);
    // AppBloc.doExamBloc.add(JoinQuizEvent(roomId: message.data['idRoom'].toString()));
  }
}
