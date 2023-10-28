import 'package:flutter/material.dart';

class AppLanguage {
  ///Default Language
  static Locale defaultLanguage = const Locale("en");

  ///List Language support in Application
  static List<Locale> supportLanguage = [
    const Locale("en"),
    const Locale("ar"),
    const Locale("da"),
    const Locale("de"),
    const Locale("el"),
    const Locale("fr"),
    const Locale("id"),
    const Locale("ja"),
    const Locale("ko"),
    const Locale("nl"),
    const Locale("zh"),
    const Locale("ru"),
  ];

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
