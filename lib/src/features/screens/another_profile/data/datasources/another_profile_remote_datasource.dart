import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../taps/home/data/models/post_model.dart';

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';

abstract class AnotherProfileRemoteDataSource {
  Future<Unit> changeUserCase(String userId, bool isDelete);
  Future<List<PostModel>> getAnotherUserPosts(String userId);
}

class AnotherProfileRemoteDataSourceImpl extends AnotherProfileRemoteDataSource {
  final BaseRepository baseRepository;
  AnotherProfileRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> changeUserCase(String userId, bool isDelete) async {
    SocketEmit().changeUserCase(userId, isDelete);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getAnotherUserPosts(String userId) async {
    diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.getAnotherUserPosts}?userId=$userId",
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
}
