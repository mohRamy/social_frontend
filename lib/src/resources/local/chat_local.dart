import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/chat/data/models/chat_model.dart';

class ChatLocal {
  final SharedPreferences sharedPreferences = Get.find();
  final chatKey = 'chat-key';
  final chatUsersKey = 'chat-users-key';

  void saveChat(ChatModel chat) async {
    await sharedPreferences.setString(chatKey, json.encode(chat.toJson()));
  }

  ChatModel? getChat() {
    var rawData = sharedPreferences.getString(chatKey);
    if (rawData != null) {
      return ChatModel.fromJson(rawData);
    }
    return null;
  }

  void clearChat() async {
    sharedPreferences.remove(chatKey);
  }
}
