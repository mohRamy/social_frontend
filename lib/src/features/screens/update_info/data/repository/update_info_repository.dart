import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';
import 'package:social_app/src/features/screens/update_info/data/datasources/update_info_remote_datasource.dart';
import 'package:social_app/src/features/screens/update_info/domain/repository/base_update_info_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class UpdateInfoRepositoryImpl extends UpdateInfoRepository {
  final UpdateInfoRemoteDataSource baseUpdateInfoRemoteDataSource;
  final NetworkInfo networkInfo;
  UpdateInfoRepositoryImpl(
    this.baseUpdateInfoRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, Unit>> updateInfo(AuthModel userInfo) async {
    return await _getMessage(() {
      return baseUpdateInfoRemoteDataSource.updateInfo(userInfo);
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
