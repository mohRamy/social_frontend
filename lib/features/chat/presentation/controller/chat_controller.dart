import 'package:get/get.dart';
import 'package:social_app/features/chat/domain/usecases/message_notification.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/chat_message_seen.dart';
import '../../domain/usecases/get_my_chat.dart';

import '../../../../core/utils/app_component.dart';

class ChatController extends GetxController with HandleErrorLoading {
  final GetMyChatUseCase getMyChatUseCase;
  final ChatMessageSeenUseCase chatMessageSeenUseCase;
  final MessageNotificationUseCase messageNotificationUseCase;

  ChatController({
    required this.getMyChatUseCase,
    required this.chatMessageSeenUseCase,
    required this.messageNotificationUseCase,
  });

  Chat myChat = const Chat(id: "", userId: "", contents: []);

  void getMyChat() async {
    final result = await getMyChatUseCase();
    result.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => myChat = r,
    );
  }

  void chatMessageSeen(String recieverId) async {
    final result = await chatMessageSeenUseCase(recieverId);
    result.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => null,
    );
  }

  void messageNotification(String userId, String message) async {
    final result = await messageNotificationUseCase(userId, message);
    result.fold(
      (l) => AppComponents.showCustomSnackBar(l.message),
      (r) => null,
    );
  }
}
