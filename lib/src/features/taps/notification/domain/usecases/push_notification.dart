import 'package:dartz/dartz.dart';
import '../../../../../core/enums/notification_enum.dart';
import '../repository/base_notification_repository.dart';

import '../../../../../core/error/failures.dart';

class PushNotificationUseCase {
  final NotificationRepository paseNotificationRepository;
  PushNotificationUseCase(this.paseNotificationRepository);

  Future<Either<Failure, Unit>> call(
    String title,
    String body,
    NotificationEnum notificationType,
  ) async {
    return await paseNotificationRepository.pushNotificationCaseUser(title, body, notificationType);
  }
}
