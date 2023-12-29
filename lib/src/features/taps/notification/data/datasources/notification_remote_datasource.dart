import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../../core/enums/notification_enum.dart';
import '../models/notification_model.dart';

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../resources/local/user_local.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
  Future<Unit> pushNotification(
    String title,
    String body,
    NotificationEnum notificationType,
  );
  Future<Unit> notificationSeen(String notificationId);
}

class NotificationRemoteDataSourceImpl extends NotificationRemoteDataSource {
  final BaseRepository baseRepository;
  NotificationRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> notifications = [];

    diox.Response response = await baseRepository.getRoute(
      ApiGateway.getNotifications,
      params: UserLocal().getUserId(),
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        notifications =
            rawData.map((e) => NotificationModel.fromMap(e)).toList();
      },
    );

    return notifications;
  }

  @override
  Future<Unit> pushNotification(
    String title,
    String body,
    NotificationEnum notificationType,
  ) async {
    var bodys = {
      "userId": UserLocal().getUserId(),
      "title": title,
      "body": body,
      "notificationType": notificationType,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.pushNotification,
      bodys,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }

  @override
  Future<Unit> notificationSeen(String notificationId) async {
    diox.Response response = await baseRepository.postRoute(
      ApiGateway.notificationSeen,
      {
        'userId': UserLocal().getUserId(),
        'notificationId': notificationId,
      },
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
