import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/view_story/data/datasources/view_story_remote_datasource.dart';
import 'package:social_app/src/features/screens/view_story/domain/repository/base_view_story_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class ViewStoryRepositoryImpl extends ViewStoryRepository {
  final ViewStoryRemoteDataSource baseViewStoryRemoteDataSource;
  final NetworkInfo networkInfo;
  ViewStoryRepositoryImpl(
    this.baseViewStoryRemoteDataSource,
    this.networkInfo,
  );

    @override
  Future<Either<Failure, Unit>> changeStoryLike(String storyId) async {
    return await _getMessage(() {
      return baseViewStoryRemoteDataSource.changeStoryLike(storyId);
    });
  }


  @override
  Future<Either<Failure, Unit>> addStoryShare(String storyId) async {
    return await _getMessage(() {
      return baseViewStoryRemoteDataSource.addStoryShare(storyId);
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
