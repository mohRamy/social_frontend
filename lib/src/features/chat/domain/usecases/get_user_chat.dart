import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat.dart';
import '../repository/base_chat_repository.dart';

class GetUserChatUseCase {
  final ChatRepository baseChatRepository;
  GetUserChatUseCase(this.baseChatRepository);

  Future<Either<Failure, Chat>> call() async {
    return await baseChatRepository.getUserChat();
  }
}
