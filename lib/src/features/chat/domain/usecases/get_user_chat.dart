import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/chat_model.dart';
import '../repository/base_chat_repository.dart';

class GetUserChatUseCase {
  final ChatRepository baseChatRepository;
  GetUserChatUseCase(this.baseChatRepository);

  Future<Either<Failure, ChatModel>> call() async {
    return await baseChatRepository.getUserChat();
  }
}
