import 'package:dartz/dartz.dart';
import '../datasources/privacy_remote_datasource.dart';
import '../../domain/repository/base_privacy_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class PrivacyRepositoryImpl extends PrivacyRepository {
  final PrivacyRemoteDataSource basePrivacyRemoteDataSource;
  final NetworkInfo networkInfo;
  PrivacyRepositoryImpl(this.basePrivacyRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> privateAccount() async {
    return await _getMessage(() {
      return basePrivacyRemoteDataSource.privateAccount();
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
