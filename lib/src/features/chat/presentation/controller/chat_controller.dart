import 'dart:async';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import '../../data/models/chat_model.dart';
import '../../domain/usecases/add_message.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../domain/usecases/chat_message_seen.dart';
import '../../domain/usecases/get_user_chat.dart';

import '../../domain/usecases/message_notification.dart';

class ChatController extends GetxController with HandleErrorLoading {
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

  // Map<String, ContentModel> content = {};
  List<ContentModel> contentList = [];

  Map<String, String> idConversation = {};

  void getUserChat() async {
    final result = await getUserChatUseCase();
    result.fold(
      (l) => handleError(l),
      (r) async {

        // for (var i = 0; i < r.contents.length; i++) {
        //   content[r.contents[i].recieverId] = r.contents[i];
        // }

        for (var i = 0; i < r.contents.length; i++) {
          contentList.add(r.contents[i]);
        }

        // for (var content in r.contents) {
        //   messages[content.recieverId] = content.messages;
        // }
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
      int random = Random().nextInt(1000);
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          msg.message,
          folder: "$random",
        ),
      );
      msg.message = res.secureUrl;
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      int random = Random().nextInt(1000);

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          repliedMsg.repliedMessage,
          folder: "$random",
        ),
      );
      repliedMsg.repliedMessage = res.secureUrl;
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
      "id",
      message,
    );

    result.fold(
      (l) => handleError(l),
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
      (l) => handleError(l),
      (r) => null,
    );
  }

  void messageNotification(String userId, String message) async {
    final result = await messageNotificationUseCase(userId, message);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );
  }
}
