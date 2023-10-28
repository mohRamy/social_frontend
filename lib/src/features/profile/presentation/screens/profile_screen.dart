import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/app_text.dart';
import 'package:social_app/src/core/widgets/post_widget.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../controller/app_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';
import '../controller/profile_controller.dart';

import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../../core/widgets/hero_image.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import 'followers_screen.dart';
import 'following_screen.dart';
import 'setting_profile_page.dart';

import '../../../../core/widgets/widgets.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth userInfo = UserLocal().getUser()!;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Get.isDarkMode ? colorBlack : mC,
            expandedHeight: 170.sp,
            actions: [
              IconButton(
                onPressed: () {
                  AppNavigator.push(AppRoutes.settings);
                },
                icon: const Icon(
                  Icons.dashboard_customize_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.white,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: SizedBox(
                child: Stack(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Get.to(
                          HeroImage(
                            post: userInfo.backgroundImage,
                          ),
                        );
                      },
                      child: Container(
                        // height: 210,
                        width: Dimensions.screenWidth,
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(.7),
                        ),
                        child: userInfo.backgroundImage.isNotEmpty
                            ? Image.network(
                                userInfo.backgroundImage,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 22,
                      child: Container(
                        height: Dimensions.size20,
                        width: Dimensions.screenWidth,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode ? colorBlack : mC,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(Dimensions.size20),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: Dimensions.size30,
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                Get.to(
                                  HeroImage(
                                    post: userInfo.photo,
                                  ),
                                );
                              },
                              child: ProfileAvatar(
                                imageUrl: userInfo.photo,
                                sizeImage: 100,
                              ),
                            )),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: Dimensions.size10,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              AppNavigator.push(
                                AppRoutes.accountProfile,
                                arguments: {
                                  "userInfo": userInfo,
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.size10,
                                vertical: Dimensions.size5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size30),
                                border:
                                    Border.all(width: 0.4, color: Colors.grey),
                                color: mC,
                              ),
                              child: const AppText(
                                "Modify your profile",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                // _CoverAndProfile(
                //   userInfo: UserLocal().getUser()!,
                // ),
                const SizedBox(height: 10.0),
                _UsernameAndDescription(userData: userInfo),
                const SizedBox(height: 30.0),
                _PostAndFollow(
                  userData: userInfo,
                ),
              ],
            ),
          ),
        ],
      ),
      // body: ListView(
      //   children: [
      //     _CoverAndProfile(
      //       userInfo: UserLocal().getUser()!,
      //     ),
      //     const SizedBox(height: 10.0),
      //     _UsernameAndDescription(userData: UserLocal().getUser()!),
      //     const SizedBox(height: 30.0),
      //     _PostAndFollow(
      //       userData: UserLocal().getUser()!,
      //     ),
      //   ],
      // ),
    );
  }
}

