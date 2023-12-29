import 'package:dartz/dartz.dart';

import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';

abstract class ViewStoryRemoteDataSource {
  Future<Unit> changeStoryLike(String storyId);
  Future<Unit> addStoryShare(String storyId);
}

class ViewStoryRemoteDataSourceImpl extends ViewStoryRemoteDataSource {
  final BaseRepository baseRepository;
  ViewStoryRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> changeStoryLike(String storyId) {
    SocketEmit().changeStoryLikeEmit(storyId);
    return Future.value(unit);
  }

  @override
  Future<Unit> addStoryShare(String storyId) {
    SocketEmit().addStoryShare(storyId);
    return Future.value(unit);
  }
}
