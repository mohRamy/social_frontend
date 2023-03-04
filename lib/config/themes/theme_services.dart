import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ModeTheme {
  final GetStorage _box = GetStorage();
  final _key = 'theme';

  void _writeBox(bool istheme) => _box.write(_key, istheme);

  bool _readBox() => _box.read<bool>(_key) ?? false;

  ThemeMode get theme => _readBox() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    Get.changeThemeMode(_readBox() ? ThemeMode.light : ThemeMode.dark);
    _writeBox(!_readBox());
  }
}
