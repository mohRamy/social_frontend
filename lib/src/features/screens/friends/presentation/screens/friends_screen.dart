import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/widgets/app_text.dart';
import '../controllers/friends_controller.dart';
import '../../../../../resources/local/user_local.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../../auth/data/models/auth_model.dart';

class FriendsScreen extends GetView<FriendsController> {
  final List<String> friendsId;
  const FriendsScreen({
    Key? key,
    required this.friendsId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const AppText('Friends'),
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: friendsId.length,
              itemBuilder: (context, index) {
                return FutureBuilder<AuthModel>(
                  future: controller.friendInfo(friendsId[index]),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      AuthModel userData = snapshot.data;
                      return snapshot.hasData
                          ? InkWell(
                              borderRadius: BorderRadius.circular(10.0),
                              splashColor: Colors.grey[300],
                              onTap: () => AppNavigator.push(
                                  AppRoutes.anotherProfile,
                                  arguments: {
                                    "user-id": userData.id,
                                  }),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0)),
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: colorPrimary,
                                          backgroundImage:
                                              NetworkImage(userData.photo),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextCustom(
                                                text: userData.name,
                                                fontSize: 16),
                                            TextCustom(
                                              text: userData.email,
                                              color: Colors.grey,
                                              fontSize: 15,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    GetBuilder<FriendsController>(
                                        builder: (friendsCtrl) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey[300]!),
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        color: Colors.white,
                                        elevation: 0,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          splashColor: Colors.blue[50],
                                          onTap: () {
                                            friendsId.removeAt(index);
                                            UserLocal().getUser()!.friends.removeAt(index);
                                            friendsCtrl.removeFriend(
                                              userData.id,
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 17.0,
                                              vertical: 6.0,
                                            ),
                                            child: AppText(
                                              'friend',
                                              type: TextType.medium,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            )
                          : const CustomShimmer();
                    }
                    return const CustomShimmer();
                  },
                );
              }),
        ));
  }
}
