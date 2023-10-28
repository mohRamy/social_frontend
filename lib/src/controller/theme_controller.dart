import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/theme_service.dart';

class ThemeController extends GetxController {
  void onChangeTheme(ThemeMode? themeMode) {
    ThemeService.currentTheme = themeMode ?? ThemeService.currentTheme;
    ThemeService().changeTheme();
    update();
  }
}
