import 'package:dartz/dartz.dart';

import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';

abstract class FriendsRemoteDataSource {
  Future<Unit> removeFriend(String userId);
}

class FriendsRemoteDataSourceImpl extends FriendsRemoteDataSource {
  final BaseRepository baseRepository;
  FriendsRemoteDataSourceImpl(this.baseRepository);

    @override
  Future<Unit> removeFriend(String userId) {
    SocketEmit().changeUserCase(userId, true);
    return Future.value(unit);
  }
}
