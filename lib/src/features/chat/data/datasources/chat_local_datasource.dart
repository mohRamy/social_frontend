import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<Unit> saveChat(ChatModel chat);
  ChatModel? getChat();
  Future<bool> clearChat();
}

class ChatLocalDataSourceImpl extends ChatLocalDataSource {
  final SharedPreferences sharedPreferences;
  ChatLocalDataSourceImpl(this.sharedPreferences);

  final chatKey = 'chat-key';
  final chatUsersKey = 'chat-users-key';

  @override
  Future<Unit> saveChat(ChatModel chat) async {
    await sharedPreferences.setString(chatKey, json.encode(chat.toJson()));
    return Future.value(unit);
  }

  @override
  ChatModel? getChat() {
    var rawData = sharedPreferences.getString(chatKey);
    if (rawData != null) {
      return ChatModel.fromJson(rawData);
    }
    return null;
  }

  @override
  Future<bool> clearChat() async {
    return await sharedPreferences.remove(chatKey);
  }
}
