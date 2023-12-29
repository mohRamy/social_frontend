import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../core/widgets/app_clouding.dart';
import '../../data/models/chat_model.dart';
import '../../domain/usecases/add_message.dart';

import '../../domain/usecases/is_message_seen.dart';
import '../../domain/usecases/get_user_chat.dart';

class ChatController extends GetxController with HandleLoading {
  final GetUserChatUseCase getUserChatUseCase;
  final AddMessageUseCase addMessageUseCase;
  final IsMessageSeenUseCase chatMessageSeenUseCase;

  ChatController(
    this.getUserChatUseCase,
    this.addMessageUseCase,
    this.chatMessageSeenUseCase,
  );

  final ScrollController messageController = ScrollController();

  List<ContactModel> contacts = <ContactModel>[];
  // List<Map<String, ContactModel>> contactLis = [];

  List<MessageModel> messages = [];

  Map<String, String> idConversation = {};

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void getUserChat() async {
    final result = await getUserChatUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        contacts = r.contacts;
        // for (var i = 0; i < r.contents.length; i++) {
        //   contentList.add(r.contents[i]);
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
      msg.message = await cloudinaryPublic(msg.message);
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      repliedMsg.repliedMessage =
          await cloudinaryPublic(repliedMsg.repliedMessage);
    }
    
    MessageModel message = MessageModel(
      senderId: senderId,
      recieverId: recieverId,
      msg: msg,
      repliedMsg: repliedMsg,
      createdAt: DateTime.now(),
    );

    for (var i = 0; i < contacts.length; i++) {
      if (contacts[i].recieverId == recieverId) {
        contacts[i].messages.add(message);
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
    contacts.clear();
    List rawData = data;
    contacts = rawData.map((e) => ContactModel.fromMap(e)).toList();
    messageController.animateTo(messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      messageController.jumpTo(messageController.position.maxScrollExtent);
    });
    update();
  }

  void isMessageSeen(String recieverId) async {
    final result = await chatMessageSeenUseCase(recieverId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
  }

  void isedMessageSeen(dynamic data) async {
    for (var i = 0; i < contacts.length; i++) {
      if (contacts[i].recieverId == data) {
        for (var j = 0; j < contacts[i].messages.length; j++) {
          if (contacts[i].messages[j].senderId == UserLocal().getUserId() &&
              !contacts[i].messages[j].isSeen) {
            contacts[i].messages[j].isSeen = true;
          }
        }
      }
    }
    update();
  }

  // void messageNotification(String userId, String message) async {
  //   final result = await messageNotificationUseCase(userId, message);
  //   result.fold(
  //     (l) => handleLoading(l),
  //     (r) => null,
  //   );
  // }
}
