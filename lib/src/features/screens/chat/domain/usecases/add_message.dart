import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/chat_model.dart';
import '../repository/base_chat_repository.dart';

class AddMessageUseCase {
  final ChatRepository baseChatRepository;
  AddMessageUseCase(this.baseChatRepository);

  Future<Either<Failure, Unit>> call(
    String idConversation,
    MessageModel message,
  ) async {
    return await baseChatRepository.addMessage(
      idConversation,
      message,
    );
  }
}
