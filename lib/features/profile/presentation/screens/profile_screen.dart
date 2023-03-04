import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';
import '../controller/profile_controller.dart';

import '../../../auth/presentation/controller/auth_controller.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../../core/widgets/hero_image.dart';
import '../../../home/presentation/components/profile_avatar.dart';
import 'followers_screen.dart';
import 'following_screen.dart';
import 'setting_profile_page.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../auth/presentation/controller/user_controller.dart';
import '../../../../core/displaies/display_image_video_card.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Auth>(
          future: Get.find<AuthController>()
              .getUserData(Get.arguments ?? Get.find<UserController>().user.id),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const CustomShimmer()
                : ListView(
                    children: [
                      _CoverAndProfile(userData: snapshot.data!),
                      const SizedBox(height: 10.0),
                      _UsernameAndDescription(userData: snapshot.data!),
                      const SizedBox(height: 30.0),
                      (snapshot.data!.private &&
                              snapshot.data!.id !=
                                  Get.find<UserController>().user.id)
                          ? const _PrivateAccount()
                          : _PostAndFollow(userData: snapshot.data!)
                    ],
                  );
          }),
    );
  }
}

// class _ListFotosProfile extends StatelessWidget {
//   const _ListFotosProfile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<UserController>(builder: (userCtrl) {
//       var userData = userCtrl.user;
//       return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 2,
//           mainAxisSpacing: 2,
//           mainAxisExtent: 170,
//         ),
//         itemCount: 4,
//         itemBuilder: (context, i) {
//           return InkWell(
//             // onTap: () => Navigator.push(context,
//             //     routeSlide(page: const ListPhotosProfilePage())),
//             child: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(
//                     userData.photo,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }

class _ListUserPost extends StatelessWidget {
  final Auth userData;
  const _ListUserPost({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileCtrl) {
      return profileCtrl.userPosts.isEmpty
          ? const CustomShimmer()
          : GridView.builder(
              itemCount: profileCtrl.userPosts.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisExtent: 170,
              ),
              // scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                Post postData = profileCtrl.userPosts[i];
                return InkWell(
                    onTap: () {
                      Get.toNamed(
                        Routes.LIST_PHOTO_PROFILE,
                        arguments: profileCtrl.userPosts,
                      );
                    },
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.LIST_PHOTO_PROFILE,
                              arguments: profileCtrl.userPosts,
                            );
                          },
                          child: DisplayImageVideoCard(
                            file: postData.posts[0].post,
                            type: postData.posts[0].type,
                            isOut: true,
                          ),
                        ),
                        postData.posts.length == 1
                            ? Container()
                            : Positioned(
                                top: Dimensions.width10,
                                right: Dimensions.width10,
                                child: const Icon(Icons.layers),
                              ),
                      ],
                    ));
              });
    });
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
    final size = MediaQuery.of(context).size;
    return GetBuilder<ProfileController>(
      builder: (profileCtrl) {
        profileCtrl.getUserPost(userData.id);
      return profileCtrl.userPosts.isEmpty
          ? Container()
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          children: [
                            TextCustom(
                              text: 'Posts',
                              fontSize: Dimensions.font20 + 2,
                              fontWeight: FontWeight.w500,
                            ),
                            TextCustom(
                              text: profileCtrl.userPosts.length.toString(),
                              fontSize: 17,
                              color: Colors.grey,
                              letterSpacing: .7,
                            ),
                          ],
                        ),
                      
                      InkWell(
                        onTap: () async {
                          List<Auth> followers = [];
                          for (var i = 0;
                              i < userData.followers.length;
                              i++) {
                            followers.add(await Get.find<AuthController>()
                                .getUserData(userData.followers[i]));
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
                                fontSize: Dimensions.font20 + 2,
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
                          List<Auth> followings = [];
                          for (var i = 0;
                              i < userData.following.length;
                              i++) {
                            followings.add(await Get.find<AuthController>()
                                .getUserData(userData.following[i]));
                          }
                          Get.to(const FollowingScreen(),
                              arguments: followings);
                        },
                        child: Column(
                          children: [
                            TextCustom(
                                text: 'Following',
                                fontSize: Dimensions.font20 + 2,
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
                SizedBox(height: Dimensions.height15),
                Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: GridView.builder(
                      itemCount: profileCtrl.userPosts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisExtent: 170,
                      ),
                      // scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        Post postData = profileCtrl.userPosts[i];
                        return InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.LIST_PHOTO_PROFILE,
                                arguments: profileCtrl.userPosts,
                              );
                            },
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.LIST_PHOTO_PROFILE,
                                      arguments: profileCtrl.userPosts,
                                    );
                                  },
                                  child: DisplayImageVideoCard(
                                    file: postData.posts[0].post,
                                    type: postData.posts[0].type,
                                    isOut: true,
                                  ),
                                ),
                                postData.posts.length == 1
                                    ? Container()
                                    : Positioned(
                                        top: Dimensions.width10,
                                        right: Dimensions.width10,
                                        child: const Icon(Icons.layers),
                                      ),
                              ],
                            ));
                      }),
                ),
              ],
            );
    });
  }
}

