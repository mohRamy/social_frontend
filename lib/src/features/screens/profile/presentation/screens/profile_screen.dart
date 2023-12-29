import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/core/widgets/hero_image.dart';
import 'package:social_app/src/public/components.dart';
import 'package:social_app/src/themes/font_family.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/separator_widget.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';

import '../../../../../controller/app_controller.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../../../../../core/widgets/post_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel userInfo = AppGet.authGet.userData!;
    const double coverHeight = 280;
    const double profileHeight = 144;

    buildBottomsheet(ProfileController profileCtrl, bool isPhoto) =>
        Get.bottomSheet(
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Dimensions.size15),
                ),
                color: Get.isDarkMode ? colorBlack : mCL,
              ),
              padding: const EdgeInsetsDirectional.only(
                top: 4,
              ),
              width: Dimensions.screenWidth,
              height: 170.sp,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      height: 6,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.size20,
                        ),
                        color: Get.isDarkMode
                            ? Colors.grey[600]
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.size10),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.person_2_sharp,
                      color: colorBlack,
                    ),
                    label: "Show Profile Image",
                    ontap: () => Get.to(
                      HeroImage(
                        image:
                            isPhoto ? userInfo.photo : userInfo.backgroundImage,
                      ),
                    ),
                  ),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.camera_alt,
                      color: colorBlack,
                    ),
                    label: "Select Image From camera",
                    ontap: () => profileCtrl.selectImageFromCamera(isPhoto),
                  ),
                  Components.buildbottomsheet(
                    icon: Icon(
                      Icons.photo_library,
                      color: colorBlack,
                    ),
                    label: "Select Image From Gallery",
                    ontap: () => profileCtrl.selectImageFromGallery(isPhoto),
                  ),
                ],
              ),
            ),
          ),
          elevation: 0.4,
        );

    Widget buildCoverImage() =>
        GetBuilder<ProfileController>(builder: (profileCtrl) {
          return GestureDetector(
            onTap: () => buildBottomsheet(profileCtrl, false),
            child: Container(
              color: fCL,
              child: profileCtrl.backgroundImageFile != null
                  ? Image.file(
                      profileCtrl.backgroundImageFile!,
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    )
                  : userInfo.backgroundImage.isNotEmpty
                  ? Image.network(
                      userInfo.backgroundImage,
                      width: double.infinity,
                      height: coverHeight,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: mCH,
                      height: coverHeight,
                  ),
            ),
          );
        });

    Widget buildProfileImage() =>
        GetBuilder<ProfileController>(builder: (profileCtrl) {
          return GestureDetector(
            onTap: () => buildBottomsheet(profileCtrl, true),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundColor: mCL,
                  child: profileCtrl.photoFile != null
                      ? CircleAvatar(
                          radius: profileHeight / 2.1,
                          backgroundColor: fCD,
                          backgroundImage: FileImage(
                            profileCtrl.photoFile!,
                          ),
                        )
                      : CircleAvatar(
                          radius: profileHeight / 2.1,
                          backgroundColor: fCD,
                          backgroundImage: NetworkImage(
                            userInfo.photo,
                          ),
                        ),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: mCL,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: mCH,
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
              ],
            ),
          );
        });

    Widget buildTop() {
      const bottom = profileHeight / 2;
      const top = coverHeight - profileHeight / 2;
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(),
          ),
          Positioned(
            top: top,
            child: buildProfileImage(),
          ),
        ],
      );
    }

    Widget buildContent() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.size15,
                horizontal: Dimensions.size10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(userInfo.name),
                  userInfo.friends.isNotEmpty
                      ? AppText("${userInfo.friends.length} ${"friends".tr}")
                      : const SizedBox(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => AppNavigator.push(AppRoutes.addStory),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Center(
                      child: Text(
                        'add_to_story'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: mCL),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimensions.size10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                InkWell(
                  onTap: () => AppNavigator.push(AppRoutes.updateInfo),
                  child: Container(
                    height: 40.0,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      color: mCH,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: AppText('update_profile'.tr),
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  width: 45.0,
                  decoration: BoxDecoration(
                      color: mCH, borderRadius: BorderRadius.circular(5.0)),
                  child: const Icon(Icons.more_horiz),
                )
              ],
            ),
            const Divider(height: 40.0),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.size10,
              ),
              child: Column(
                children: <Widget>[
                  userInfo.address.isNotEmpty
                      ? Row(
                          children: <Widget>[
                            const Icon(Icons.home,
                                color: Colors.grey, size: 30.0),
                            const SizedBox(width: 10.0),
                            AppText(
                              '${'lives_in'.tr} ${userInfo.address}',
                              type: TextType.medium,
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.location_on,
                          color: Colors.grey, size: 30.0),
                      const SizedBox(width: 10.0),
                      AppText(
                        '${"from".tr} ${userInfo.address}',
                        type: TextType.medium,
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Icon(Icons.more_horiz, color: fCL, size: 30.0),
                      const SizedBox(width: 10.0),
                      AppText(
                        'see_about_info'.tr,
                        type: TextType.medium,
                      )
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: () => AppNavigator.push(AppRoutes.updateInfo),
                    child: Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          'edit_public_details'.tr,
                          style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              fontFamily: FontFamily.lato),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 40.0),
            userInfo.friends.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.size10,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Friends'.tr,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Get.isDarkMode ? mCL : colorBlack,
                                    )),
                                const SizedBox(height: 6.0),
                                Text(
                                    '${userInfo.friends.length} ${"friends".tr}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[800])),
                              ],
                            ),
                            Text(
                              'find_friends'.tr,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: colorPrimary,
                                fontFamily: FontFamily.lato,
                              ),
                            ),
                          ],
                        ),
                        GridView.builder(
                            itemCount: userInfo.friends.length < 6
                                ? userInfo.friends.length
                                : 6,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1.8 / 2,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return FutureBuilder<AuthModel>(
                                future: AppGet.authGet
                                    .fetchInfoUserById(userInfo.friends[i]),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    AuthModel friendInfo = snapshot.data ??
                                        const AuthModel(
                                            id: "",
                                            name: "",
                                            email: "",
                                            bio: "",
                                            friendRequests: [],
                                            friends: [],
                                            photo: "",
                                            backgroundImage: "",
                                            phone: "",
                                            password: "",
                                            address: "",
                                            type: "",
                                            private: false,
                                            isOnline: true,
                                            token: "",
                                            fcmToken: "");
                                    return snapshot.hasData
                                        ? GestureDetector(
                                            onTap: () {
                                              AppNavigator.push(
                                                  AppRoutes.anotherProfile,
                                                  arguments: {
                                                    'user-id': friendInfo.id,
                                                  });
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: CachedNetworkImage(
                                                    imageUrl: friendInfo.photo,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                const SizedBox(height: 5.0),
                                                Text(friendInfo.name,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Get.isDarkMode
                                                          ? mCL
                                                          : colorBlack,
                                                    ))
                                              ],
                                            ),
                                          )
                                        : Container();
                                  }
                                  return Container();
                                },
                              );
                            }),
                        GestureDetector(
                          onTap: () {
                            AppNavigator.push(AppRoutes.friends, arguments: {
                              'friends': userInfo.friends,
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10.sp),
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Text(
                                'see_all_friends'.tr,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  fontFamily: FontFamily.lato,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            FutureBuilder<List<PostModel>>(
              future: controller.getUserPosts(),
              builder: (context, snapshot) {
                List<PostModel> posts = snapshot.data ?? [];
                return snapshot.hasData
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              const SeparatorWidget(),
                              PostWidget(
                                postData: posts[index],
                                index: 0,
                              ),
                            ],
                          );
                        },
                      )
                    : Container();
              },
            ),
            const SeparatorWidget()
          ],
        );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }
}
