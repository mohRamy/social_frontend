import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/features/view/auth/auth_ctrl/auth_ctrl.dart';
import 'package:social_app/features/view/profile/profile_screen/followers_page.dart';
import 'package:social_app/features/view/profile/profile_screen/following_page.dart';
import '../../../../config/routes/app_pages.dart';
import '../../../data/models/user_model.dart';

import '../../../../controller/user_ctrl.dart';
import '../../../../core/picker/picker.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/custom_bottom_sheet.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../data/models/post_model.dart';
import '../../chat/screens/chat_screen.dart';
import '../profile_ctrl/profile_ctrl.dart';
import '../profile_widgets/display_text_image_video.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProfileCtrl>().myPost = [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<UserModel>(
        future: Get.find<AuthCtrl>().fetchUserData(Get.arguments??Get.find<UserCtrl>().user.id),
        builder: (context, snapshot) {
          return !snapshot.hasData
          ? const CustomShimmer()
          : ListView(
            children: [
              _CoverAndProfile(userData: snapshot.data!),
              const SizedBox(height: 10.0),
              _UsernameAndDescription(userData: snapshot.data!),
              const SizedBox(height: 30.0),
              const _PostAndFollowingAndFollowers(),
              const SizedBox(height: 30.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child:
                    //  const _ListFotosProfile()
                    _ListSaveProfile(),
              ),
            ],
          );
        }
      ),
    );
  }
}

