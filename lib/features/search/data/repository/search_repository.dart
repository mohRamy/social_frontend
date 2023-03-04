import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../auth/domain/entities/auth.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/base_search_repository.dart';
import '../datasources/search_remote_datasource.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource baseSearchRemoteDataSource;
  final NetworkInfo networkInfo;
  SearchRepositoryImpl(this.baseSearchRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Auth>>> searchUser(String searchQuery) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseSearchRemoteDataSource.searchUser(searchQuery);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }
}
