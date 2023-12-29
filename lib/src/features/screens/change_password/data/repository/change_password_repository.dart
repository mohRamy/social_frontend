import 'package:dartz/dartz.dart';
import '../datasources/change_password_remote_datasource.dart';
import '../../domain/repository/base_change_password_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class ChangePasswordRepositoryImpl extends ChangePasswordRepository {
  final ChangePasswordRemoteDataSource baseChangePasswordRemoteDataSource;
  final NetworkInfo networkInfo;
  ChangePasswordRepositoryImpl(this.baseChangePasswordRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> changePassword(String currentPassword, String newPassword) async {
    return await _getMessage(() {
      return baseChangePasswordRemoteDataSource.changePassword(currentPassword, newPassword);
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
