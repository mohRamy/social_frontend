import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../domain/repository/base_search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource baseSearchRemoteDataSource;
  final NetworkInfo networkInfo;
  SearchRepositoryImpl(this.baseSearchRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<AuthModel>>> searchUser(String searchQuery) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseSearchRemoteDataSource.searchUser(searchQuery);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
