import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/chat_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatModel>> getUserChat();
  Future<Either<Failure, Unit>> addMessage(
    String idConversation,
    MessageModel message,
  );
  Future<Either<Failure, Unit>> isMessageSeen(String recieverId);
}
