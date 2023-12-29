import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/taps/requist/domain/repository/base_requist_repository.dart';
import '../datasources/requist_remote_datasource.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class RequistRepositoryImpl extends RequistRepository {
  final RequistRemoteDataSource baseRequistRemoteDataSource;
  final NetworkInfo networkInfo;
  RequistRepositoryImpl(this.baseRequistRemoteDataSource, this.networkInfo);

    @override
  Future<Either<Failure, Unit>> changeUserCase(String userId, bool isDelete) async {
        return await _getMessage(() {
      return baseRequistRemoteDataSource.changeUserCase(userId, isDelete);
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
