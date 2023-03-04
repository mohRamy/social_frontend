import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repository/base_chat_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/chat_remote_datasource.dart';

typedef Future<Unit> GetMessage();

class ChatRepository extends BaseChatRepository {
  final BaseChatRemoteDataSource baseChatRemoteDataSource;
  final NetworkInfo networkInfo;
  ChatRepository(this.baseChatRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Chat>> getMyChat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.getMyChat();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> chatMessageSeen(String recieverId) async {
    return await _getMessage((){
      return baseChatRemoteDataSource.chatMessageSeen(recieverId);
    });
  }

  @override
  Future<Either<Failure, Unit>> messageNotification(String userId, String message) async {
    return await _getMessage((){
      return baseChatRemoteDataSource.messageNotification(userId, message);
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
