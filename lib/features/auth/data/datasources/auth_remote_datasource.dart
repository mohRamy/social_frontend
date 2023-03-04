import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:social_app/core/utils/app_component.dart';

import '../../../../core/network/api_client.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/constants/state_handle.dart';

import '../../../../core/network/api_constance.dart';
import '../../domain/entities/auth.dart';
import '../models/auth_model.dart';

abstract class BaseAuthRemoteDataSource extends GetConnect {
  Future<Unit> signUp(Auth auth);
  Future<Auth> signIn(String email, String password);
  Future<bool> isTokenValid();
  Future<Auth> getMyData();
  Future<Auth> getUserData(String userId);
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  final ApiClient apiClient;
  AuthRemoteDataSource(this.apiClient);
  @override
  Future<Auth> signIn(String email, String password) async {
    http.Response res = await apiClient.postData(
      ApiConstance.signIn,
      jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    late Auth userData;
    stateErrorHandle(
      res: res,
      onSuccess: () {
        userData = AuthModel.fromJson(res.body);
      },
    );
    return userData;
  }

  @override
  Future<Unit> signUp(Auth auth) async {
    print('sssssssssssss');
    print(auth.fcmtoken);
    final res = await apiClient.postData(
        ApiConstance.signUp,
        jsonEncode({
          "name": auth.name,
          "email": auth.email,
          "password": auth.password,
          "photo": auth.photo,
          "fcmtoken": auth.fcmtoken,
        }));
        
        
      stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<bool> isTokenValid() async {
    final res = await apiClient.postData(
      ApiConstance.isTokenValid,
      jsonEncode({}),
    );
    bool isTokenValid = false;

    stateErrorHandle(
      res: res,
      onSuccess: () {
        isTokenValid = json.decode(res.body);
      },
    );

    return isTokenValid;
  }

  @override
  Future<Auth> getMyData() async {
    final res = await apiClient.getData(ApiConstance.getMyData);

    late Auth userData;
    stateErrorHandle(
      res: res,
      onSuccess: () {
        userData = AuthModel.fromJson(res.body);
      },
    );
    return userData;
  }

  @override
  Future<Auth> getUserData(String userId) async {
    final res = await apiClient.getData(
      "${ApiConstance.getUserData}?userId=$userId",
    );

    late Auth userData;
    stateErrorHandle(
      res: res,
      onSuccess: () {
        userData = AuthModel.fromJson(res.body);
      },
    );
    return userData;
  }
}
