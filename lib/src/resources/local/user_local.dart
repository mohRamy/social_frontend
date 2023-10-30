import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import '../../features/auth/data/models/auth_model.dart';
import '../../features/auth/domain/entities/auth.dart';

class UserLocal {
  final _getStorage = GetStorage();
  final typeKey = 'type';
  final tokenKey = 'token';
  final userIdKey = 'user-id';
  final userKey = 'user-local';

  void saveUser(Auth user) async {
    _getStorage.write(userKey, json.encode(user));
  }

  Auth? getUser() {
      var rawData = _getStorage.read(userKey);    
      if (rawData != null) {
        return AuthModel.fromJson(json.decode(rawData));
      }
      return null;
  }

  void clearUserData() async {
    _getStorage.remove(userKey);
  }

  void saveAccessToken(String token) async {
    _getStorage.write(tokenKey, token);
  }

  String getAccessToken() {
    return _getStorage.read(tokenKey) ?? '';
  }

  void clearAccessToken() async {
    _getStorage.remove(tokenKey);
  }

  void saveUserId(String userId) async {
    _getStorage.write(userIdKey, userId);
  }

  String getUserId() {
    return _getStorage.read(userIdKey) ?? '';
  }

  void saveUserType(String type) async {
    _getStorage.write(typeKey, type);
  }
  
  String getUserType() {
    return _getStorage.read(typeKey) ?? '';
  }

  void clearUserType() async {
    _getStorage.remove(typeKey);
  }
}
