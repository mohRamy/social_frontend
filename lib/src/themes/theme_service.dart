import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum ThemeOptions { light, dark }

class ThemeService {
  static ThemeOptions themeOptions = ThemeOptions.light;
  static ThemeMode currentTheme = ThemeMode.light;
  static final systemBrightness = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  
  final _getStorage = GetStorage();
  final storageKey = 'theme';

  void _writeBox(bool istheme) => _getStorage.write(storageKey, istheme);

  bool _readBox() => _getStorage.read<bool>(storageKey) ?? false;

  ThemeMode get theme => _readBox() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(_readBox() ? ThemeMode.light : ThemeMode.dark);
    _writeBox(!_readBox());
  }
}

ThemeService themeService = ThemeService();