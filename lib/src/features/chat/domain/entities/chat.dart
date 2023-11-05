// import 'package:equatable/equatable.dart';

// class Chat extends Equatable {
//   final String id;
//   final String userId;
//   final List<Content> contents;
//   const Chat({
//     required this.id,
//     required this.userId,
//     required this.contents,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         userId,
//         contents,
//       ];
// }

// class Content extends Equatable {
//   final String id;
//   final String recieverId;
//   final List<Message> messages;
//   const Content({
//     required this.id,
//     required this.recieverId,
//     required this.messages,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         recieverId,
//         messages,
//       ];
// }

// class Message extends Equatable {
//   final String id;
//   final Msg msg;
//   final RepliedMsg repliedMsg;
//   final String senderId;
//   final String recieverId;
//   final bool like;
//   final bool isSeen;
//   final DateTime createdAt;
//   const Message({
//     required this.id,
//     required this.msg,
//     required this.repliedMsg,
//     required this.senderId,
//     required this.recieverId,
//     required this.like,
//     required this.isSeen,
//     required this.createdAt,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         msg,
//         recieverId,
//         senderId,
//         recieverId,
//         like,
//         isSeen,
//         createdAt,
//       ];
// }

// class Msg extends Equatable {
//   final String message;
//   final String type;
//   const Msg({
//     required this.message,
//     required this.type,
//   });

//   @override
//   List<Object?> get props => [
//         message,
//         type,
//       ];
// }

// class RepliedMsg extends Equatable {
//   final String repliedMessage;
//   final String type;
//   final String repliedTo;
//   final bool isMe;
//   const RepliedMsg({
//     required this.repliedMessage,
//     required this.type,
//     required this.repliedTo,
//     required this.isMe,
//   });

//   @override
//   List<Object?> get props => [
//         repliedMessage,
//         type,
//         repliedTo,
//         isMe,
//       ];
// }
