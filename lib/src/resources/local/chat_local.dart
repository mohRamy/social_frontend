import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:social_app/src/features/chat/data/models/chat_model.dart';
import 'package:social_app/src/features/chat/domain/entities/chat.dart';

class ChatLocal {
  final _getStorage = GetStorage();
  final chatKey = 'chat';
  
  void saveChat(Chat chat) async {
    _getStorage.write(chatKey, chat);
  }

  Chat? getChat() {
    var rawData = _getStorage.read(chatKey);    
    if (rawData != null) {
      return ChatModel.fromJson(json.decode(rawData));
    }
    return null;
  }

  void clearChat() async {
    _getStorage.remove(chatKey);
  }
}
