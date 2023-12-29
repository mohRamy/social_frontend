import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final String type;
  final String repliedTo;
  MessageReply(
    this.message,
    this.isMe,
    this.type,
    this.repliedTo,
  );
}

final messageReplyProvider = StateProvider<MessageReply?>((ref)=> null);