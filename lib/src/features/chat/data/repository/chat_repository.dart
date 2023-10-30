import 'package:dartz/dartz.dart';
import '../../../../resources/local/chat_local.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/base_chat_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/chat_model.dart';

typedef GetMessage = Future<Unit> Function();

class ChatRepositoryImpl extends ChatRepository {
  final ChatRemoteDataSource baseChatRemoteDataSource;
  final NetworkInfo networkInfo;
  ChatRepositoryImpl(this.baseChatRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, ChatModel>> getUserChat() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.getUserChat();
        ChatLocal().saveChat(result);
        return right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(message: failure.messageError));
      }
    } else {
      final result = ChatLocal().getChat();
      return right(result!);
    }
  }

  @override
  Future<Either<Failure, Unit>> addMessage(
    String idConversation,
    MessageModel message,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseChatRemoteDataSource.addMessage(
          idConversation,
          message,
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
