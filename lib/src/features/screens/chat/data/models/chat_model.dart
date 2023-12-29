import 'dart:convert';

import 'package:timeago/timeago.dart';

import '../../../auth/data/models/auth_model.dart';

class ChatModel {
  final String id;
  final String userId;
  final List<ContactModel> contacts;

  ChatModel({
    required this.id,
    required this.userId,
    required this.contacts,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'contacts': contacts.map((contact) => contact.toJson()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['_id'] ?? '',
      userId: map['userId'] ?? '',
      contacts: List<ContactModel>.from(
        map['contacts']?.map((x) => ContactModel.fromMap(x)) ?? [],
      ),
    );
  }

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));
}

class ContactModel {
  final String id;
  final String recieverId;
  final MessageModel lastMessage;
  final DateTime createdAt;
  final AuthModel recieverData;
  List<MessageModel> messages;

  ContactModel({
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

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['_id'] ?? '',
      recieverId: map['recieverId'] ?? '',
      recieverData: AuthModel.fromMap(map['recieverData'] ?? ''),
      lastMessage: MessageModel.fromMap(
        map['lastMessage'],
      ),
      createdAt: DateTime.parse(map['createdAt']??''),
      messages: List<MessageModel>.from(
        map['messages']?.map((x) => MessageModel.fromMap(x)) ?? [],
      ),
    );
  }

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));
}

class MessageModel {
  final String? id;
  final String senderId;
  final String recieverId;
  final MsgModel msg;
  final RepliedMsgModel repliedMsg;
  final DateTime createdAt;
  final bool like;
  bool isSeen;
  MessageModel({
    this.id,
    required this.senderId,
    required this.recieverId,
    required this.msg,
    required this.repliedMsg,
    required this.createdAt,
    this.like = false,
    this.isSeen = false,
    
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': id ?? "",
      'senderId': senderId,
      'recieverId': recieverId,
      'msg': msg.toJson(),
      'repliedMsg': repliedMsg.toJson(),
      'like': like,
      'isSeen': isSeen,
      // 'createdAt': format(createdAt),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] ?? '',
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      msg: MsgModel.fromMap(map['msg']),
      repliedMsg: RepliedMsgModel.fromMap(map['repliedMsg']),
      createdAt: DateTime.parse(map['createdAt']),
      like: map['like'] ?? false,
      isSeen: map['isSeen'] ?? false,
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
  String type;
  String repliedTo;
  bool isMe;

  RepliedMsgModel({
    required this.repliedMessage,
    required this.type,
    required this.repliedTo,
    required this.isMe,
  });

  Map<String, dynamic> toJson() {
    return {
      'repliedMessage': repliedMessage,
      'type': type,
      'repliedTo': repliedTo,
      'isMe': isMe,
    };
  }

  factory RepliedMsgModel.fromMap(Map<String, dynamic> map) {
    return RepliedMsgModel(
      repliedMessage: map['repliedMessage'] ?? '',
      type: map['type'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
      isMe: map['isMe'] ?? false,
    );
  }

  factory RepliedMsgModel.fromJson(String source) =>
      RepliedMsgModel.fromMap(json.decode(source));
}
