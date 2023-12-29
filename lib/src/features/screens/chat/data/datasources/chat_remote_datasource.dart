import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatModel> getUserChat();
  Future<Unit> addMessage(
    String idConversation,
    MessageModel message,
  );
  Future<Unit> isMessageSeen(String recieverId);
  // Future<Unit> messageNotification(String userId, String message);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final BaseRepository baseRepository;
  ChatRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<ChatModel> getUserChat() async {
    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getUserChat,
    );

    late ChatModel userChat;
    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        userChat = ChatModel.fromMap(response.data);
      },
    );

    return userChat;
  }

  @override
  Future<Unit> addMessage(
    String idConversation,
    MessageModel message,
  ) {
    SocketEmit().addMessage(
      idConversation,
      message,
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> isMessageSeen(String recieverId) async {
    SocketEmit().isMessageSeen(recieverId);
    return Future.value(unit);
  }

  // @override
  // Future<Unit> messageNotification(String userId, String message) async {
  //   var body = {
  //     "userId": UserLocal().getUserId(),
  //     "message": message,
  //   };

  //   diox.Response response = await baseRepository.postRoute(
  //     ApiGateway.messageToken,
  //     body,
  //   );

  //   AppConstants().handleApi(
  //     response: response,
  //     onSuccess: () {},
  //   );

  //   return Future.value(unit);
  // }
}