class _ListFotosProfile extends StatelessWidget {
  const _ListFotosProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCtrl>(builder: (userCtrl) {
      var userData = userCtrl.user;
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          mainAxisExtent: 170,
        ),
        itemCount: 4,
        itemBuilder: (context, i) {
          return InkWell(
            // onTap: () => Navigator.push(context,
            //     routeSlide(page: const ListPhotosProfilePage())),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    userData.photo,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

class _ListSaveProfile extends StatelessWidget {
  const _ListSaveProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCtrl>(builder: (profileCtrl) {
      return GridView.builder(
          itemCount: profileCtrl.myPost.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 2, mainAxisExtent: 170),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            PostModel postData = profileCtrl.myPost[i];
            return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.LIST_PHOTO_PROFILE,
                    arguments: profileCtrl.myPost,
                  );
                },
                child: postData.posts!.length == 1
                    ? ProfileTextImageVideoPost(
                        post: postData.posts![0].post!,
                        type: postData.posts![0].type!,
                      )
                    : Stack(
                        children: [
                          InkWell(
                            child: ProfileTextImageVideoPost(
                              post: postData.posts![0].post!,
                              type: postData.posts![0].type!,
                            ),
                          ),
                          Positioned(
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

class _PostAndFollowingAndFollowers extends StatelessWidget {
  const _PostAndFollowingAndFollowers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<UserCtrl>(builder: (userCtrl) {
      var userData = userCtrl.user;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        width: size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<ProfileCtrl>(builder: (profileCtrl) {
                  return Column(
                    children: [
                      TextCustom(
                        text: 'Posts',
                        fontSize: Dimensions.font20 + 2,
                        fontWeight: FontWeight.w500,
                      ),
                      TextCustom(
                        text: profileCtrl.myPost.length.toString(),
                        fontSize: 17,
                        color: Colors.grey,
                        letterSpacing: .7,
                      ),
                    ],
                  );
                }),
                InkWell(
                  onTap: ()async{
                    List<UserModel> usersData = [];
                    for (var i = 0; i < userCtrl.user.followers.length; i++) {
                      usersData.add(await Get.find<AuthCtrl>().fetchUserData(userCtrl.user.followers[i]));
                    }
                    Get.to(const FollowersPage(), arguments: usersData);
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
                  onTap: ()async{
                    List<UserModel> usersData = [];
                    for (var i = 0; i < userCtrl.user.following.length; i++) {
                      usersData.add(await Get.find<AuthCtrl>().fetchUserData(userCtrl.user.following[i]));
                    }
                    Get.to(const FollowingPage(), arguments: usersData);
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
          ],
        ),
      );
    });
  }
}

class _UsernameAndDescription extends StatelessWidget {
  UserModel userData;
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
  UserModel userData;

  _CoverAndProfile({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<_CoverAndProfile> createState() => _CoverAndProfileState();
}

class _CoverAndProfileState extends State<_CoverAndProfile> {
  @override
  void initState() {
    Get.find<ProfileCtrl>().fetchMyPost(widget.userData.id);
    super.initState();
  }

  File? image;

  void pickImageGallery() async {
    image = await pickImageFromGallery();
    Get.find<ProfileCtrl>().modifyBGImage(image);
    Get.back();
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera();
    Get.find<ProfileCtrl>().modifyBGImage(image);
    Get.back();
    setState(() {});
  }

  File? imageP;

  void pickImageGalleryP() async {
    imageP = await pickImageFromGallery();
    Get.find<ProfileCtrl>().modifyBGImage(image);
    Get.back();
    setState(() {});
  }

  void pickImageCameraP() async {
    imageP = await pickImageFromCamera();
    Get.find<ProfileCtrl>().modifyBGImage(image);
    Get.back();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isMy = widget.userData.id == Get.find<UserCtrl>().user.id;

    return SizedBox(
      height: 200,
      width: Dimensions.screenWidth,
      child: Stack(
        children: [
          Container(
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
                : image != null
                    ? Image.file(
                        image!,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
                        fit: BoxFit.cover,
                      ),
          ),
          Positioned(
            bottom: 28,
            child: Container(
              height: Dimensions.height20,
              width: Dimensions.screenWidth,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0))),
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
                      bottomSheet(
                        pickImageCameraP,
                        pickImageGalleryP,
                      );
                    },

                    // onTap: () => modalSelectPicture(
                    //   context: context,
                    //   title: 'Actualizar image de perfil',
                    //   onPressedImage: () async {

                    //     Navigator.pop(context);
                    //     AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.storage.request(), context, ImageSource.gallery);
                    //   },
                    //   onPressedPhoto: () async {

                    //     Navigator.pop(context);
                    //     AppPermission().permissionAccessGalleryOrCameraForProfile(await Permission.camera.request(), context, ImageSource.camera);
                    //   }
                    // ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.userData.photo,
                      ),
                    ),
                  )),
            ),
          ),
          GetBuilder<ProfileCtrl>(builder: (profileCtrl) {
            return Positioned(
              bottom: 0.0,
              right: Dimensions.width30,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (isMy) {
                        Get.toNamed(Routes.NAV_USER_SCREEN);
                      } else {
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
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        border: Border.all(
                          width: 0.4,
                          color: isMy ? Colors.grey : Colors.transparent,
                        ),
                        color: isMy ? Colors.transparent : Colors.black,
                      ),
                      child: Text(
                        isMy ? "Modify your profile" : "Follow",
                        style: TextStyle(
                          color: isMy ? Colors.black : Colors.white,
                          fontSize: Dimensions.font20 - 2,
                        ),
                      ),
                    ),
                  ),
                  isMy?
                  Container():
                  InkWell(
                    onTap: () {
                      Get.to(
                        ChatScreen(
                        isGroupChat: false,
                        name: widget.userData.name,
                        uid: widget.userData.id,
                        profilePic: widget.userData.photo,
                      )
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.height10,
                        vertical: Dimensions.height10 - 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        border: Border.all(
                          width: 0.4,
                          color: isMy ? Colors.grey : Colors.transparent,
                        ),
                        color: isMy ? Colors.transparent : Colors.black,
                      ),
                      child: Text(
                      "Message",
                        style: TextStyle(
                          color: isMy ? Colors.black : Colors.white,
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
                onPressed: () {},
                // onPressed: () => modalProfileSetting(context, size),
                icon: const Icon(Icons.dashboard_customize_outlined,
                    color: Colors.white),
              )),
          Positioned(
            right: 40,
            child: IconButton(
              splashRadius: 20,
              onPressed: () {
                bottomSheet(
                  pickImageCamera,
                  pickImageGallery,
                );
              },
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
