// import 'dart:convert';
// class MsgModel {
//   final String id;
//   final String senderId;
//   final String recieverId;
//   final Msg msg;
//   final RepliedMsg repliedMsg;
//   final bool like;
//   final DateTime createdAt;
//   final bool isSeen;
//   MsgModel({
//     required this.id,
//     required this.senderId,
//     required this.recieverId,
//     required this.msg,
//     required this.repliedMsg,
//     required this.like,
//     required this.createdAt,
//     required this.isSeen,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'senderId': senderId,
//       'recieverId': recieverId,
//       'msg': msg.toMap(),
//       'repliedMsg': repliedMsg.toMap(),
//       'like': like,
//       'createdAt': createdAt.millisecondsSinceEpoch,
//       'isSeen': isSeen,
//     };
//   }

//   factory MsgModel.fromMap(Map<String, dynamic> map) {
//     return MsgModel(
//       id: map['_id'] ?? '',
//       senderId: map['senderId'] ?? '',
//       recieverId: map['recieverId'] ?? '',
//       msg: Msg.fromMap(map['msg']),
//       repliedMsg: RepliedMsg.fromMap(map['repliedMsg']),
//       like: map['like'] ?? false,
//       createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
//       isSeen: map['isSeen'] ?? false,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory MsgModel.fromJson(String source) =>
//       MsgModel.fromMap(json.decode(source));
// }

// class Msg {
//   String message;
//   String type;
//   Msg({
//     required this.message,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'message': message,
//       'type': type,
//     };
//   }

//   factory Msg.fromMap(Map<String, dynamic> map) {
//     return Msg(
//       message: map['message'] ?? '',
//       type: map['type'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Msg.fromJson(String source) => Msg.fromMap(json.decode(source));
// }

// class RepliedMsg {
//   String repliedMessage;
//   String type;
//   String repliedTo;
//   bool isMe;
//   RepliedMsg({
//     required this.repliedMessage,
//     required this.type,
//     required this.repliedTo,
//     required this.isMe,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'repliedMessage': repliedMessage,
//       'type': type,
//       'repliedTo': repliedTo,
//       'isMe': isMe,
//     };
//   }

//   factory RepliedMsg.fromMap(Map<String, dynamic> map) {
//     return RepliedMsg(
//       repliedMessage: map['repliedMessage'] ?? '',
//       type: map['type'] ?? '',
//       repliedTo: map['repliedTo'] ?? '',
//       isMe: map['isMe'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory RepliedMsg.fromJson(String source) =>
//       RepliedMsg.fromMap(json.decode(source));
// }
