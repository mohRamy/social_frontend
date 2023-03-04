import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_chat_repository.dart';

class ChatMessageSeenUseCase {
  final BaseChatRepository baseChatRepository;
  ChatMessageSeenUseCase(this.baseChatRepository);

  Future<Either<Failure, Unit>> call(String recieverId) async {
    return await baseChatRepository.chatMessageSeen(recieverId);
  }
}