// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../core/enums/friend_enum.dart';
// import '../../../../../resources/local/user_local.dart';
// import '../controllers/another_profile_controller.dart';

// import '../../../../../routes/app_pages.dart';
// import '../../../../../utils/sizer_custom/sizer.dart';

// import '../../../../../core/widgets/app_text.dart';
// import '../../../../../core/widgets/separator_widget.dart';
// import '../../../../../themes/app_colors.dart';
// import '../../../auth/data/models/auth_model.dart';
// import '../../../../taps/home/data/models/post_model.dart';
// import '../../../../../core/widgets/post_widget.dart';

// class AnotherProfileScreen extends GetView<AnotherProfileController> {
//   final String userId;
//   const AnotherProfileScreen({
//     super.key,
//     required this.userId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder<AuthModel>(
//         future: controller.userInfo(userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             AuthModel? userInfo = snapshot.data;
//             controller.userEnim(userInfo);
//             String friendSwitch(UserCaseEnum friendEnum) {
//               switch (friendEnum) {
//                 case UserCaseEnum.notrequestAndFriend:
//                   return 'Add a friend';
//                 case UserCaseEnum.userRequest:
//                   return 'Delete Requist';
//                 case UserCaseEnum.myRequest:
//                   return 'Confirm';
//                 case UserCaseEnum.friend:
//                   return 'Friend';
//                 default:
//                   return 'Add a friend';
//               }
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 270.0,
//                     child: Stack(
//                       children: <Widget>[
//                         Container(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 15.0, vertical: 15.0),
//                           height: 180.0,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: NetworkImage(
//                                     userInfo!.backgroundImage,
//                                   ),
//                                   fit: BoxFit.cover),
//                               borderRadius: BorderRadius.circular(10.0)),
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: <Widget>[
//                             CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                 userInfo.photo,
//                               ),
//                               radius: 70.0,
//                             ),
//                             SizedBox(height: Dimensions.size20),
//                             Text(userInfo.name,
//                                 style: const TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black)),
//                             SizedBox(height: Dimensions.size20),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 15.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: <Widget>[
//                                   Expanded(
//                                     flex: 1,
//                                     child: GetBuilder<AnotherProfileController>(
//                                         builder: (anotherProfileCtrl) {
//                                       return InkWell(
//                                         onTap: () {
//                                           anotherProfileCtrl.changeUserCase(
//                                             userId,
//                                             false,
//                                           );
//                                         },
//                                         child: Container(
//                                           height: 40.0,
//                                           decoration: BoxDecoration(
//                                               color: anotherProfileCtrl
//                                                           .userEnum ==
//                                                       UserCaseEnum
//                                                           .notrequestAndFriend
//                                                   ? colorPrimary
//                                                   : mCH,
//                                               borderRadius:
//                                                   BorderRadius.circular(5.0)),
//                                           child: Center(
//                                             child: Text(
//                                               friendSwitch(
//                                                 anotherProfileCtrl.userEnum,
//                                               ),
//                                               style: TextStyle(
//                                                 color: anotherProfileCtrl
//                                                             .userEnum ==
//                                                         UserCaseEnum
//                                                             .notrequestAndFriend
//                                                     ? mCL
//                                                     : colorBlack,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16.0,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                   SizedBox(width: Dimensions.size5),
//                                   GetBuilder<AnotherProfileController>(
//                                       builder: (anotherProfileCtrl) {
//                                     return anotherProfileCtrl.userEnum ==
//                                             UserCaseEnum.myRequest
//                                         ? Expanded(
//                                             flex: 1,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 anotherProfileCtrl
//                                                     .changeUserCase(
//                                                   userId,
//                                                   true,
//                                                 );
//                                               },
//                                               child: Container(
//                                                 height: 40.0,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.red,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5.0)),
//                                                 child: const Center(
//                                                   child: Text(
//                                                     'Delete',
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 16.0,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox();
//                                   }),
//                                   SizedBox(width: Dimensions.size5),
//                                   Expanded(
//                                     flex: 1,
//                                     child: InkWell(
//                                       onTap: () {
//                                         AppNavigator.push(
//                                           AppRoutes.chat,
//                                           arguments: {
//                                             'user-data': userInfo,
//                                             'is-group-chat': false,
//                                           },
//                                         );
//                                       },
//                                       child: Container(
//                                         height: 40.0,
//                                         decoration: BoxDecoration(
//                                             color: colorPrimary,
//                                             borderRadius:
//                                                 BorderRadius.circular(5.0)),
//                                         child: const Center(
//                                           child: Text(
//                                             'Messaging',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16.0,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: Dimensions.size5),
//                                   Container(
//                                     height: 40.0,
//                                     width: 45.0,
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey[300],
//                                         borderRadius:
//                                             BorderRadius.circular(5.0)),
//                                     child: const Icon(Icons.more_horiz),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
//                     child: Divider(height: Dimensions.size30),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.home,
//                               color: Colors.grey,
//                               size: Dimensions.size24,
//                             ),
//                             SizedBox(width: Dimensions.size10),
//                             const AppText(
//                               'Lives in New York',
//                               type: TextType.medium,
//                             )
//                           ],
//                         ),
//                         SizedBox(height: Dimensions.size10),
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.location_on,
//                               color: Colors.grey,
//                               size: Dimensions.size24,
//                             ),
//                             SizedBox(width: Dimensions.size10),
//                             AppText(
//                               'From ${userInfo.address}',
//                               type: TextType.medium,
//                             )
//                           ],
//                         ),
//                         SizedBox(height: Dimensions.size10),
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.more_horiz,
//                               color: Colors.grey,
//                               size: Dimensions.size24,
//                             ),
//                             SizedBox(width: Dimensions.size10),
//                             AppText(
//                               'View info for ${userInfo.name}',
//                               type: TextType.medium,
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Divider(height: Dimensions.size30),
//                   userInfo.friends.isNotEmpty
//                       ? Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                           child: Column(
//                             children: <Widget>[
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Text('Friends',
//                                           style: TextStyle(
//                                             fontSize: 22.0,
//                                             fontWeight: FontWeight.bold,
//                                             color: Get.isDarkMode
//                                                 ? mCL
//                                                 : colorBlack,
//                                           )),
//                                       const SizedBox(height: 6.0),
//                                       Text('${userInfo.friends.length} friends',
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               color: Colors.grey[800])),
//                                     ],
//                                   ),
//                                   const Text('Find Friends',
//                                       style: TextStyle(
//                                           fontSize: 16.0, color: Colors.blue)),
//                                 ],
//                               ),
//                               GridView.builder(
//                                   itemCount: userInfo.friends.length < 6
//                                       ? userInfo.friends.length
//                                       : 6,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 3,
//                                     crossAxisSpacing: 5,
//                                     mainAxisSpacing: 5,
//                                     childAspectRatio: 1.8 / 2,
//                                   ),
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   shrinkWrap: true,
//                                   itemBuilder: (context, i) {
//                                     return FutureBuilder<AuthModel>(
//                                       future: controller
//                                           .userInfo(userInfo.friends[i]),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.done) {
//                                           AuthModel friendInfo = snapshot.data!;
//                                           return snapshot.hasData
//                                               ? GestureDetector(
//                                                   onTap: () {
//                                                     friendInfo.id !=
//                                                             UserLocal()
//                                                                 .getUserId()
//                                                         ? AppNavigator.push(
//                                                             AppRoutes
//                                                                 .anotherProfile,
//                                                             arguments: {
//                                                               "user-id":
//                                                                   friendInfo.id,
//                                                             },
//                                                           )
//                                                         : AppNavigator.push(
//                                                             AppRoutes.profile,
//                                                           );
//                                                   },
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: <Widget>[
//                                                       Expanded(
//                                                         child:
//                                                             CachedNetworkImage(
//                                                           imageUrl:
//                                                               friendInfo.photo,
//                                                           imageBuilder: (context,
//                                                                   imageProvider) =>
//                                                               Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           10.0),
//                                                               image:
//                                                                   DecorationImage(
//                                                                 image:
//                                                                     imageProvider,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           placeholder:
//                                                               (context, url) =>
//                                                                   Container(),
//                                                           errorWidget: (context,
//                                                                   url, error) =>
//                                                               const Icon(
//                                                                   Icons.error),
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 5.0),
//                                                       Text(friendInfo.name,
//                                                           style: TextStyle(
//                                                             fontSize: 16.0,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Get
//                                                                     .isDarkMode
//                                                                 ? mCL
//                                                                 : colorBlack,
//                                                           ))
//                                                     ],
//                                                   ),
//                                                 )
//                                               : Container();
//                                         }
//                                         return Container();
//                                       },
//                                     );
//                                   }),
//                               GestureDetector(
//                                 onTap: () {
//                                   AppNavigator.push(AppRoutes.friends,
//                                       arguments: {
//                                         'friends': userInfo.friends,
//                                       });
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       vertical: 15.0),
//                                   height: 40.0,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey[300],
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'See All Friends',
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const SizedBox(),
//                   FutureBuilder<List<PostModel>>(
//                     future: controller.getAnotherUserPosts(userId),
//                     builder: (context, snapshot) {
//                       List<PostModel> posts = snapshot.data ?? [];
//                       return snapshot.hasData
//                           ? ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: posts.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Column(
//                                   children: <Widget>[
//                                     const SeparatorWidget(),
//                                     PostWidget(
//                                       postData: posts[index],
//                                       index: 0,
//                                     ),
//                                   ],
//                                 );
//                               },
//                             )
//                           : Container();
//                     },
//                   ),
//                   const SeparatorWidget()
//                 ],
//               ),
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/themes/font_family.dart';
import 'package:social_app/src/utils/sizer_custom/sizer.dart';
import '../../../../../core/enums/friend_enum.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../../core/widgets/separator_widget.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';

