import 'dart:async';

import 'package:get/get.dart';
import '../../../../core/widgets/app_clouding.dart';
import '../../data/models/chat_model.dart';
import '../../domain/usecases/add_message.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../domain/usecases/chat_message_seen.dart';
import '../../domain/usecases/get_user_chat.dart';

import '../../domain/usecases/message_notification.dart';

class ChatController extends GetxController with HandleLoading {
  final GetUserChatUseCase getUserChatUseCase;
  final AddMessageUseCase addMessageUseCase;
  final ChatMessageSeenUseCase chatMessageSeenUseCase;
  final MessageNotificationUseCase messageNotificationUseCase;

  ChatController({
    required this.getUserChatUseCase,
    required this.addMessageUseCase,
    required this.chatMessageSeenUseCase,
    required this.messageNotificationUseCase,
  });

  List<ContentModel> contentList = [];

  Map<String, String> idConversation = {};

  void getUserChat() async {
    final result = await getUserChatUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        for (var i = 0; i < r.contents.length; i++) {
          contentList.add(r.contents[i]);
        }
      },
    );
  }

  FutureOr<void> addMessage(
    String senderId,
    String recieverId,
    MsgModel msg,
    RepliedMsgModel? repliedMsg,
  ) async {
    if (msg.type == 'image' || msg.type == 'video') {
      cloudinaryPuplic(msg.message);
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      cloudinaryPuplic(repliedMsg.repliedMessage);
    }

    MessageModel message = MessageModel(
      senderId: senderId,
      recieverId: recieverId,
      msg: msg,
      repliedMsg: repliedMsg,
    );

    for (var i = 0; i < contentList.length; i++) {
      if (contentList[i].recieverId == recieverId) {
        contentList[i].messages.add(message);
      }
    }

    final result = await addMessageUseCase(
      "id-conversation",
      message,
    );

    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  void addedMessage(dynamic data) async {
    MessageModel message = MessageModel.fromMap(data);

    for (var i = 0; i < contentList.length; i++) {
      if (contentList[i].recieverId == message.senderId) {
        contentList[i].messages.add(message);
      }
    }
    update();
  }

  void chatMessageSeen(String recieverId) async {
    final result = await chatMessageSeenUseCase(recieverId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
  }

  void messageNotification(String userId, String message) async {
    final result = await messageNotificationUseCase(userId, message);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
  }
}
