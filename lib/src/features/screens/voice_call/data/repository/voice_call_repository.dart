import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/voice_call/data/datasources/voice_call_remote_datasource.dart';
import 'package:social_app/src/features/screens/voice_call/domain/repository/base_voice_call_repository.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';

typedef GetMessage = Future<Unit> Function();

class VoiceCallRepositoryImpl extends VoiceCallRepository {
  final VoiceCallRemoteDataSource baseVoiceCallRemoteDataSource;
  final NetworkInfo networkInfo;
  VoiceCallRepositoryImpl(
    this.baseVoiceCallRemoteDataSource,
    this.networkInfo,
  );

    @override
  Future<Either<Failure, Unit>> changeStoryLike(String storyId) async {
    return await _getMessage(() {
      return baseVoiceCallRemoteDataSource.changeStoryLike(storyId);
    });
  }


  @override
  Future<Either<Failure, Unit>> addStoryShare(String storyId) async {
    return await _getMessage(() {
      return baseVoiceCallRemoteDataSource.addStoryShare(storyId);
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
