import 'dart:async';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/chat/domain/usecases/add_message.dart';
import 'package:social_app/src/resources/local/chat_local.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../../../public/components.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/chat_message_seen.dart';
import '../../domain/usecases/get_user_chat.dart';

import '../../domain/usecases/message_notification.dart';

class ChatController extends GetxController with HandleErrorLoading {
  final GetUserChatUseCase getUserChatUseCase;
  final AddMessageUseCase addMessageUseCase;
  final ChatMessageSeenUseCase chatMessageSeenUseCase;
  final MessageNotificationUseCase messageNotificationUseCase;

  ChatController({
    required this.getUserChatUseCase,
    required this.addMessageUseCase,
    required this.chatMessageSeenUseCase,
    required this.messageNotificationUseCase,
  });

  Chat? userChat;
  Rx<RxMap<String, List<Message>>> messages = Rx(<String, List<Message>>{}.obs);

  void getUserChat() async {
    final result = await getUserChatUseCase();
    result.fold(
      (l) => Components.showSnackBar(l.message),
      (r) {
        userChat = r;
        ChatLocal().saveChat(r);
        print('yyyyyyyyyyyyyyyyyyyyyyyyy');
        print(ChatLocal().getChat());
      },
    );
  }

  FutureOr<void> addMessage(
    String senderId,
    String recieverId,
    Msg msg,
    RepliedMsg? repliedMsg,
  ) async {
        if (msg.type == 'image' || msg.type == 'video') {
      int random = Random().nextInt(1000);
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          msg.message,
          folder: "$random",
        ),
      );
      msg.message = res.secureUrl;
    }

    if (repliedMsg!.type == 'image' || repliedMsg.type == 'video') {
      int random = Random().nextInt(1000);

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          repliedMsg.repliedMessage,
          folder: "$random",
        ),
      );
      repliedMsg.repliedMessage = res.secureUrl;
    }
    final result = await addMessageUseCase(
      senderId,
      recieverId,
      msg.message,
      msg.type,
      repliedMsg.repliedMessage,
      repliedMsg.type,
      repliedMsg.repliedTo,
      repliedMsg.isMe,
    );
    result.fold(
      (l) => Components.showSnackBar(l.message),
      (r) => null,
    );
  }

    void addedMessage(dynamic data) async {
    print('jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');
    print(data);
    update();
  }

  void chatMessageSeen(String recieverId) async {
    final result = await chatMessageSeenUseCase(recieverId);
    result.fold(
      (l) => Components.showSnackBar(l.message),
      (r) => null,
    );
  }

  void messageNotification(String userId, String message) async {
    final result = await messageNotificationUseCase(userId, message);
    result.fold(
      (l) => Components.showSnackBar(l.message),
      (r) => null,
    );
  }
}
