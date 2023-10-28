import 'package:get/get.dart';

class MessageReply extends GetxController{
  final String message;
  final bool isMe;
  final String type;
  MessageReply(
    this.message,
    this.isMe,
    this.type,
  );
}