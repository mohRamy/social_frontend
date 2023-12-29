import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../domain/repository/base_chat_repository.dart';

import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_model.dart';

typedef GetMessage = Future<Unit> Function();

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource baseChatRemoteDataSource;
  final ChatLocalDataSource baseChatLocalDataSource;
  final NetworkInfo networkInfo;
  ChatRepositoryImpl(
    this.baseChatRemoteDataSource,
    this.baseChatLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, ChatModel>> getUserChat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.getUserChat();
        baseChatLocalDataSource.saveChat(result);
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      final result = baseChatLocalDataSource.getChat();
      return Right(result!);
    }
  }

  @override
  Future<Either<Failure, Unit>> addMessage(
    String idConversation,
    MessageModel message,
  ) async {
    return await _getMessage(() {
      return baseChatRemoteDataSource.addMessage(
        idConversation,
        message,
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> isMessageSeen(String recieverId) async {
    return await _getMessage(() {
      return baseChatRemoteDataSource.isMessageSeen(recieverId);
    });
  }

  // @override
  // Future<Either<Failure, Unit>> messageNotification(
  //   String userId,
  //   String message,
  // ) async {
  //   return await _getMessage(() {
  //     return baseChatRemoteDataSource.messageNotification(userId, message);
  //   });
  // }

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
