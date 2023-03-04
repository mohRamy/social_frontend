// // import 'dart:convert';

// // import 'package:social_app/features/data/models/message_model.dart';

// // class ChatModel {
// //   final String id;
// //   final String userId;
// //   final List<ContentsModel> contents;
// //   ChatModel({
// //     required this.id,
// //     required this.userId,
// //     required this.contents,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'userId': userId,
// //       'contents': contents.map((x) => x.toMap()).toList(),
// //     };
// //   }

// //   factory ChatModel.fromMap(Map<String, dynamic> map) {
// //     return ChatModel(
// //       id: map['_id'] ?? '',
// //       userId: map['userId'] ?? '',
// //       contents: List<ContentsModel>.from(map['contents']?.map((x) => ContentsModel.fromMap(x))),
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source));
// // }

// // class ContentsModel {
// //   final String id;
// //   final String recieverId;
// //   final List<MsgModel> messages;
// //   ContentsModel({
// //     required this.id,
// //     required this.recieverId,
// //     required this.messages,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'recieverId': recieverId,
// //       'messages': messages.map((x) => x.toMap()).toList(),
// //     };
// //   }

// //   factory ContentsModel.fromMap(Map<String, dynamic> map) {
// //     return ContentsModel(
// //       id: map['_id'] ?? '',
// //       recieverId: map['recieverId'] ?? '',
// //       messages: List<MsgModel>.from(map['messages']?.map((x) => MsgModel.fromMap(x))),
// //     );
// //   }

// //   String toJson() => json.encode(toMap());

// //   factory ContentsModel.fromJson(String source) => ContentsModel.fromMap(json.decode(source));
// // }

// class ChatModel {
//   String? sId;
//   String? userId;
//   List<Contents>? contents;
//   int? iV;

//   ChatModel({this.sId, this.userId, this.contents, this.iV});

//   ChatModel.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userId = json['userId'];
//     if (json['contents'] != null) {
//       contents = <Contents>[];
//       json['contents'].forEach((v) {
//         contents!.add(Contents.fromJson(v));
//       });
//     }
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['userId'] = userId;
//     if (contents != null) {
//       data['contents'] = contents!.map((v) => v.toJson()).toList();
//     }
//     data['__v'] = iV;
//     return data;
//   }
// }

// class Contents {
//   String? recieverId;
//   List<Messages>? messages;
//   String? sId;

//   Contents({this.recieverId, this.messages, this.sId});

//   Contents.fromJson(Map<String, dynamic> json) {
//     recieverId = json['recieverId'];
//     if (json['messages'] != null) {
//       messages = <Messages>[];
//       json['messages'].forEach((v) {
//         messages!.add(Messages.fromJson(v));
//       });
//     }
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['recieverId'] = recieverId;
//     if (messages != null) {
//       data['messages'] = messages!.map((v) => v.toJson()).toList();
//     }
//     data['_id'] = sId;
//     return data;
//   }
// }

// class Messages {
//   Msg? msg;
//   RepliedMsg? repliedMsg;
//   String? senderId;
//   String? recieverId;
//   bool? like;
//   bool? isSeen;
//   String? sId;
//   DateTime? createdAt;

//   Messages(
//       {this.msg,
//       this.repliedMsg,
//       this.senderId,
//       this.recieverId,
//       this.like,
//       this.isSeen,
//       this.sId,
//       this.createdAt});

//   Messages.fromJson(Map<String, dynamic> json) {
//     msg = json['msg'] != null ? Msg.fromJson(json['msg']) : null;
//     repliedMsg = json['repliedMsg'] != null
//         ? RepliedMsg.fromJson(json['repliedMsg'])
//         : null;
//     senderId = json['senderId'];
//     recieverId = json['recieverId'];
//     like = json['like'];
//     isSeen = json['isSeen'];
//     sId = json['_id'];
//     createdAt = DateTime.parse(json["createdAt"]);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (msg != null) {
//       data['msg'] = msg!.toJson();
//     }
//     if (repliedMsg != null) {
//       data['repliedMsg'] = repliedMsg!.toJson();
//     }
//     data['senderId'] = senderId;
//     data['recieverId'] = recieverId;
//     data['like'] = like;
//     data['isSeen'] = isSeen;
//     data['_id'] = sId;
//     data['createdAt'] = createdAt;
//     return data;
//   }
// }

// class Msg {
//   String? message;
//   String? type;

//   Msg({this.message, this.type});

//   Msg.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     type = json['type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['type'] = type;
//     return data;
//   }
// }

// class RepliedMsg {
//   String? repliedMessage;
//   String? type;
//   String? repliedTo;
//   bool? isMe;

//   RepliedMsg({this.repliedMessage, this.type, this.repliedTo, this.isMe});

//   RepliedMsg.fromJson(Map<String, dynamic> json) {
//     repliedMessage = json['repliedMessage'];
//     type = json['type'];
//     repliedTo = json['repliedTo'];
//     isMe = json['isMe'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['repliedMessage'] = repliedMessage;
//     data['type'] = type;
//     data['repliedTo'] = repliedTo;
//     data['isMe'] = isMe;
//     return data;
//   }
// }