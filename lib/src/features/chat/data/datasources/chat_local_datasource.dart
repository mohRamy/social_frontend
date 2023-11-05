import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/src/core/error/exceptions.dart';

import '../models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<Unit> saveChat(ChatModel chat);
  ChatModel? getChat();
  Future<bool> clearChat();
}

class ChatLocalDataSourceImpl extends ChatLocalDataSource {
  final SharedPreferences sharedPreferences;
  ChatLocalDataSourceImpl(this.sharedPreferences);

  final userChatKey = 'user-chat-key';

  @override
  Future<Unit> saveChat(ChatModel chat) async {
    try {
      await sharedPreferences.setString(userChatKey, json.encode(chat.toJson()));
      return Future.value(unit);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
ChatModel? getChat() {
  try {
    var rawData = sharedPreferences.getString(userChatKey);
    if (rawData != null) {
      return ChatModel.fromJson(rawData);
    }
    return null;
  } catch (e) {
    throw LocalException(messageError: e.toString());
  }
}


  @override
  Future<bool> clearChat() async {
    try {
      return await sharedPreferences.remove(userChatKey);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }
}
