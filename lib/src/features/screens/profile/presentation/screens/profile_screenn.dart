// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:social_app/src/features/auth/data/models/auth_model.dart';
// // import 'package:social_app/src/features/home/data/models/post_model.dart';
// // import '../../../../core/widgets/app_text.dart';
// // import '../../../../core/widgets/post_widget.dart';
// // import '../../../../utils/sizer_custom/sizer.dart';
// // import '../../../../controller/app_controller.dart';
// // import '../../../../routes/app_pages.dart';
// // import '../../../../themes/app_colors.dart';
// // import '../../../auth/domain/entities/auth.dart';import '../controller/profile_controller.dart';

// // import '../../../auth/presentation/controller/auth_controller.dart';
// // import '../../../../core/widgets/hero_image.dart';
// // import '../../../home/presentation/components/profile_avatar.dart';
// // import 'followers_screen.dart';
// // import 'following_screen.dart';
// // import 'setting_profile_page.dart';

// // import '../../../../core/widgets/widgets.dart';

// // class ProfileScreen extends GetView<ProfileController> {
// //   const ProfileScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     AuthModel userInfo = AppGet.authGet.userData!;
// //     return Scaffold(
// //       body: CustomScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         slivers: [
// //           SliverAppBar(
// //             pinned: true,
// //             backgroundColor: Get.isDarkMode ? colorBlack : mC,
// //             expandedHeight: 170.sp,
// //             actions: [
// //               IconButton(
// //                 onPressed: () {
// //                   AppNavigator.push(AppRoutes.settings);
// //                 },
// //                 icon: const Icon(
// //                   Icons.dashboard_customize_outlined,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //               IconButton(
// //                 splashRadius: 20,
// //                 onPressed: () {},
// //                 icon: const Icon(
// //                   Icons.add_box_outlined,
// //                   color: Colors.white,
// //                 ),
// //               ),
// //             ],
// //             flexibleSpace: FlexibleSpaceBar(
// //               background: SizedBox(
// //                 child: Stack(
// //                   children: [
// //                     InkWell(
// //                       highlightColor: Colors.transparent,
// //                       splashColor: Colors.transparent,
// //                       onTap: () {
// //                         Get.to(
// //                           HeroImage(
// //                             post: userInfo.backgroundImage,
// //                           ),
// //                         );
// //                       },
// //                       child: Container(
// //                         // height: 210,
// //                         width: Dimensions.screenWidth,
// //                         decoration: BoxDecoration(
// //                           color: colorPrimary.withOpacity(.7),
// //                         ),
// //                         child: userInfo.backgroundImage.isNotEmpty
// //                             ? Image.network(
// //                                 userInfo.backgroundImage,
// //                                 fit: BoxFit.cover,
// //                               )
// //                             : Image.network(
// //                                 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
// //                                 fit: BoxFit.cover,
// //                               ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 22,
// //                       child: Container(
// //                         height: Dimensions.size20,
// //                         width: Dimensions.screenWidth,
// //                         decoration: BoxDecoration(
// //                           color: Get.isDarkMode ? colorBlack : mC,
// //                           borderRadius: BorderRadius.vertical(
// //                             top: Radius.circular(Dimensions.size20),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 0,
// //                       left: Dimensions.size30,
// //                       child: Container(
// //                         alignment: Alignment.center,
// //                         height: 100,
// //                         child: Container(
// //                             height: 100,
// //                             width: 100,
// //                             decoration: const BoxDecoration(
// //                                 color: Colors.green, shape: BoxShape.circle),
// //                             child: InkWell(
// //                               highlightColor: Colors.transparent,
// //                               splashColor: Colors.transparent,
// //                               onTap: () {
// //                                 Get.to(
// //                                   HeroImage(
// //                                     post: userInfo.photo,
// //                                   ),
// //                                 );
// //                               },
// //                               child: ProfileAvatar(
// //                                 imageUrl: userInfo.photo,
// //                                 sizeImage: 100,
// //                               ),
// //                             )),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 0.0,
// //                       right: Dimensions.size10,
// //                       child: Row(
// //                         children: [
// //                           InkWell(
// //                             onTap: () {
// //                               AppNavigator.push(
// //                                 AppRoutes.accountProfile,
// //                                 arguments: {
// //                                   "userInfo": userInfo,
// //                                 },
// //                               );
// //                             },
// //                             child: Container(
// //                               padding: EdgeInsets.symmetric(
// //                                 horizontal: Dimensions.size10,
// //                                 vertical: Dimensions.size5,
// //                               ),
// //                               decoration: BoxDecoration(
// //                                 borderRadius:
// //                                     BorderRadius.circular(Dimensions.size30),
// //                                 border:
// //                                     Border.all(width: 0.4, color: Colors.grey),
// //                                 color: mC,
// //                               ),
// //                               child: const AppText(
// //                                 "Modify your profile",
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           SliverToBoxAdapter(
// //             child: ListView(
// //               physics: const NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               children: [
// //                 // _CoverAndProfile(
// //                 //   userInfo: UserLocal().getUser()!,
// //                 // ),
// //                 const SizedBox(height: 10.0),
// //                 _UsernameAndDescription(userData: userInfo),
// //                 const SizedBox(height: 30.0),
// //                 _PostAndFollow(
// //                   userData: userInfo,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //       // body: ListView(
// //       //   children: [
// //       //     _CoverAndProfile(
// //       //       userInfo: UserLocal().getUser()!,
// //       //     ),
// //       //     const SizedBox(height: 10.0),
// //       //     _UsernameAndDescription(userData: UserLocal().getUser()!),
// //       //     const SizedBox(height: 30.0),
// //       //     _PostAndFollow(
// //       //       userData: UserLocal().getUser()!,
// //       //     ),
// //       //   ],
// //       // ),
// //     );
// //   }
// // }

// // class _ListUserPost extends StatelessWidget {
// //   final Auth userData;
// //   const _ListUserPost({
// //     Key? key,
// //     required this.userData,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //       // return profileCtrl.userPostsById.isEmpty
// //       //     ? const CustomShimmer()
// //       //     : GridView.builder(
// //       //         itemCount: profileCtrl.userPostsById.length,
// //       //         physics: const NeverScrollableScrollPhysics(),
// //       //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //       //           crossAxisCount: 3,
// //       //           crossAxisSpacing: 2,
// //       //           mainAxisExtent: 170,
// //       //         ),
// //       //         // scrollDirection: Axis.vertical,
// //       //         shrinkWrap: true,
// //       //         itemBuilder: (context, i) {
// //       //           Post postData = profileCtrl.userPostsById[i];
// //       //           return InkWell(
// //       //               onTap: () {
// //       //                 AppNavigator.push(
// //       //                   AppRoutes.listPhotoProfile,
// //       //                   arguments: profileCtrl.userPostsById,
// //       //                 );
// //       //               },
// //       //               child: Stack(
// //       //                 children: [
// //       //                   InkWell(
// //       //                     onTap: () {
// //       //                       AppNavigator.push(
// //       //                         AppRoutes.listPhotoProfile,
// //       //                         arguments: profileCtrl.userPostsById,
// //       //                       );
// //       //                     },
// //       //                     child: DisplayImageVideoCard(
// //       //                       file: postData.posts[0].post,
// //       //                       type: postData.posts[0].type,
// //       //                       isOut: true,
// //       //                     ),
// //       //                   ),
// //       //                   postData.posts.length == 1
// //       //                       ? Container()
// //       //                       : Positioned(
// //       //                           top: Dimensions.size10,
// //       //                           right: Dimensions.size10,
// //       //                           child: const Icon(Icons.layers),
// //       //                         ),
// //       //                 ],
// //       //               ));
// //       //         });
// //   }
// // }

// // class _PostAndFollow extends StatelessWidget {
// //   final AuthModel userData;
// //   const _PostAndFollow({
// //     Key? key,
// //     required this.userData,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder<List<PostModel>>(
// //         future: AppGet.profileGet.getUserPosts(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.done) {
// //             List<PostModel> posts = snapshot.data!;
// //             return Column(
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 30.0),
// //                   width: Dimensions.screenWidth,
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Row(
// //                         children: [
// //                           TextCustom(
// //                             text: posts.length.toString(),
// //                             fontSize: 17,
// //                             color: Colors.grey,
// //                             letterSpacing: .7,
// //                           ),
// //                           TextCustom(
// //                             text: 'Posts',
// //                             fontSize: 18.sp,
// //                             fontWeight: FontWeight.w500,
// //                           ),
                          
// //                         ],
// //                       ),
// //                       GestureDetector(
// //                         onTap: () async {
// //                           List<AuthModel> followers = [];
// //                           for (var i = 0; i < userData.followers.length; i++) {
// //                             followers.add(await AppGet.authGet
// //                                 .fetchInfoUserById(userData.followers[i]));
// //                           }
// //                           Get.to(
// //                             const FollowersScreen(),
// //                             arguments: followers,
// //                           );
// //                         },
// //                         child: Row(
// //                           children: [
// //                             TextCustom(
// //                               text: userData.followers.length.toString(),
// //                               fontSize: 17,
// //                               color: Colors.grey,
// //                               letterSpacing: .7,
// //                             ),
// //                             TextCustom(
// //                                 text: 'Followers',
// //                                 fontSize: 18.sp,
// //                                 fontWeight: FontWeight.w500),
// //                           ],
// //                         ),
// //                       ),
// //                       GestureDetector(
// //                         onTap: () async {
// //                           List<AuthModel> followings = [];
// //                           for (var i = 0; i < userData.following.length; i++) {
// //                             followings.add(await Get.find<AuthController>()
// //                                 .fetchInfoUserById(userData.following[i]));
// //                           }
// //                           Get.to(const FollowingScreen(),
// //                               arguments: followings);
// //                         },
// //                         child: Row(
// //                           children: [
// //                             TextCustom(
// //                               text: userData.following.length.toString(),
// //                               fontSize: 17,
// //                               color: Colors.grey,
// //                               letterSpacing: .7,
// //                             ),
// //                             SizedBox(width: Dimensions.size5),
// //                             TextCustom(
// //                                 text: 'Following',
// //                                 fontSize: 18.sp,
// //                                 fontWeight: FontWeight.w500),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(height: Dimensions.size30),
// //                 ListView.builder(
// //               reverse: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               shrinkWrap: true,
// //               itemCount: posts.length,
// //               itemBuilder: (BuildContext context, int index) {
// //                 final PostModel postData = posts[index];
// //                 return PostWidget(postData: postData);
// //               },
// //             ),
// //                 //PostWidget(posts: posts),
// //               ],
// //             );
// //           } else {
// //             return Container();
// //           }
// //         });
// //   }
// // }

// // class _UsernameAndDescription extends StatelessWidget {
// //   final AuthModel userData;
// //   const _UsernameAndDescription({
// //     Key? key,
// //     required this.userData,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.only(
// //         left: Dimensions.size10,
// //         top: Dimensions.size10,
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           TextCustom(
// //             text: userData.name,
// //             fontSize: 22.sp,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _CoverAndProfile extends StatefulWidget {
// //   final Auth userInfo;
// //   const _CoverAndProfile({
// //     Key? key,
// //     required this.userInfo,
// //   }) : super(key: key);

// //   @override
// //   State<_CoverAndProfile> createState() => _CoverAndProfileState();
// // }

// // class _CoverAndProfileState extends State<_CoverAndProfile> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 200,
// //       width: Dimensions.screenWidth,
// //       child: Stack(
// //         children: [
// //           InkWell(
// //             highlightColor: Colors.transparent,
// //             splashColor: Colors.transparent,
// //             onTap: () {
// //               Get.to(
// //                 HeroImage(
// //                   post: widget.userInfo.backgroundImage,
// //                 ),
// //               );
// //             },
// //             child: Container(
// //               height: 170,
// //               width: Dimensions.screenWidth,
// //               decoration: BoxDecoration(
// //                 color: colorPrimary.withOpacity(.7),
// //               ),
// //               child: widget.userInfo.backgroundImage.isNotEmpty
// //                   ? Image.network(
// //                       widget.userInfo.backgroundImage,
// //                       fit: BoxFit.cover,
// //                     )
// //                   : Image.network(
// //                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXYE2NzC7cY66U6JRENpM0eVXn9JyOUJ5PVQ&usqp=CAU',
// //                       fit: BoxFit.cover,
// //                     ),
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 28,
// //             child: Container(
// //               height: Dimensions.size20,
// //               width: Dimensions.screenWidth,
// //               decoration: BoxDecoration(
// //                   color: Get.isDarkMode ? colorBlack : mC,
// //                   borderRadius:
// //                       const BorderRadius.vertical(top: Radius.circular(20.0))),
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 0,
// //             left: Dimensions.size30,
// //             child: Container(
// //               alignment: Alignment.center,
// //               height: 100,
// //               // width: size.width,
// //               child: Container(
// //                   height: 100,
// //                   width: 100,
// //                   decoration: const BoxDecoration(
// //                       color: Colors.green, shape: BoxShape.circle),
// //                   child: InkWell(
// //                     highlightColor: Colors.transparent,
// //                     splashColor: Colors.transparent,
// //                     onTap: () {
// //                       Get.to(
// //                         HeroImage(
// //                           post: widget.userInfo.photo,
// //                         ),
// //                       );
// //                     },
// //                     child: ProfileAvatar(
// //                       imageUrl: widget.userInfo.photo,
// //                       sizeImage: 100,
// //                     ),
// //                   )),
// //             ),
// //           ),
// //           Positioned(
// //             bottom: 0.0,
// //             right: Dimensions.size10,
// //             child: Row(
// //               children: [
// //                 InkWell(
// //                   onTap: () {
// //                     AppNavigator.push(
// //                       AppRoutes.accountProfile,
// //                       arguments: {
// //                         "userInfo": widget.userInfo,
// //                       },
// //                     );
// //                   },
// //                   child: Container(
// //                     padding: EdgeInsets.symmetric(
// //                       horizontal: Dimensions.size10,
// //                       vertical: Dimensions.size5,
// //                     ),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(Dimensions.size30),
// //                       border: Border.all(width: 0.4, color: Colors.grey),
// //                       color: mC,
// //                     ),
// //                     child: const AppText(
// //                       "Modify your profile",
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Positioned(
// //             left: 0.0,
// //             child: IconButton(
// //               splashRadius: 20,
// //               onPressed: () => AppNavigator.pop,
// //               icon: const Icon(
// //                 Icons.arrow_back_ios_new_rounded,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //               right: 0,
// //               child: IconButton(
// //                 onPressed: () {
// //                   Get.to(const SettingProfileScreen());
// //                 },
// //                 //onPressed: () => modalProfileSetting(context, size),
// //                 icon: const Icon(Icons.dashboard_customize_outlined,
// //                     color: Colors.white),
// //               )),
// //           Positioned(
// //             right: 40,
// //             child: IconButton(
// //               splashRadius: 20,
// //               onPressed: () {},
// //               icon: const Icon(
// //                 Icons.add_box_outlined,
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _PrivateAccount extends StatelessWidget {
// //   const _PrivateAccount();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         SizedBox(height: 100.sp),
// //         Icon(
// //           Icons.lock_outlined,
// //           size: Dimensions.size24,
// //         ),
// //         SizedBox(width: Dimensions.size10),
// //         TextCustom(
// //           text: 'this account is private',
// //           fontSize: Dimensions.size26,
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:social_app/src/core/widgets/app_text.dart';
// import 'package:social_app/src/core/widgets/separator_widget.dart';

// import '../../../../../controller/app_controller.dart';
// import '../../../auth/data/models/auth_model.dart';
// import '../../../../taps/home/data/models/post_model.dart';
// import '../../../../../core/widgets/post_widget.dart';
// import '../controller/profile_controller.dart';

// class ProfileScreen extends GetView<ProfileController> {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AuthModel userInfo = AppGet.authGet.userData!;
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 360.0,
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: 15.0, vertical: 15.0),
//                   height: 180.0,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: NetworkImage(
//                             userInfo.backgroundImage,
//                           ),
//                           fit: BoxFit.cover),
//                       borderRadius: BorderRadius.circular(10.0)),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         userInfo.photo,
//                       ),
//                       radius: 70.0,
//                     ),
//                     const SizedBox(height: 20.0),
//                     Text(userInfo.name,
//                         style: const TextStyle(
//                             fontSize: 24.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black)),
//                     const SizedBox(height: 20.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Container(
//                           height: 40.0,
//                           width: MediaQuery.of(context).size.width - 80,
//                           decoration: BoxDecoration(
//                               color: Colors.blue,
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: const Center(
//                               child: Text('Add to Story',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16.0))),
//                         ),
//                         Container(
//                           height: 40.0,
//                           width: 45.0,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[300],
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: const Icon(Icons.more_horiz),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
//             child: Divider(height: 40.0),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Column(
//               children: <Widget>[
//                 const Row(
//                   children: <Widget>[
//                     Icon(Icons.home, color: Colors.grey, size: 30.0),
//                     SizedBox(width: 10.0),
//                     AppText(
//                       'Lives in New York',
//                       type: TextType.medium,
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 15.0),
//                 Row(
//                   children: <Widget>[
//                     const Icon(Icons.location_on, color: Colors.grey, size: 30.0),
//                     const SizedBox(width: 10.0),
//                     AppText(
//                       'From ${userInfo.address}',
//                       type: TextType.medium,
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 15.0),
//                 const Row(
//                   children: <Widget>[
//                     Icon(Icons.more_horiz, color: Colors.grey, size: 30.0),
//                     SizedBox(width: 10.0),
//                     AppText(
//                       'See your About Info',
//                       type: TextType.medium,
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 15.0),
//                 Container(
//                   height: 40.0,
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlueAccent.withOpacity(0.25),
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   child: const Center(
//                       child: Text('Edit Public Details',
//                           style: TextStyle(
//                               color: Colors.blue,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0))),
//                 ),
//               ],
//             ),
//           ),
//           const Divider(height: 40.0),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15.0),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         const Text('Friends',
//                             style: TextStyle(
//                                 fontSize: 22.0, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 6.0),
//                         Text('${userInfo.friends.length} friends',
//                             style: TextStyle(
//                                 fontSize: 16.0, color: Colors.grey[800])),
//                       ],
//                     ),
//                     const Text('Find Friends',
//                         style: TextStyle(fontSize: 16.0, color: Colors.blue)),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/samantha.jpg')),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Samantha',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/andrew.jpg')),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Andrew',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/Sam Wilson.jpg'),
//                                     fit: BoxFit.cover),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Sam Wilson',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Columns(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/steven.jpg')),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Steven',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/greg.jpg')),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Greg',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             height: MediaQuery.of(context).size.width / 3 - 20,
//                             width: MediaQuery.of(context).size.width / 3 - 20,
//                             decoration: BoxDecoration(
//                                 image: const DecorationImage(
//                                     image: AssetImage('assets/andy.jpg'),
//                                     fit: BoxFit.cover),
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           const SizedBox(height: 5.0),
//                           const Text('Andy',
//                               style: TextStyle(
//                                   fontSize: 16.0, fontWeight: FontWeight.bold))
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 15.0),
//                   height: 40.0,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(5.0),
//                   ),
//                   child: const Center(
//                       child: Text('See All Friends',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16.0))),
//                 ),
//               ],
//             ),
//           ),
//           FutureBuilder<List<PostModel>>(
//             future: AppGet.profileGet.getUserPosts(),
//             builder: (context, snapshot) {
//               List<PostModel> posts = snapshot.data ?? [];
//               return snapshot.hasData
//                   ? ListView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: posts.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Column(
//                           children: <Widget>[
//                             const SeparatorWidget(),
//                             PostWidget(postData: posts[index], index: 0),
//                           ],
//                         );
//                       },
//                     )
//                   : Container();
//             },
//           ),
//           SeparatorWidget()
//         ],
//       )),
//     );
//   }
// }

