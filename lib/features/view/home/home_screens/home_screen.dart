import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_app/config/routes/app_pages.dart';
import 'package:social_app/features/view/home/home_screens/post_comments_screen.dart';
import 'package:social_app/features/view/post/post_ctrl/post_ctrl.dart';
import 'package:social_app/features/view/story/story_widgets/stories.dart';
import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/dimensions.dart';

import '../../../../core/utils/app_colors.dart';
import '../home_ctrl/home_ctrl.dart';
import '../../../data/models/post_model.dart';

import '../../../../core/widgets/widgets.dart';
import '../home_widgets/display_text_image_video.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _loadResources() async {
    await Get.find<HomeCtrl>().fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextCustom(
          text: 'Ramy social',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: AppColors.bgColor,
          isTitle: true,
        ),
        elevation: 0,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed:()=> Navigator.pushAndRemoveUntil(context, routeSlide(page: const AddPostPage()), (_) => false);
              icon: SvgPicture.asset('assets/svg/add_rounded.svg', height: 32)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed: () => Navigator.pushAndRemoveUntil(context, routeSlide(page: const NotificationsPage()), (_) => false),
              icon: SvgPicture.asset('assets/svg/notification-icon.svg',
                  height: 26)),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              // onPressed: () => Navigator.push(context, routeSlide(page: const ListMessagesPage())),
              icon: SvgPicture.asset('assets/svg/chat-icon.svg', height: 24)),
        ],
      ),
      body: GetBuilder<HomeCtrl>(builder: (homeCtrl) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await _loadResources();
            },
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Storiess(),
                const SizedBox(height: 5.0),
                homeCtrl.posts.isNotEmpty
                    ? !homeCtrl.isLoading
                        ? const _ListViewPosts()
                        : Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: const [
                                    CustomShimmer(),
                                    SizedBox(height: 10.0),
                                    CustomShimmer(),
                                    SizedBox(height: 10.0),
                                  ],
                                );
                              },
                            ),
                          )
                    : _ListWithoutPosts(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
class _ListViewPosts extends StatefulWidget {
  // final int index;

  const _ListViewPosts({
    Key? key,
    // required this.index,
  }) : super(key: key);

  @override
  State<_ListViewPosts> createState() => _ListViewPostsState();
}

class _ListViewPostsState extends State<_ListViewPosts> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;

  bool isLike = false;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      if (diff.inHours > 0) return "Today ${DateFormat('jm').format(d)}";
      if (diff.inMinutes > 0) {
        return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
      }
      return "just now";
    }

    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeCtrl.posts.length,
        itemBuilder: (context, index) {
          PostModel postData = homeCtrl.posts[index];
          List<Posts> posts = postData.posts!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (postData.userData!.id !=
                                        Get.find<UserCtrl>().user.id) {
                                      Get.toNamed(
                                        Routes.PROFILE,
                                        arguments: postData.userData,
                                      );
                                    } else {
                                      Get.toNamed(
                                        Routes.PROFILE,
                                      );
                                    }
                                  },
                                  child: Row(
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
                                            fontWeight: FontWeight.w500,
                                          ),
                                          TextCustom(
                                            text: timeAgoCustom(
                                              DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                postData.time!,
                                              ),
                                            ),
                                            fontSize: 13,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.more_vert_rounded,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextCustom(
                      text: postData.description!,
                      fontSize: 15,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: postData.posts!.length,
                            itemBuilder: (context, index) {
                              return DisplayTextImageVideoPost(
                                post: posts[index].post!,
                                type: posts[index].type!,
                              );
                            }),
                      ),
                      Positioned(
                        bottom: Dimensions.height10 * 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            postData.posts!.length > 1
                                ? DotsIndicator(
                                    dotsCount: postData.posts!.isEmpty
                                        ? 1
                                        : postData.posts!.length,
                                    position: _currPageValue,
                                    decorator: DotsDecorator(
                                      activeColor: Colors.blue,
                                      size: const Size.square(7.0),
                                      activeSize: const Size(12.0, 10.0),
                                      activeShape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          height: 45,
                          width: Dimensions.screenWidth * .9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                color: Colors.white.withOpacity(0.2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                              children: [
                                                GetBuilder<HomeCtrl>(
                                                  builder: (homeCtrl) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          isLike = !isLike;
                                                          if (isLike) {
                                                            homeCtrl.postLike(
                                                              postData.id!,
                                                              1,
                                                            );
                                                          } else {
                                                            homeCtrl.postLike(
                                                              postData.id!,
                                                              0,
                                                            );
                                                          }
                                                        });
                                                      },
                                                      child: isLike
                                                          ? const Icon(
                                                              Icons
                                                                  .favorite_outlined,
                                                              color: Colors.red,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .favorite_border_outlined,
                                                              color: Colors.white,
                                                            ),
                                                    );
                                                  }
                                                ),
                                                const SizedBox(width: 8.0),
                                                InkWell(
                                                  onTap: () {
                                                    if (postData
                                                        .likes!.isNotEmpty) {
                                                      Get.toNamed(
                                                        Routes.LIKES,
                                                        arguments:
                                                            postData.likes,
                                                      );
                                                    }
                                                  },
                                                  child: TextCustom(
                                                    text: postData
                                                            .likes!.isEmpty
                                                        ? "Like"
                                                        : postData.likes!.length
                                                            .toString(),
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          
                                        
                                        const SizedBox(width: 20.0),
                                        TextButton(
                                          onPressed: () {
                                            Get.find<HomeCtrl>()
                                                .fetchAllPostComment(postData.id!);
                                            Get.to(
                                              PostCommentsScreen(
                                                uid: postData.id!,
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/message-icon.svg',
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 5.0),
                                              const TextCustom(
                                                text: "Comment",
                                                fontSize: 16,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await Share.share(
                                                postData.posts![0].post!);
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/svg/send-icon.svg',
                                            height: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await GallerySaver.saveImage(
                                                postData.posts![0].post!);
                                          },
                                          icon: const Icon(
                                            Icons.bookmark_border_rounded,
                                            size: 27,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class _ListWithoutPosts extends StatelessWidget {
  final List<String> svgPosts = [
    'assets/svg/without-posts-home.svg',
    'assets/svg/without-posts-home.svg',
    'assets/svg/mobile-new-posts.svg',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 20.0),
          padding: const EdgeInsets.all(10.0),
          height: 350,
          width: size.width,
          // color: Colors.amber,
          child: SvgPicture.asset(svgPosts[index], height: 15),
        ),
      ),
    );
  }
}
