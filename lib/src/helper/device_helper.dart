import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

import '../models/device_model.dart';
import '../services/firebase_messaging/handle_messaging.dart';

Future<DeviceModel> getDeviceDetails() async {
  late String deviceName;
  // late String deviceVersion;
  late String identifier;
  late String appVersion;
  final String? fcmToken = await getFirebaseMessagingToken();
  print(fcmToken);
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      deviceName = build.model;
      // deviceVersion = build.version.toString();
      identifier = build.id; //UUID for Android
      appVersion = "1.0.0";
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      deviceName = data.name!;
      // deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor!; //UUID for iOS
      appVersion = "1.0.0";
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
  return DeviceModel(
    appVersion: appVersion,
    deviceModel: deviceName,
    deviceUUid: identifier,
    fcmToken: fcmToken!,
  );
}
