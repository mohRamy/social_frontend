import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';

import '../../../../utils/sizer_custom/sizer.dart';

import '../../../../controller/app_controller.dart';
import '../../../../core/widgets/hero_image.dart';
import '../../../../core/widgets/post_widget.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/app_colors.dart';
import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import '../controller/profile_controller.dart';
import 'followers_screen.dart';
import 'following_screen.dart';
import 'setting_profile_page.dart';

class ProfileByIdScreen extends GetView<ProfileController> {
  final String userId;
  const ProfileByIdScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: GetBuilder<AuthController>(builder: (authController) {
        return FutureBuilder<AuthModel>(
            future: authController.fetchInfoUserById(userId),
            builder: (context, snapshot) {
              AuthModel? userInfo = snapshot.data;
              if (snapshot.connectionState == ConnectionState.done) {
                AppGet.profileGet.isFriend =
                    userInfo!.followers.contains(AppGet.authGet.userData!.id);
                return ListView(
                  children: [
                    _CoverAndProfile(
                      userData: userInfo,
                    ),
                    const SizedBox(height: 10.0),
                    _UsernameAndDescription(userData: userInfo),
                    const SizedBox(height: 30.0),
                    (userInfo.private && userInfo.id != AppGet.authGet.userData!.id)
                        ? const _PrivateAccount()
                        : _PostAndFollow(
                            userData: userInfo,
                          ),
                  ],
                );
              } else {
                return Container();
              }
            });
      }),
    );
  }
}

class _PostAndFollow extends StatelessWidget {
  final AuthModel userData;
  const _PostAndFollow({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileCtrl) {
      return FutureBuilder<List<PostModel>>(
          future: profileCtrl.getUserPostsById(userData.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<PostModel> posts = snapshot.data!;
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    width: Dimensions.screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            TextCustom(
                              text: 'Posts',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            TextCustom(
                              text: posts.length.toString(),
                              fontSize: 17,
                              color: Colors.grey,
                              letterSpacing: .7,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            List<AuthModel> followers = [];
                            for (var i = 0;
                                i < userData.followers.length;
                                i++) {
                              followers.add(await AppGet.authGet
                                  .fetchInfoUserById(userData.followers[i]));
                            }
                            Get.to(
                              const FollowersScreen(),
                              arguments: followers,
                            );
                          },
                          child: Column(
                            children: [
                              TextCustom(
                                  text: 'Followers',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                text: userData.followers.length.toString(),
                                fontSize: 17,
                                color: Colors.grey,
                                letterSpacing: .7,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            List<AuthModel> followings = [];
                            for (var i = 0;
                                i < userData.following.length;
                                i++) {
                              followings.add(await Get.find<AuthController>()
                                  .fetchInfoUserById(userData.following[i]));
                            }
                            Get.to(const FollowingScreen(),
                                arguments: followings);
                          },
                          child: Column(
                            children: [
                              TextCustom(
                                  text: 'Following',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500),
                              TextCustom(
                                text: userData.following.length.toString(),
                                fontSize: 17,
                                color: Colors.grey,
                                letterSpacing: .7,
                              ),
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
                      final PostModel postData = posts[index];
                      return PostWidget(postData: postData);
                    },
                  ),
                ],
              );
            } else {
              return Container();
            }
          });
    });
  }
}

class _UsernameAndDescription extends StatelessWidget {
  final AuthModel userData;
  const _UsernameAndDescription({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.size30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            text: userData.name,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 5.0),
          TextCustom(
            text: (userData.bio.isNotEmpty ? userData.bio : userData.email),
            fontSize: 17,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _CoverAndProfile extends StatefulWidget {
  final AuthModel userData;
  const _CoverAndProfile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<_CoverAndProfile> createState() => _CoverAndProfileState();
}

class _CoverAndProfileState extends State<_CoverAndProfile> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
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
                    post: widget.userData.backgroundImage,
                  ),
                );
              },
              child: Container(
                height: 170,
                width: Dimensions.screenWidth,
                decoration: BoxDecoration(
                  color: colorPrimary.withOpacity(.7),
                ),
                child: widget.userData.backgroundImage.isNotEmpty
                    ? Image.network(
                        widget.userData.backgroundImage,
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
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20.0))),
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
                            post: widget.userData.photo,
                          ),
                        );
                      },
                      child: ProfileAvatar(
                        imageUrl: widget.userData.photo,
                        sizeImage: 100,
                      ),
                    )),
              ),
            ),
            GetBuilder<ProfileController>(builder: (profileCtrl) {
              return Positioned(
                bottom: 0.0,
                right: Dimensions.size10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AppNavigator.push(
                          AppRoutes.chat,
                          arguments: {
                            "userData": widget.userData,
                            "is-group-chat": false,
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(7.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 0.4,
                            color: Colors.grey,
                          ),
                          color: context.theme.scaffoldBackgroundColor,
                        ),
                        child: SvgPicture.asset(
                          'assets/svg/chat-icon.svg',
                          height: Dimensions.size15,
                          color: context.theme.dividerColor,
                        ),
                      ),
                    ),
                    SizedBox(width: Dimensions.size15),
                    GestureDetector(
                      onTap: () {
                        profileController.isFriend =
                            !profileController.isFriend;
                        profileCtrl.changeFollowingUser(
                          widget.userData.id,
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
                          border: Border.all(width: 0.4, color: Colors.grey),
                          color: profileController.isFriend ? mC : colorBlack,
                        ),
                        child: Text(
                          profileController.isFriend ? "followed" : "Follow",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: profileController.isFriend
                                        ? colorBlack
                                        : mC,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
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
    });
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
