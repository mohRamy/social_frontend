import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/controller/app_controller.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../routes/app_pages.dart';
import 'profile_avatar.dart';

class WriteSomethingWidget extends StatelessWidget {
  const WriteSomethingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () => AppNavigator.push(AppRoutes.profile),
                  child: ProfileAvatar(
                    imageUrl: AppGet.authGet.userData!.photo,
                    hasBorder: false,
                  ),
                ),
                const SizedBox(width: 7.0),
                InkWell(
                  onTap: () => AppNavigator.push(AppRoutes.addPost),
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    // height: 20.sp,
                    width: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1.0, color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: AppText(
                      'what_do_you_think'.tr,
                      type: TextType.small,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.live_tv,
                      size: 20.0,
                      color: Colors.pink,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('live'.tr,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                ),
                SizedBox(
                    height: 20,
                    child: VerticalDivider(color: Colors.grey[600])),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.photo_library,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 5.0),
                    Text('photo'.tr,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                ),
                SizedBox(
                    height: 20,
                    child: VerticalDivider(color: Colors.grey[600])),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.video_call,
                      size: 20.0,
                      color: Colors.purple,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text('room'.tr,
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
