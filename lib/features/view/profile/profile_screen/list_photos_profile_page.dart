import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../data/models/post_model.dart';

import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/widgets/widgets.dart';
import '../profile_widgets/display_text_image_video.dart';

class ListPhotosProfileScreen extends StatefulWidget {
  const ListPhotosProfileScreen({Key? key}) : super(key: key);

  @override
  State<ListPhotosProfileScreen> createState() =>
      _ListPhotosProfileScreenState();
}

class _ListPhotosProfileScreenState extends State<ListPhotosProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(
            text: 'Publicaciones', fontWeight: FontWeight.w500),
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black)),
      ),
      body: posts.isEmpty
          ? Column(
              children: const [
                CustomShimmer(),
                SizedBox(height: 10.0),
                CustomShimmer(),
                SizedBox(height: 10.0),
                CustomShimmer(),
              ],
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              physics: const BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, i) {
                PostModel postData = posts[i];

                // final List<String> listImages = [];

                // for (var i = 0; i < postData.post!.length; i++) {
                //   listImages.add(postData.post![i]);
                // }

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
                            itemCount: posts.length,
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              enableInfiniteScroll: false,
                              height: 350,
                              scrollPhysics: const BouncingScrollPhysics(),
                              autoPlay: false,
                            ),
                            itemBuilder: (context, i, realIndex) => 
                            ProfileTextImageVideoPost(
                              post: postData.posts![i].post!, 
                              type: postData.posts![i].type!,
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       fit: BoxFit.cover,
                            //       image: NetworkImage(
                            //         postData.posts![i].post!,
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                                    backgroundImage:
                                        NetworkImage(postData.userPhoto!),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextCustom(
                                        text: postData.userName!,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimensions.font20,
                                      ),
                                      TextCustom(
                                        text: timeago.format(
                                            DateTime.fromMicrosecondsSinceEpoch(
                                                postData.time!),
                                            locale: 'en'),
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
            ),
    );
  }
}
