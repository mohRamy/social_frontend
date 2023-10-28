import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import '../services/firebase_messaging/handle_messaging.dart';
import '../services/stripe_payment/stripe_keys.dart';

class Application {
  /// [Production - Dev]
  static String version = '1.0.0';
  static String baseUrl = '';
  static String imageUrl = '';
  static String socketUrl = '';
  static String mode = '';
  static bool isProductionMode = true;

  Future<void> initialAppLication() async {
  try {
    await GetStorage.init();
    baseUrl = 'http://192.168.223.79:8000/';
    imageUrl = '${baseUrl}api/up-load-file/';
    socketUrl = 'http://192.168.223.79:8000/';
    mode = 'PRODUCTION';
    requestPermission();
    handleReceiveNotification();

    Stripe.publishableKey = ApiKeys.publishableKey;
  } catch (error) {
    debugPrint(error.toString());
  }
}


  //Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}