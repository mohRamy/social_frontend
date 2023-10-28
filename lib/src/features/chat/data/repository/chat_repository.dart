import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repository/base_chat_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/chat_remote_datasource.dart';

typedef GetMessage = Future<Unit> Function();

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource baseChatRemoteDataSource;
  final NetworkInfo networkInfo;
  ChatRepositoryImpl(this.baseChatRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Chat>> getUserChat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.getUserChat();
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMessage(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.addMessage(
          senderId,
          recieverId,
          message,
          type,
          repliedMessage,
          repliedType,
          repliedTo,
          repliedIsMe,
        );
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> chatMessageSeen(String recieverId) async {
    return await _getMessage(() {
      return baseChatRemoteDataSource.chatMessageSeen(recieverId);
    });
  }

  @override
  Future<Either<Failure, Unit>> messageNotification(
      String userId, String message) async {
    return await _getMessage(() {
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
      return left(const OfflineFailure(message: "Offline failure"));
    }
  }
}
