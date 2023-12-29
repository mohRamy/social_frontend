import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../helper/date_time_helper.dart';
import '../../data/models/notification_model.dart';
import '../controllers/notifications_controller.dart';
import '../../../../../themes/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (notificationCtrl) {
        return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.size10),
                  color: notification.isSeen ? Colors.transparent : mCH,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(usersInfo.last.photo),
                          //   radius: 35.0,
                          // ),
                          SizedBox(width: Dimensions.size10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 300,
                                child: AppText(
                                      notification.notification.body
                                    ),
                              ),
                              Text(
                                timeAgoCustom(notification.createdAt),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: fCL,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.more_horiz),
                          Text(''),
                        ],
                      )
                    ],
                  ),
                );
      }
    );
  }
}
