import 'package:dartz/dartz.dart';

import '../../../../../core/enums/notification_enum.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationRepository {
  Future<Either<Failure, Unit>> pushNotificationCaseUser(
    String title,
    String body,
    NotificationEnum notificationType,
  );
  Future<Either<Failure, List<NotificationModel>>> getNotificationsCaseUser();
  Future<Either<Failure, Unit>> notificationSeenUseCase(String notificationId);
}
