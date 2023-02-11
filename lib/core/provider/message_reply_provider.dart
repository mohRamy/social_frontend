import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final String type;
  MessageReply(
    this.message,
    this.isMe,
    this.type,
  );
}

final messageReplyProvider = StateProvider<MessageReply?>((ref)=> null);