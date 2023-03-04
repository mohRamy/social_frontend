import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> getMyChat();
  Future<Either<Failure, Unit>> chatMessageSeen(String recieverId);
  Future<Either<Failure, Unit>> messageNotification(String userId, String message);
}
