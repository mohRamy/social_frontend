import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';

import '../models/auth_model.dart';

abstract class AuthLocalDataSource {
  Future<Unit> saveUserInfo(AuthModel userData);
  AuthModel getUserInfo();
  Future<bool> clearUserData();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl(this.sharedPreferences);

  final userDataKey = 'user-data-key';

  @override
  Future<Unit> saveUserInfo(AuthModel userData) async {
    try {
      await sharedPreferences.setString(
        userDataKey,
        json.encode(
          userData.toJson(),
        ),
      );
      return Future.value(unit);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
  AuthModel getUserInfo() {
    try {
      var rawData = sharedPreferences.getString(userDataKey);
      return AuthModel.fromJson(rawData ?? '');
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
  Future<bool> clearUserData() async {
    try {
      return await sharedPreferences.remove(userDataKey);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }
}
