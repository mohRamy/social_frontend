import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> register(AuthModel auth);
  Future<AuthModel> login(String email, String password);
  Future<bool> isTokenValid();
  Future<AuthModel> getUserInfo();
  Future<AuthModel> getUserInfoById(String userId);
  Future<Unit> isUserOnline(bool isOnline);
  Future<Unit> addUserFcmToken(String fcmToken);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final BaseRepository baseRepository;
  AuthRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> register(AuthModel auth) async {
    var body = {
      "name": auth.name.toLowerCase(),
      "email": auth.email,
      "password": auth.password,
      "photo": auth.photo,
      "fcmtoken": auth.fcmToken,
    };

    final response = await baseRepository.postRoute(
      ApiGateway.register,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };

    diox.Response response =
        await baseRepository.postRoute(ApiGateway.login, body);

    late AuthModel userData;
    
    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        userData = AuthModel.fromMap(response.data as Map<String, dynamic>);
      },
    );

    return userData;
  }

  @override
  Future<bool> isTokenValid() async {
    final response = await baseRepository.postRoute(
      ApiGateway.isTokenValid,
      {},
    );

    bool isTokenValid = false;

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        isTokenValid = response.data;
      },
    );

    return isTokenValid;
  }

  @override
  Future<AuthModel> getUserInfo() async {
    final response = await baseRepository.getRoute(
      ApiGateway.getUserInfo,
    );

    late AuthModel userData;

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        userData = AuthModel.fromMap(response.data as Map<String, dynamic>);
      },
    );

    return userData;
  }

  @override
  Future<AuthModel> getUserInfoById(String userId) async {
    final response = await baseRepository.getRoute(
      "${ApiGateway.getUserInfoById}?userId=$userId",
    );

    late AuthModel userData;

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        userData = AuthModel.fromMap(response.data as Map<String, dynamic>);
      },
    );

    return userData;
  }

  @override
  Future<Unit> isUserOnline(bool isOnline) {
    SocketEmit().isUserOnline(isOnline);
    return Future.value(unit);
  }

  @override
  Future<Unit> addUserFcmToken(String fcmToken) async {
    var body = {
      "fcmToken": fcmToken,
    };

    final response = await baseRepository.postRoute(
      ApiGateway.saveUserTokenFcm,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
