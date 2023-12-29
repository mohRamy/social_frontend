import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';

abstract class UpdatePostRemoteDataSource {
  Future<Unit> updatePost(String postId, String description);
}

class UpdatePostRemoteDataSourceImpl extends UpdatePostRemoteDataSource {
  final BaseRepository baseRepository;
  UpdatePostRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> updatePost(
    String postId,
    String description,
  ) async {
    var body = {
      "postId": postId,
      "description": description,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.updatePost,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