class _ListUserPost extends StatelessWidget {
  final Auth userData;
  const _ListUserPost({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
      // return profileCtrl.userPostsById.isEmpty
      //     ? const CustomShimmer()
      //     : GridView.builder(
      //         itemCount: profileCtrl.userPostsById.length,
      //         physics: const NeverScrollableScrollPhysics(),
      //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 3,
      //           crossAxisSpacing: 2,
      //           mainAxisExtent: 170,
      //         ),
      //         // scrollDirection: Axis.vertical,
      //         shrinkWrap: true,
      //         itemBuilder: (context, i) {
      //           Post postData = profileCtrl.userPostsById[i];
      //           return InkWell(
      //               onTap: () {
      //                 AppNavigator.push(
      //                   AppRoutes.listPhotoProfile,
      //                   arguments: profileCtrl.userPostsById,
      //                 );
      //               },
      //               child: Stack(
      //                 children: [
      //                   InkWell(
      //                     onTap: () {
      //                       AppNavigator.push(
      //                         AppRoutes.listPhotoProfile,
      //                         arguments: profileCtrl.userPostsById,
      //                       );
      //                     },
      //                     child: DisplayImageVideoCard(
      //                       file: postData.posts[0].post,
      //                       type: postData.posts[0].type,
      //                       isOut: true,
      //                     ),
      //                   ),
      //                   postData.posts.length == 1
      //                       ? Container()
      //                       : Positioned(
      //                           top: Dimensions.size10,
      //                           right: Dimensions.size10,
      //                           child: const Icon(Icons.layers),
      //                         ),
      //                 ],
      //               ));
      //         });
  }
}

class _PostAndFollow extends StatelessWidget {
  final Auth userData;
  const _PostAndFollow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
        future: AppGet.profileGet.getUserPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Post> posts = snapshot.data!;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  width: Dimensions.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextCustom(
                            text: posts.length.toString(),
                            fontSize: 17,
                            color: Colors.grey,
                            letterSpacing: .7,
                          ),
                          TextCustom(
                            text: 'Posts',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<Auth> followers = [];
                          for (var i = 0; i < userData.followers.length; i++) {
                            followers.add(await AppGet.authGet
                                .fetchInfoUserById(userData.followers[i]));
                          }
                          Get.to(
                            const FollowersScreen(),
                            arguments: followers,
                          );
                        },
                        child: Row(
                          children: [
                            TextCustom(
                              text: userData.followers.length.toString(),
                              fontSize: 17,
                              color: Colors.grey,
                              letterSpacing: .7,
                            ),
                            TextCustom(
                                text: 'Followers',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<Auth> followings = [];
                          for (var i = 0; i < userData.following.length; i++) {
                            followings.add(await Get.find<AuthController>()
                                .fetchInfoUserById(userData.following[i]));
                          }
                          Get.to(const FollowingScreen(),
                              arguments: followings);
                        },
                        child: Row(
                          children: [
                            TextCustom(
                              text: userData.following.length.toString(),
                              fontSize: 17,
                              color: Colors.grey,
                              letterSpacing: .7,
                            ),
                            SizedBox(width: Dimensions.size5),
                            TextCustom(
                                text: 'Following',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.size30),
                ListView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (BuildContext context, int index) {
                final Post postData = posts[index];
                return PostWidget(postData: postData);
              },
            ),
                //PostWidget(posts: posts),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class _UsernameAndDescription extends StatelessWidget {
  final Auth userData;
  const _UsernameAndDescription({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.size10,
        top: Dimensions.size10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            text: userData.name,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

class _CoverAndProfile extends StatefulWidget {
  final Auth userInfo;
  const _CoverAndProfile({
    Key? key,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<_CoverAndProfile> createState() => _CoverAndProfileState();
}

class _CoverAndProfileState extends State<_CoverAndProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: Dimensions.screenWidth,
      child: Stack(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.to(
                HeroImage(
                  post: widget.userInfo.backgroundImage,
                ),
              );
            },
            child: Container(
              height: 170,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                color: colorPrimary.withOpacity(.7),
              ),
              child: widget.userInfo.backgroundImage.isNotEmpty
                  ? Image.network(
                      widget.userInfo.backgroundImage,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            bottom: 28,
            child: Container(
              height: Dimensions.size20,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? colorBlack : mC,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20.0))),
            ),
          ),
          Positioned(
            bottom: 0,
            left: Dimensions.size30,
            child: Container(
              alignment: Alignment.center,
              height: 100,
              // width: size.width,
              child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.to(
                        HeroImage(
                          post: widget.userInfo.photo,
                        ),
                      );
                    },
                    child: ProfileAvatar(
                      imageUrl: widget.userInfo.photo,
                      sizeImage: 100,
                    ),
                  )),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: Dimensions.size10,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    AppNavigator.push(
                      AppRoutes.accountProfile,
                      arguments: {
                        "userInfo": widget.userInfo,
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.size10,
                      vertical: Dimensions.size5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.size30),
                      border: Border.all(width: 0.4, color: Colors.grey),
                      color: mC,
                    ),
                    child: const AppText(
                      "Modify your profile",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0.0,
            child: IconButton(
              splashRadius: 20,
              onPressed: () => AppNavigator.pop,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black87,
              ),
            ),
          ),
          Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  Get.to(const SettingProfileScreen());
                },
                //onPressed: () => modalProfileSetting(context, size),
                icon: const Icon(Icons.dashboard_customize_outlined,
                    color: Colors.white),
              )),
          Positioned(
            right: 40,
            child: IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(
                Icons.add_box_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivateAccount extends StatelessWidget {
  const _PrivateAccount();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 100.sp),
        Icon(
          Icons.lock_outlined,
          size: Dimensions.size24,
        ),
        SizedBox(width: Dimensions.size10),
        TextCustom(
          text: 'this account is private',
          fontSize: Dimensions.size26,
        ),
      ],
    );
  }
}
