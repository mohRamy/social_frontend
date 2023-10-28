import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repository/base_chat_repository.dart';

class AddMessageUseCase {
  final ChatRepository baseChatRepository;
  AddMessageUseCase(this.baseChatRepository);

  Future<Either<Failure, Unit>> call(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
  ) async {
    return await baseChatRepository.addMessage(
      senderId,
      recieverId,
      message,
      type,
      repliedMessage,
      repliedType,
      repliedTo,
      repliedIsMe,
    );
  }
}
