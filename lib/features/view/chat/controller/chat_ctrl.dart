import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/controller/user_ctrl.dart';

import 'package:social_app/core/network/network_info.dart';
import 'package:social_app/features/data/models/group.dart';
import 'package:social_app/features/data/models/message_model.dart';
import 'package:social_app/features/data/models/message_reply_provider.dart';

import '../../../../core/enums/message_enum.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/chat_contact_model.dart';
import '../repo/chat_repo.dart';

// final chatControllerProvider = Provider((ref) {
//   final chatRepository = ref.watch(chatRepositoryProvider);
//   return ChatController(
//     chatRepository: chatRepository,
//     ref: ref,
//   );
// });

class ChatCtrl extends GetxController {
  final ChatRepo chatRepo;
  final NetworkInfo networkInfo;
  ChatCtrl({
    required this.chatRepo,
    required this.networkInfo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ChatContactModel> contacts = [];
  List<GroupModel> groups = [];
  List<MessageModel> messages = [];
  List<MessageModel> groupMessages = [];

  Future<void> fetchAllChatContact() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchAllChatContact();
        stateHandle(
          res: res,
          onSuccess: () {
            contacts = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              contacts.add(
                ChatContactModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            // storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  Future<void> fetchAllChatGroups() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchAllChatGroups();
        stateHandle(
          res: res,
          onSuccess: () {
            groups = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              groups.add(
                GroupModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            // storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }


  Future<void> fetchChat(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchChat(userId);
        stateHandle(
          res: res,
          onSuccess: () {
            messages = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              messages.add(
                MessageModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            // storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }


  Future<void> fetchGroupChat(String groupId) async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await chatRepo.fetchGroupChat(groupId);
        stateHandle(
          res: res,
          onSuccess: () {
            groupMessages = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              groupMessages.add(
                MessageModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            // storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        // contacts = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  ) {
    MessageReply messageReply = Get.find<MessageReply>();
    chatRepo.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: Get.find<UserCtrl>().user,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          );
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  ) {
        MessageReply messageReply = Get.find<MessageReply>();
    chatRepo.sendFileMessage(
            context: context,
            file: file,
            recieverUserId: recieverUserId,
            senderUserData: Get.find<UserCtrl>().user,
            messageEnum: messageEnum,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
          );
  }

  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
    bool isGroupChat,
  ) {
    MessageReply messageReply = Get.find<MessageReply>();
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';

    chatRepo.sendGIFMessage(
            context: context,
            gifUrl: newgifUrl,
            recieverUserId: recieverUserId,
            senderUser: Get.find<UserCtrl>().user,
            messageReply: messageReply,
            isGroupChat: isGroupChat,
        );
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    chatRepo.setChatMessageSeen(
      recieverUserId,
      messageId,
    );
  }
}
