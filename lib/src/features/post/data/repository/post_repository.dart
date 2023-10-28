import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/base_post_repository.dart';
import '../datasources/post_remote_datasource.dart';

typedef Future<Unit> GetMessage();

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDataSource basePostRemoteDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl(this.basePostRemoteDataSource, this.networkInfo);
  @override
  Future<Either<Failure, Unit>> addPost(
      String description, List<String> postsUrl, List<String> postsType) async {
    return await _getMessage(() {
      return basePostRemoteDataSource.addPost(description, postsUrl, postsType);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return right(unit);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }
}
