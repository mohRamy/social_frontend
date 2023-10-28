import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, Chat>> getUserChat();
  Future<Either<Failure, Unit>> addMessage(
    String senderId,
    String recieverId,
    String message,
    String type,
    String repliedMessage,
    String repliedType,
    String repliedTo,
    bool repliedIsMe,
  );
  Future<Either<Failure, Unit>> chatMessageSeen(String recieverId);
  Future<Either<Failure, Unit>> messageNotification(
      String userId, String message);
}
