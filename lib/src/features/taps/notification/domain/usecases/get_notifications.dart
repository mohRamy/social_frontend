import 'package:dartz/dartz.dart';
import '../repository/base_notification_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../data/models/notification_model.dart';

class GetNotificationsUseCase {
  final NotificationRepository paseNotificationRepository;
  GetNotificationsUseCase(this.paseNotificationRepository);

  Future<Either<Failure, List<NotificationModel>>> call() async {
    return await paseNotificationRepository.getNotificationsCaseUser();
  }
}