class _UsernameAndDescription extends StatelessWidget {
  Auth userData;
  _UsernameAndDescription({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.width30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            text: userData.name,
            fontSize: 22,
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
  Auth userData;

  _CoverAndProfile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<_CoverAndProfile> createState() => _CoverAndProfileState();
}

class _CoverAndProfileState extends State<_CoverAndProfile> {
  bool private = false;
  @override
  Widget build(BuildContext context) {
    bool isMe = widget.userData.id == Get.find<UserController>().user.id;
    bool isFriend =
        Get.find<UserController>().user.following.contains(widget.userData.id);
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
                color: AppColors.primary.withOpacity(.7),
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
              height: Dimensions.height20,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? AppColors.bgDarkColor
                      : AppColors.bgLightColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20.0))),
            ),
          ),
          Positioned(
            bottom: 0,
            left: Dimensions.width30,
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
              right: Dimensions.width30,
              child: Row(
                children: [
                  isMe
                      ? Container()
                      : InkWell(
                          onTap: () {
                            Get.to(ChatScreen(
                              userId: widget.userData.id,
                              name: widget.userData.name,
                              photo: widget.userData.photo,
                              isGroupChat: false,
                            ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.height10 - 3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 0.4,
                                color: Colors.grey,
                              ),
                              color: context.theme.scaffoldBackgroundColor,
                            ),
                            child: SvgPicture.asset('assets/svg/chat-icon.svg',
                                height: Dimensions.iconSize24,
                                color: context.theme.dividerColor),
                          ),
                        ),
                  SizedBox(width: Dimensions.width15),
                  InkWell(
                    onTap: () {
                      if (isMe) {
                        Get.toNamed(Routes.ACCOUNT_PROFILE,
                            arguments: widget.userData);
                      } else {
                        setState(() {
                          private = !private;
                        });
                        profileCtrl.followUser(
                          widget.userData.id,
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height10,
                        vertical: Dimensions.height10 - 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        border: Border.all(width: 0.4, color: Colors.grey),
                        color: isMe
                            ? AppColors.bgLightColor
                            : (isFriend || private)
                                ? AppColors.bgLightColor
                                : Colors.black,
                      ),
                      child: Text(
                        isMe
                            ? "Modify your profile"
                            : (isFriend || private)
                                ? "followed"
                                : "Follow",
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : (isFriend || private)
                                  ? Colors.black
                                  : Colors.white,
                          fontSize: Dimensions.font20 - 2,
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
              onPressed: () => Get.back(),
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
                  Get.to(const SettingProfilePage());
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
  const _PrivateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Dimensions.height10 * 10),
        Icon(
          Icons.lock_outlined,
          size: Dimensions.iconSize24,
        ),
        SizedBox(width: Dimensions.width10),
        TextCustom(
          text: 'this account is private',
          fontSize: Dimensions.font26,
        ),
      ],
    );
  }
}
