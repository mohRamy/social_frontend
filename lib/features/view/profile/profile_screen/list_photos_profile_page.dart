import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/displaies/display_image_video_card.dart';
import 'package:social_app/features/view/profile/profile_ctrl/profile_ctrl.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../data/models/post_model.dart';

import '../../../../core/widgets/widgets.dart';

class ListPhotosProfileScreen extends StatefulWidget {
  const ListPhotosProfileScreen({Key? key}) : super(key: key);

  @override
  State<ListPhotosProfileScreen> createState() =>
      _ListPhotosProfileScreenState();
}

class _ListPhotosProfileScreenState extends State<ListPhotosProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<PostModel> userPosts = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        title: const TextCustom(
            text: 'Publicaciones', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black)),
      ),
      body: userPosts.isEmpty
          ? Column(
              children: const [
                CustomShimmer(),
                SizedBox(height: 10.0),
                CustomShimmer(),
                SizedBox(height: 10.0),
                CustomShimmer(),
              ],
            )
          : GetBuilder<ProfileCtrl>(builder: (profileCtrl) {
              String timeAgoCustom(DateTime d) {
                Duration diff = DateTime.now().difference(d);
                if (diff.inDays > 365) {
                  return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
                }
                if (diff.inDays > 30) {
                  return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
                }
                if (diff.inDays > 7) {
                  return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
                }
                if (diff.inDays > 0) return DateFormat.E().add_jm().format(d);
                if (diff.inHours > 0)
                  return "Today ${DateFormat('jm').format(d)}";
                if (diff.inMinutes > 0) {
                  return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
                }
                return "just now";
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                physics: const BouncingScrollPhysics(),
                itemCount: userPosts.length,
                itemBuilder: (context, index) {
                  PostModel postData = userPosts[index];
                  List<Posts> posts = postData.posts!;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      height: 350,
                      width: Dimensions.screenWidth,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CarouselSlider.builder(
                              itemCount: postData.posts!.length,
                              options: CarouselOptions(
                                viewportFraction: 1.0,
                                enableInfiniteScroll: false,
                                height: 350,
                                scrollPhysics: const BouncingScrollPhysics(),
                                autoPlay: false,
                              ),
                              itemBuilder: (context, i, realIndex) =>
                                  DisplayImageVideoCard(
                                  file: posts[i].post!,
                                  type: posts[i].type!,
                                isOut: false,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              top: Dimensions.height10 - 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          postData.userData!.photo),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          text: postData.userData!.name,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.font20,
                                        ),
                                        TextCustom(
                                          text: timeAgoCustom(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              postData.time!,
                                            ),
                                          ),
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                  splashRadius: 20,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.more_vert_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   bottom: 25,
                          //   child: Container(
                          //     padding: const EdgeInsets.symmetric(
                          //       horizontal: 15.0,
                          //     ),
                          //     height: 45,
                          //     width: Dimensions.screenWidth * .95,
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50.0),
                          //       child: BackdropFilter(
                          //         filter: ImageFilter.blur(
                          //           sigmaX: 5.0,
                          //           sigmaY: 5.0,
                          //         ),
                          //         child: Container(
                          //           padding: const EdgeInsets.symmetric(
                          //             horizontal: 10.0,
                          //           ),
                          //           color: Colors.white.withOpacity(0.2),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   TextButton(
                          //                     onPressed: () {},
                          //                     // onPressed: () => postBloc.add( OnLikeOrUnLikePost(snapshot.data![i].postUid, snapshot.data![i].personUid) ),
                          //                     child: Row(
                          //                       children: const [
                          //                         // snapshot.data![i].isLike == 1
                          //                         // ? const Icon(Icons.favorite_rounded, color: Colors.red)
                          //                         // :
                          //                         Icon(
                          //                             Icons
                          //                                 .favorite_outline_rounded,
                          //                             color: Colors.white),
                          //                         SizedBox(width: 8.0),
                          //                         TextCustom(
                          //                           text: "Like",
                          //                           fontSize: 16,
                          //                           color: Colors.white,
                          //                         )
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   SizedBox(width: Dimensions.width20),
                          //                   TextButton(
                          //                     onPressed: () {
                          //                       //  Navigator.push(
                          //                       //   context,
                          //                       //   routeFade(page: CommentsPostPage(uidPost: snapshot.data![i].postUid))
                          //                       // );
                          //                     },
                          //                     child: Row(
                          //                       children: [
                          //                         SvgPicture.asset(
                          //                           'assets/svg/message-icon.svg',
                          //                           color: Colors.white,
                          //                         ),
                          //                         const SizedBox(width: 5.0),
                          //                         const TextCustom(
                          //                           text: "Comments",
                          //                           fontSize: 16,
                          //                           color: Colors.white,
                          //                         )
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               Row(
                          //                 children: [
                          //                   IconButton(
                          //                     onPressed: () {},
                          //                     icon: SvgPicture.asset(
                          //                       'assets/svg/send-icon.svg',
                          //                       height: 24,
                          //                       color: Colors.white,
                          //                     ),
                          //                   ),
                          //                   IconButton(
                          //                     onPressed: () {},
                          //                     icon: const Icon(
                          //                       Icons.bookmark_outline_sharp,
                          //                       size: 27,
                          //                       color: Colors.white,
                          //                     ),
                          //                   )
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
    );
  }
}
