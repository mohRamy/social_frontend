import 'dart:convert';

import 'package:timeago/timeago.dart';

import '../../../auth/data/models/auth_model.dart';

class ChatModel {
  final String id;
  final String userId;
  final List<ContentModel> contents;

  ChatModel({
    required this.id,
    required this.userId,
    required this.contents,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'contents': contents.map((content) => content.toJson()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      contents: List<ContentModel>.from(
        map['contents']?.map((x) => ContentModel.fromMap(x)) ?? [],
      ),
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}

class ContentModel {
  final String id;
  final String recieverId;
  final MessageModel lastMessage;
  final DateTime createdAt;
  final AuthModel recieverData;
  List<MessageModel> messages;

  ContentModel({
    required this.id,
    required this.recieverId,
    required this.lastMessage,
    required this.createdAt,
    required this.recieverData,
    required this.messages,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'recieverId': recieverId,
      'lastMessage': lastMessage.toJson(),
      'createdAt': format(createdAt),
      'recieverData': recieverData.toJson(),
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['_id'] ?? '',
      recieverId: map['recieverId'] ?? '',
      lastMessage: MessageModel.fromMap(
        map['lastMessage'],
      ),
      createdAt: DateTime.parse(map['createdAt']).toLocal(),
      recieverData: AuthModel.fromMap(map['recieverData'] ?? ''),
      messages: List<MessageModel>.from(
        map['messages']?.map((x) => MessageModel.fromMap(x)) ?? [],
      ),
    );
  }

  factory ContentModel.fromJson(String source) =>
      ContentModel.fromMap(json.decode(source));
}

class MessageModel {
  final String? id;
  final String senderId;
  final String recieverId;
  final MsgModel msg;
  final RepliedMsgModel repliedMsg;
  final bool like;
  final bool isSeen;
  final DateTime? createdAt;

  MessageModel({
    this.id,
    required this.senderId,
    required this.recieverId,
    required this.msg,
    required this.repliedMsg,
    this.like = false,
    this.isSeen = false,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'senderId': senderId,
      'recieverId': recieverId,
      'msg': msg.toJson(),
      'repliedMsg': repliedMsg.toJson(),
      'like': like,
      'isSeen': isSeen,
      'createdAt': format(createdAt!),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] ?? '',
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      msg: MsgModel.fromMap(map['msg']),
      repliedMsg: RepliedMsgModel.fromMap(map['repliedMsg']),
      like: map['like'] ?? false,
      isSeen: map['isSeen'] ?? false,
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}

class MsgModel {
  String message;
  final String type;

  MsgModel({
    required this.message,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
    };
  }

  factory MsgModel.fromMap(Map<String, dynamic> map) {
    return MsgModel(
      message: map['message'] ?? '',
      type: map['type'] ?? '',
    );
  }

  factory MsgModel.fromJson(String source) =>
      MsgModel.fromMap(json.decode(source));
}

class RepliedMsgModel {
  String repliedMessage;
  final String type;
  final String repliedTo;
  final bool isMe;

  RepliedMsgModel({
    required this.repliedMessage,
    required this.type,
    required this.repliedTo,
    required this.isMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'repliedMessage': repliedMessage,
      'repliedType': type,
      'repliedTo': repliedTo,
      'repliedIsMe': isMe,
    };
  }

  factory RepliedMsgModel.fromMap(Map<String, dynamic> map) {
    return RepliedMsgModel(
      repliedMessage: map['repliedMessage'] ?? '',
      type: map['repliedType'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      isMe: map['repliedIsMe'] ?? false,
    );
  }

  factory RepliedMsgModel.fromJson(String source) =>
      RepliedMsgModel.fromMap(json.decode(source));
}
