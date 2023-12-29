import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../controller/app_controller.dart';
import '../../../../../core/enums/notification_enum.dart';
import '../../data/models/notification_model.dart';
import '../controllers/notifications_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';

import '../../../home/data/models/post_model.dart';
import '../components/notification_widget.dart';

class NotificationsTab extends GetView<NotificationController> {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (notificationCtrl) {
      // notificationCtrl.isNotificationSeen();
      return SingleChildScrollView(
        child: SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(Dimensions.size10),
              child: Text(
                'notifications'.tr,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? mCL : colorBlack,
                ),
              ),
            ),
            for (NotificationModel notification
                in AppGet.notificationGet.notifications.reversed)
              GetBuilder<NotificationController>(
                builder: (notificationCtrl) {
                  return InkWell(
                    onTap: () {
                      notificationCtrl.isNotificationSeen(notification);
                      if (notification.notificationType == NotificationEnum.post) {
                        late PostModel post;
                        for (var i = 0; i < AppGet.homeGet.posts.length; i++) {
                          if (AppGet.homeGet.posts[i].id == notification.typeId) {
                            post = AppGet.homeGet.posts[i];
                          }
                        }
                        AppNavigator.push(
                          AppRoutes.viewPost,
                          arguments: {
                            'post': post,
                          },
                        );
                      }
                    },
                    child: NotificationWidget(notification: notification)
                  );
                }
              )
          ],
        )),
      );
    });
  }
}
