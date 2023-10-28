import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import 'package:social_app/src/resources/base_repository.dart';
import 'package:social_app/src/services/socket/socket_emit.dart';

import '../../../../public/api_gateway.dart';
import '../../../../public/constants.dart';
import '../models/chat_model.dart';
import '../../domain/entities/chat.dart';

abstract class ChatRemoteDataSource {
  Future<Chat> getUserChat();
  Future<Unit> addMessage(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
    );
  Future<Unit> chatMessageSeen(String recieverId);
  Future<Unit> messageNotification(String userId, String message);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final BaseRepository baseRepository;
  ChatRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Chat> getUserChat() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getUserChat,
    );

    late Chat userChat;
    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        userChat = ChatModel.fromMap(
          response.data,
        );
      },
    );

    return userChat;
  }

  @override
  Future<Unit> addMessage(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
  ) {
    SocketEmit().addMessage(
      senderId,
      recieverId,
      message,
      type,
      repliedMessage,
      repliedType,
      repliedTo,
      repliedIsMe,
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> chatMessageSeen(String recieverId) async {
    var body = {
      "recieverId": recieverId,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.seenMessage,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> messageNotification(String userId, String message) async {
    var body = {
      "userId": userId,
      "message": message,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.messageToken,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
