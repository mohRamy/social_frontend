import 'package:dartz/dartz.dart';

import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';

abstract class RequistRemoteDataSource {
  Future<Unit> changeUserCase(String userId, bool isDelete);
}

class RequistRemoteDataSourceImpl extends RequistRemoteDataSource {
  final BaseRepository baseRepository;
  RequistRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> changeUserCase(String userId, bool isDelete) async {
    SocketEmit().changeUserCase(userId, isDelete);
    return Future.value(unit);
  }
}
