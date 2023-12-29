import 'package:dartz/dartz.dart';
import '../datasources/friends_remote_datasource.dart';
import '../../domain/repository/base_friends_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class FriendsRepositoryImpl extends FriendsRepository {
  final FriendsRemoteDataSource baseFriendsRemoteDataSource;
  final NetworkInfo networkInfo;
  FriendsRepositoryImpl(
    this.baseFriendsRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> removeFriend(
    String userId,
  ) async {
    return await _getMessage(() {
      return baseFriendsRemoteDataSource.removeFriend(userId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return const Right(unit);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
