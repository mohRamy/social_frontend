import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import 'package:social_app/src/public/api_gateway.dart';

import '../../../../public/constants.dart';
import '../../../../resources/base_repository.dart';

abstract class PostRemoteDataSource {
  Future<Unit> addPost(
      String description, List<String> postsUrl, List<String> postsType);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final BaseRepository baseRepository;
  PostRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> addPost(
    String description,
    List<String> postsUrl,
    List<String> postsType,
  ) async {
    var body = {
      "description": description,
      "postsUrl": postsUrl,
      "postsType": postsType,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addPost,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
