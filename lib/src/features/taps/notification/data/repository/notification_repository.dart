import 'package:dartz/dartz.dart';
import '../datasources/notification_remote_datasource.dart';
import '../../domain/repository/base_notification_repository.dart';

import '../../../../../core/enums/notification_enum.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../models/notification_model.dart';

typedef GetMessage = Future<Unit> Function();

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource baseNotificationRemoteDataSource;
  final NetworkInfo networkInfo;
  NotificationRepositoryImpl(this.baseNotificationRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> pushNotificationCaseUser(String title, String body, NotificationEnum notificationType) async {
    return await _getMessage(() {
      return baseNotificationRemoteDataSource.pushNotification(title, body, notificationType);
    });
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotificationsCaseUser() async {
      if (await networkInfo.isConnected) {
      try {
        final result = await baseNotificationRemoteDataSource.getNotifications();
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> notificationSeenUseCase(String notificationId) async {
    return await _getMessage(() {
      return baseNotificationRemoteDataSource.notificationSeen(notificationId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return const Right(unit);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
