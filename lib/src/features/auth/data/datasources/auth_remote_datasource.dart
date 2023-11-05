import 'package:dartz/dartz.dart';
import '../../../../public/api_gateway.dart';

import 'package:dio/dio.dart' as diox;

import '../../../../public/constants.dart';
import '../../../../resources/base_repository.dart';
import '../../domain/entities/auth.dart';
import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> register(Auth auth);
  Future<AuthModel> login(String email, String password);
  Future<bool> isTokenValid();
  Future<AuthModel> getUserInfo();
  Future<AuthModel> getUserInfoById(String userId);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final BaseRepository baseRepository;
  AuthRemoteDataSourceImpl(this.baseRepository);

    @override
  Future<Unit> register(Auth auth) async {
    var body = {
      "name": auth.name.toLowerCase(),
      "email": auth.email,
      "password": auth.password,
      "photo": auth.photo,
      "fcmtoken": auth.fcmtoken,
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
}
