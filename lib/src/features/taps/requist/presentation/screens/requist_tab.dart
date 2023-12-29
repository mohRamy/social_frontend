import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/features/taps/requist/presentation/controllers/requist_controller.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../themes/app_colors.dart';

import '../../../../screens/auth/data/models/auth_model.dart';

class RequistTab extends GetView<RequistController> {
  const RequistTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.size10,
        vertical: Dimensions.size10,
      ),
      children: [
        Text(
          'Friends',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? mCL : colorBlack,
          ),
        ),
        SizedBox(height: Dimensions.size10),
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text(
                'Suggestions',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? mCL : colorBlack,
                ),
              ),
            ),
            SizedBox(width: Dimensions.size5),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text(
                'All Friends',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Get.isDarkMode ? mCL : colorBlack,
                ),
              ),
            )
          ],
        ),
        const Divider(height: 30.0),
        Row(
          children: <Widget>[
            Text(
              'Friend Requests',
              style: TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? mCL : colorBlack,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              UserLocal().getUser()?.friendRequests.length.toString() ?? "0",
              style: const TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.size10),
        GetBuilder<RequistController>(builder: (requistCtrl) {
          return ListView.builder(
            itemCount: requistCtrl.friendsInfo.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              AuthModel friendInfo = requistCtrl.friendsInfo[index];
              return Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(friendInfo.photo),
                    radius: 40.0,
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppText(friendInfo.name),
                      const SizedBox(height: 15.0),
                      GetBuilder<RequistController>(builder: (requistCtrl) {
                        return !requistCtrl.isFriend
                            ? Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      requistCtrl.changeUserCase(
                                        friendInfo.id,
                                        false,
                                        index,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 35.0,
                                        vertical: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: const Text('Confirm',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  GestureDetector(
                                    onTap: () {
                                      requistCtrl.changeUserCase(
                                        friendInfo.id,
                                        true,
                                        index,
                                      );
                                      UserLocal()
                                          .getUser()
                                          ?.friendRequests
                                          .remove(friendInfo.id);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 35.0, vertical: 10.0),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: const Text('Delete',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0)),
                                    ),
                                  ),
                                ],
                              )
                            : const AppText(
                                'You tow are friends now',
                                type: TextType.small,
                              );
                      })
                    ],
                  )
                ],
              );
            },
          );
        })
      ],
    );
  }
}