import '../../../../../controller/app_controller.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../../taps/home/data/models/post_model.dart';
import '../../../../../core/widgets/post_widget.dart';
import '../controllers/another_profile_controller.dart';

class AnotherProfileScreen extends GetView<AnotherProfileController> {
  final String userId;
  const AnotherProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    const double coverHeight = 280;
    const double profileHeight = 144;

    Widget buildCoverImage(String image) => Container(
          color: fCL,
          child: image.isNotEmpty
          ? Image.network(
            image,
            width: double.infinity,
            height: coverHeight,
            fit: BoxFit.cover,
          )
          :Container(
                      color: mCH,
                      height: coverHeight,
                  ),
        );

    Widget buildProfileImage(String image) => GestureDetector(
          onTap: () {},
          child: Stack(
            children: [
              CircleAvatar(
                radius: profileHeight / 2,
                backgroundColor: mCL,
                child: CircleAvatar(
                  radius: profileHeight / 2.1,
                  backgroundColor: fCD,
                  backgroundImage: NetworkImage(
                    image,
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

    Widget buildTop(AuthModel userInfo) {
      const bottom = profileHeight / 2;
      const top = coverHeight - profileHeight / 2;
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: bottom),
            child: buildCoverImage(userInfo.backgroundImage),
          ),
          Positioned(
            top: top,
            child: buildProfileImage(userInfo.photo),
          ),
        ],
      );
    }

    Widget buildContent(AuthModel userInfo,
            Function(UserCaseEnum friendEnum) friendSwitch) =>
        Column(
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.size10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GetBuilder<AnotherProfileController>(
                        builder: (anotherProfileCtrl) {
                      return InkWell(
                        onTap: () {
                          anotherProfileCtrl.changeUserCase(
                            userId,
                            false,
                          );
                        },
                        child: Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                              color: anotherProfileCtrl.userEnum ==
                                      UserCaseEnum.notrequestAndFriend
                                  ? colorPrimary
                                  : mCH,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                            child: Text(
                              friendSwitch(
                                anotherProfileCtrl.userEnum,
                              ),
                              style: TextStyle(
                                color: anotherProfileCtrl.userEnum ==
                                        UserCaseEnum.notrequestAndFriend
                                    ? mCL
                                    : colorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(width: Dimensions.size5),
                  GetBuilder<AnotherProfileController>(
                      builder: (anotherProfileCtrl) {
                    return anotherProfileCtrl.userEnum == UserCaseEnum.myRequest
                        ? Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                anotherProfileCtrl.changeUserCase(
                                  userId,
                                  true,
                                );
                              },
                              child: Container(
                                height: 40.0,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: const Center(
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  }),
                  SizedBox(width: Dimensions.size5),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        AppNavigator.push(
                          AppRoutes.chat,
                          arguments: {
                            'user-data': userInfo,
                            'is-group-chat': false,
                          },
                        );
                      },
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Center(
                          child: Text(
                            'Messaging',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.size5),
                  Container(
                    height: 40.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Icon(Icons.more_horiz),
                  )
                ],
              ),
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
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
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
              future: controller.getAnotherUserPosts(userId),
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
      body: FutureBuilder<AuthModel>(
          future: AppGet.authGet.fetchInfoUserById(userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              AuthModel userInfo = snapshot.data!;
              controller.userEnim(userInfo);
              String friendSwitch(UserCaseEnum friendEnum) {
                switch (friendEnum) {
                  case UserCaseEnum.notrequestAndFriend:
                    return 'Add a friend';
                  case UserCaseEnum.userRequest:
                    return 'Delete Requist';
                  case UserCaseEnum.myRequest:
                    return 'Confirm';
                  case UserCaseEnum.friend:
                    return 'Friend';
                  default:
                    return 'Add a friend';
                }
              }

              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  buildTop(userInfo),
                  buildContent(userInfo, friendSwitch),
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }
}
