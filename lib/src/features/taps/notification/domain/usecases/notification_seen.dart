import 'package:dartz/dartz.dart';
import '../repository/base_notification_repository.dart';

import '../../../../../core/error/failures.dart';

class NotificationSeenUseCase {
  final NotificationRepository paseNotificationRepository;
  NotificationSeenUseCase(this.paseNotificationRepository);

  Future<Either<Failure, Unit>> call(String notificationId) async {
    return await paseNotificationRepository.notificationSeenUseCase(notificationId);
  }
}
