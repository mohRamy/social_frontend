import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';

abstract class AddPostRemoteDataSource {
  Future<Unit> addPost(
      String description, List<String> postsUrl, List<String> postsType);
}

class AddPostRemoteDataSourceImpl extends AddPostRemoteDataSource {
  final BaseRepository baseRepository;
  AddPostRemoteDataSourceImpl(this.baseRepository);

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
