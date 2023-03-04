import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/core/utils/app_component.dart';
import 'package:social_app/features/chat/domain/usecases/message_notification.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constance.dart';
import '../models/chat_model.dart';
import '../../domain/entities/chat.dart';

import '../../../../core/utils/constants/state_handle.dart';

abstract class BaseChatRemoteDataSource {
  Future<Chat> getMyChat();
  Future<Unit> chatMessageSeen(String recieverId);
  Future<Unit> messageNotification(String userId, String message);
}

class ChatRemoteDataSource extends BaseChatRemoteDataSource {
  final ApiClient apiClient;
  ChatRemoteDataSource(this.apiClient);

  @override
  Future<Chat> getMyChat() async {
    http.Response res = await apiClient.getData(
      ApiConstance.getMyChat,
    );
    late Chat myChat;
    stateErrorHandle(
      res: res,
      onSuccess: () {
        if (jsonDecode(res.body) != null) {
          myChat = ChatModel.fromMap(
          jsonDecode(res.body),
        );
        }else{
          null;
        }
      },
    );
    return myChat;
  }

  @override
  Future<Unit> chatMessageSeen(String recieverId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.seenMessage,
      jsonEncode({
        "recieverId": recieverId,
      }),
    );

    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> messageNotification(String userId, String message) async {
    http.Response res = await apiClient.postData(
      ApiConstance.messageToken,
      jsonEncode({
        "userId": userId,
        "message": message,
      }),
    );

    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }
}
