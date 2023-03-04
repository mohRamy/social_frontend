import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat.dart';
import '../repository/base_chat_repository.dart';

class GetMyChatUseCase {
  final ChatRepository baseChatRepository;
  GetMyChatUseCase(this.baseChatRepository);

  Future<Either<Failure, Chat>> call() async {
    return await baseChatRepository.getMyChat();
  }
}
