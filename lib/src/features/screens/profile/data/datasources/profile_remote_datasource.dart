import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../../resources/base_repository.dart';
import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';

import '../../../../../services/socket/socket_emit.dart';
import '../../../../taps/home/data/models/post_model.dart';


abstract class ProfileRemoteDataSource {
  Future<List<PostModel>> getUserPosts();
  Future<Unit> updateAvatar(String photo, bool isPhoto);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final BaseRepository baseRepository;
  ProfileRemoteDataSourceImpl(this.baseRepository);

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
  Future<Unit> updateAvatar(String photo, bool isPhoto) async {
    SocketEmit().updateAvatar(photo, isPhoto);
    return Future.value(unit);
  }
}
