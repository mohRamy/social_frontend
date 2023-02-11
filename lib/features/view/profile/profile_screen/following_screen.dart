import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'package:social_app/features/view/profile/profile_ctrl/profile_ctrl.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../data/models/user_model.dart';

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
    List<String> usersId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Following', letterSpacing: .8, fontSize: 19),
        elevation: 0,
        leading: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            itemCount: usersId.length,
            itemBuilder: (context, i) {
              return FutureBuilder<UserModel>(
                  future: Get.find<AuthCtrl>().fetchUserData(usersId[i]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      UserModel userData = snapshot.data!;
                      bool isFriend = Get.find<UserCtrl>()
                          .user
                          .following
                          .contains(userData.id);
                      return InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                        splashColor: Colors.grey[300],
                        onTap: () =>
                            Get.toNamed(Routes.PROFILE, arguments: userData.id),
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
                                    backgroundImage:
                                        NetworkImage(userData.photo),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextCustom(
                                          text: userData.name, fontSize: 16),
                                      TextCustom(
                                          text: userData.email,
                                          color: Colors.grey,
                                          fontSize: 15)
                                    ],
                                  ),
                                ],
                              ),
                              GetBuilder<ProfileCtrl>(builder: (profileCtrl) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(50.0),
                                      splashColor: Colors.blue[50],
                                      onTap: () {
                                        setState(() {
                                          isfrend = !isfrend;
                                        });
                                        profileCtrl.followUser(userData.id);
                                      },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        side:
                                            BorderSide(color: Colors.grey[300]!),
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    color: (isFriend || isfrend)
                                        ? Colors.white
                                        : Colors.black,
                                    elevation: 0,
                                    child: (isFriend || isfrend)
                                          ? const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 17.0,
                                                  vertical: 6.0),
                                              child: TextCustom(
                                                text: 'followed',
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            )
                                          : const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 17.0,
                                                  vertical: 6.0),
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
                    }
                    return const CustomShimmer();
                  });
            }),
      ),
    );
  }
}
