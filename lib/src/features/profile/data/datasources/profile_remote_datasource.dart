import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../services/socket/socket_emit.dart';

import '../../../../public/api_gateway.dart';
import '../../../../public/constants.dart';
import '../../../../resources/base_repository.dart';
import '../../../home/data/models/post_model.dart';

import '../../../auth/domain/entities/auth.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> followUser(String userId);
  Future<List<PostModel>> getUserPosts();
  Future<List<PostModel>> getUserPostsById(String userId);
  Future<Unit> updateInfo(Auth myData);
  Future<Unit> privateAccount();
  Future<Unit> changePassword(String currentPassword, String newPassword);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final BaseRepository baseRepository;
  ProfileRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    var body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.changePassword,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> followUser(String userId) async {
    SocketEmit().changeFollowingUser(userId);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getUserPosts() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getUserPosts,
    );

    List<PostModel> posts = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        posts = rawData.map((e) => PostModel.fromMap(e)).toList();
      },
    );

    return posts;
  }

  @override
  Future<List<PostModel>> getUserPostsById(String userId) async {
    diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.getUserPostsById}?userId=$userId",
    );

    List<PostModel> posts = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        posts = rawData.map((e) => PostModel.fromMap(e)).toList();
      },
    );

    return posts;
  }

  @override
  Future<Unit> updateInfo(Auth myData) async {
    var body = {
      "myData": myData,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.followUser,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> privateAccount() async {
    diox.Response response = await baseRepository.patchRoute(
      ApiGateway.private,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
