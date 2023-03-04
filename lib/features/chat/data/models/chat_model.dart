import 'dart:convert';

import '../../domain/entities/chat.dart';

class ChatModel extends Chat {
  const ChatModel({
    required super.id,
    required super.userId,
    required super.contents,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      contents: List<ContentModel>.from(
          map['contents']?.map((x) => ContentModel.fromMap(x)) ?? []),
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}

class ContentModel extends Content {
  const ContentModel({
    required super.recieverId,
    required super.messages,
    required super.id,
  });


  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: map['_id'] ?? '',
      recieverId: map['recieverId'] ?? '',
      messages: List<MessageModel>.from(
          map['messages']?.map((x) => MessageModel.fromMap(x)) ?? []),
    );
  }

  factory ContentModel.fromJson(String source) =>
      ContentModel.fromMap(json.decode(source));
}

class MessageModel extends Message {
  const MessageModel({
    required super.msg,
    required super.repliedMsg,
    required super.senderId,
    required super.recieverId,
    required super.like,
    required super.isSeen,
    required super.id,
    required super.createdAt,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] ?? '',
      msg: MsgModel.fromMap(map['msg']),
      repliedMsg: RepliedMsgModel.fromMap(map['repliedMsg']),
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      like: map['like'] ?? false,
      isSeen: map['isSeen'] ?? false,
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));
}

class MsgModel extends Msg {
  MsgModel({
    required super.message,
    required super.type,
  });


  factory MsgModel.fromMap(Map<String, dynamic> map) {
    return MsgModel(
      message: map['message'] ?? '',
      type: map['type'] ?? '',
    );
  }

  factory MsgModel.fromJson(String source) =>
      MsgModel.fromMap(json.decode(source));
}

class RepliedMsgModel extends RepliedMsg {
  RepliedMsgModel({
    required super.repliedMessage,
    required super.type,
    required super.repliedTo,
    required super.isMe,
  });


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
