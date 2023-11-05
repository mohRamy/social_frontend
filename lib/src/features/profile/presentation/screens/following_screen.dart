import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/app_controller.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../routes/app_pages.dart';
import '../../../auth/domain/entities/auth.dart';
import '../controller/profile_controller.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  bool isfrend = false;
  @override
  Widget build(BuildContext context) {
    List<Auth> followings = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const TextCustom(
              text: 'Following', letterSpacing: .8, fontSize: 19),
          elevation: 0,
          leading: IconButton(
              splashRadius: 20,
              onPressed: () => AppNavigator.pop,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              )),
        ),
        body: SafeArea(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: followings.length,
              itemBuilder: (context, index) {
                Auth userData = followings[index];
                bool isFriend =
                    AppGet.authGet.userData!.following.contains(userData.id);
                return InkWell(
                  borderRadius: BorderRadius.circular(10.0),
                  splashColor: Colors.grey[300],
                  onTap: () =>
                      AppNavigator.push(AppRoutes.profileById, arguments: {
                    "userId": userData.id,
                  }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.amber,
                              backgroundImage: NetworkImage(userData.photo),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustom(text: userData.name, fontSize: 16),
                                TextCustom(
                                    text: userData.email,
                                    color: Colors.grey,
                                    fontSize: 15)
                              ],
                            ),
                          ],
                        ),
                        GetBuilder<ProfileController>(builder: (profileCtrl) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(50.0),
                            splashColor: Colors.blue[50],
                            onTap: () {
                              setState(() {
                                isfrend = !isfrend;
                              });
                              profileCtrl.changeFollowingUser(userData.id);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(50.0)),
                              color: (isFriend || isfrend)
                                  ? Colors.white
                                  : Colors.black,
                              elevation: 0,
                              child: (isFriend || isfrend)
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 17.0, vertical: 6.0),
                                      child: TextCustom(
                                        text: 'followed',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    )
                                  : const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 17.0, vertical: 6.0),
                                      child: TextCustom(
                                        text: 'follow',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
