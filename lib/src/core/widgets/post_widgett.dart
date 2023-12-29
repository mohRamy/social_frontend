// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../controller/app_controller.dart';

// import 'app_text.dart';
// import 'widgets.dart';
// import '../../public/constants.dart';
// import '../../themes/app_colors.dart';

// import '../../features/home/presentation/components/profile_avatar.dart';
// import '../../routes/app_pages.dart';
// import '../../utils/sizer_custom/sizer.dart';
// import '../displaies/display_image_video_card.dart';
// import 'expandable_text_widget.dart';

// class PostWidget extends StatelessWidget {
//   final PostModel postData;
//   const PostWidget({
//     Key? key,
//     required this.postData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//             margin: EdgeInsets.only(bottom: 10.sp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   postData.userData.id !=
//                                           AppGet.authGet.userData!.id
//                                       ? AppNavigator.push(
//                                           AppRoutes.profile,
//                                           arguments: {
//                                             "userId": postData.userData.id,
//                                           },
//                                         )
//                                       : AppNavigator.push(
//                                           AppRoutes.profile,
//                                         );
//                                 },
//                                 child: Row(
//                                   children: [
//                                     ProfileAvatar(
//                                       imageUrl: postData.userData.photo,
//                                     ),
//                                     const SizedBox(width: 10.0),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         AppText(
//                                           postData.userData.name,
//                                         ),
//                                         const SizedBox(height: 3),
//                                         TextCustom(
//                                           text: DateFormat.jm().format(postData.createdAt),
//                                           fontSize: 13,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: Icon(
//                               Icons.more_horiz,
//                               color: fCL,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: ExpandableTextWidget(
//                     text: postData.description ?? "",
//                   ),
//                 ),
//                 postData.posts.isNotEmpty
//                     ? SizedBox(
//                         height: 380,
//                         child: CarouselSlider.builder(
//                             itemCount: postData.posts.length,
//                             options: CarouselOptions(
//                               viewportFraction: 1.0,
//                               enableInfiniteScroll: false,
//                               height: 380,
//                               scrollPhysics: const BouncingScrollPhysics(),
//                               autoPlay: false,
//                             ),
//                             itemBuilder: (context, i, realIndex) =>
//                                 DisplayImageVideoCard(
//                                   file: postData.posts[i].post,
//                                   type: postData.posts[i].type,
//                                   isOut: false,
//                                 )),
//                       )
//                     : Container(),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(right: 10.sp, bottom: 3.sp, top: 10.sp),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                             GestureDetector(
//                                 onTap: () {
//                                   AppNavigator.push(
//                                     AppRoutes.postComments,
//                                     arguments: {
//                                       "post-id": postData.id,
//                                     },
//                                   );
//                                 },
//                                 child: TextCustom(
//                                   text:
//                                   postData.comments.length.toString(),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   color: Get.isDarkMode ? mCL : fCL,
//                                 ),
//                               ),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "Comments",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "I",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                         const SizedBox(width: 3),
//                         // homeCtrl.countLikePost.containsKey(postData.id)
//                             // ? 
//                             GetBuilder<HomeController>(
//                               builder: (homeCtrl) {
//                                 return GestureDetector(
//                                     onTap: () {
//                                       AppNavigator.push(
//                                         AppRoutes.likes,
//                                         arguments: {
//                                           "users-id": postData.likes,
//                                         },
//                                       );
//                                     },
//                                     child: TextCustom(
//                                       text: homeCtrl.countLikePost.containsKey(postData.id) ? homeCtrl.countLikePost[postData.id].toString() : "0",
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: Get.isDarkMode ? mCL : fCL,
//                                     ),
//                                   );
//                               }
//                             ),
//                             //: Container(),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "Likes",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "I",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "0",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                         const SizedBox(width: 3),
//                         TextCustom(
//                           text: "Shared",
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Get.isDarkMode ? mCL : fCL,
//                         ),
//                       ],
//                     ),
//                 ),
//                 const Divider(),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GetBuilder<HomeController>(
//                         builder: (homeCtrl) {
//                           return Column(
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     if (homeCtrl.likesPost.contains(postData.id)) {
//                                       homeCtrl.removelike(postData.id);
//                                       homeCtrl.addLikePost(
//                                         postData.id,
//                                       );
//                                     } else {
//                                       homeCtrl.addLike(postData.id);
//                                       homeCtrl.addLikePost(
//                                         postData.id,
//                                       );
//                                     }
//                                   },
//                                   child: homeCtrl.likesPost.contains(postData.id)
//                                       ? Image.asset(
//                                           AppConstants.liked32Asset,
//                                           height: 23,
//                                         )
//                                       : Image.asset(
//                                           AppConstants.like32Asset,
//                                           height: 23,
//                                         ),
//                                 ),
//                                 TextCustom(
//                                   text: "Like",
//                                   fontSize: 10.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ],
//                             );
//                         }
//                       ),
//                       Column(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               AppNavigator.push(
//                                 AppRoutes.postComments,
//                                 arguments: {
//                                   "post-id": postData.id,
//                                 },
//                               );
//                             },
//                             child: Image.asset(
//                               AppConstants.commentAsset,
//                               height: 23,
//                             ),
//                           ),
//                           TextCustom(
//                             text: "Comment",
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           InkWell(
//                             onTap: () async {
//                               await Share.share(postData.posts[0].post);
//                             },
//                             child: Image.asset(
//                               AppConstants.shareAsset,
//                               height: 23,
//                             ),
//                           ),
//                           TextCustom(
//                             text: "Share",
//                             fontSize: 10.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ],
//                       ),
//                       // IconButton(
//                       //   onPressed: () async {
//                       //     await GallerySaver.saveImage(
//                       //         postData.posts[0].post);
//                       //   },
//                       //   icon: const Icon(
//                       //     Icons.bookmark_border_rounded,
//                       //     size: 27,
//                       //   ),
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   thickness: 6,
//                   color: fCL,
//                 ),
//                 // SizedBox(height: Dimensions.size10),
//               ],
//             ),
//           );
//         }
// }
  

