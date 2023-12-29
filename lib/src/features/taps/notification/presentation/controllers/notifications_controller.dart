import 'dart:async';

import 'package:get/get.dart';

import '../../../../../core/enums/notification_enum.dart';
import '../../data/models/notification_model.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/notification_seen.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../screens/auth/data/models/auth_model.dart';
import '../../domain/usecases/push_notification.dart';

class NotificationController extends GetxController with HandleLoading {
  final GetNotificationsUseCase getNotificationsUseCase;
  final PushNotificationUseCase pushNotificationUseCase;
  final NotificationSeenUseCase notificationSeenUseCase;

  NotificationController(
    this.getNotificationsUseCase,
    this.pushNotificationUseCase,
    this.notificationSeenUseCase,
  );

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxInt notificationNotSeen = 0.obs;

    FutureOr<void> getNotofications() async {
    final result = await getNotificationsUseCase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        notifications.value = r;
        // for (var i = 0; i < notifications.length; i++) {
        //   if (notifications[i].isSeen == false) {
        //     notificationNotSeen += 1;
        //   }
        // }
      },
    );
    update();
  }

  void pushNotofication({
    required String title,
    required String body,
    required NotificationEnum notificationType,
  }) async {
    try {
      final result =
          await pushNotificationUseCase(title, body, notificationType);

      result.fold(
        (l) => handleLoading(l),
        (r) {},
      );
      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void isNotificationSeen(NotificationModel notification) async {
    if (notification.isSeen == false) {

      notification.isSeen = true;

      final result = await notificationSeenUseCase(notification.id??"");
      result.fold(
        (l) => handleLoading(l),
        (r) => null,
      );

      update();
    }
  }

  Future<List<AuthModel>> getUsersInfo(NotificationModel notification)async{
    List<AuthModel> users = [];
    for (var i = 0; i < notification.interactive.length; i++) {
      users.add(await AppGet.authGet.fetchInfoUserById(notification.interactive[i]));
    }
    update();
    return users;
  }

  @override
  void onInit() {
    getNotofications();
    super.onInit();
  }
}
