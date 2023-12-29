import 'package:dartz/dartz.dart';
import '../datasources/add_story_remote_datasource.dart';
import '../../domain/repository/base_add_story_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class AddStoryRepositoryImpl extends AddStoryRepository {
  final AddStoryRemoteDataSource baseAddStoryRemoteDataSource;
  final NetworkInfo networkInfo;
  AddStoryRepositoryImpl(
    this.baseAddStoryRemoteDataSource,
    this.networkInfo,
  );
  @override
  Future<Either<Failure, Unit>> addStory(
      List<String> storiesUrl, List<String> storiesType) async {
    return await _getMessage(() {
      return baseAddStoryRemoteDataSource.addStory(storiesUrl, storiesType);
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
