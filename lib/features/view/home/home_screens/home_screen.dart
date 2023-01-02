import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/components/components.dart';
import 'package:social_app/features/view/home/home_screens/comments_post_screen.dart';
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
                const _ListHistories(),

                const SizedBox(height: 5.0),

                // if( snapshot.data != null && snapshot.data!.isEmpty){
                //   return _ListWithoutPosts();
                // }

                homeCtrl.isLoading
                    ? Expanded(
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
                    // ? Column(
                    //     children: const [
                    //       CustomShimmer(),
                    //       SizedBox(height: 10.0),
                    //       CustomShimmer(),
                    //       SizedBox(height: 10.0),
                    //       CustomShimmer(),
                    //     ],
                    //   )
                    : Container(
                        color: Colors.grey[200],
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeCtrl.posts.length,
                            reverse: true,
                            itemBuilder: (_, i) {
                              return _ListViewPosts(index: i);
                            }),
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _ListHistories extends StatelessWidget {
  const _ListHistories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 90,
      width: size.width,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            // onTap: () => Navigator.push(context, routeSlide(page: const AddStoryPage())),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.pink,
                        Colors.amber,
                      ],
                    ),
                  ),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // image: DecorationImage(
                      //   image: NetworkImage(Environment.baseUrl + state.user!.image.toString() )
                      // )
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                const TextCustom(text: "state.user!.username", fontSize: 15)
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            height: 90,
            width: size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, i) {
                return InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,

                  // onTap: () => Navigator.push(context, routeFade(page: ViewStoryPage(storyHome:  snapshot.data![i]))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Colors.pink,
                                Colors.amber,
                              ],
                            ),
                          ),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // image: DecorationImage(
                              //   fit: BoxFit.cover,
                              //   image: NetworkImage(Environment.baseUrl + snapshot.data![i].avatar )
                              // )
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        const TextCustom(
                            text: 'snapshot.data![i].username', fontSize: 15)
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ListViewPosts extends StatefulWidget {
  final int index;

  const _ListViewPosts({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<_ListViewPosts> createState() => _ListViewPostsState();
}

class _ListViewPostsState extends State<_ListViewPosts> {
  bool isLike = false;
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;

  HomeCtrl homeCtrl = Get.find<HomeCtrl>();

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
    return GetBuilder<HomeCtrl>(builder: (homeCtrl) {
      PostModel post = homeCtrl.posts[widget.index];
      List<Posts> posts = homeCtrl.posts[widget.index].posts!;

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

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 4,

          // constraints: const BoxConstraints(
          //   maxHeight: 400,
          //   minHeight: 200,
          // ),
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
                            CircleAvatar(
                              backgroundImage: NetworkImage(post.userPhoto!),
                            ),
                            const SizedBox(width: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(
                                  text: post.userName!,
                                  fontWeight: FontWeight.w500,
                                ),
                                TextCustom(
                                  text: timeAgoCustom(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      post.time!,
                                    ),
                                  ),
                                  fontSize: 13,
                                ),
                              ],
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
                  text: post.description!,
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
                        itemCount: post.posts!.length,
                        itemBuilder: (context, index) {
                          
                          return  DisplayTextImageVideoPost(
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
                        post.posts!.length > 1
                            ? DotsIndicator(
                                dotsCount: post.posts!.isEmpty
                                    ? 1
                                    : post.posts!.length,
                                position: _currPageValue,
                                decorator: DotsDecorator(
                                  activeColor: Colors.blue,
                                  size: const Size.square(7.0),
                                  activeSize: const Size(12.0, 10.0),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
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
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            color: Colors.white.withOpacity(0.2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    GetBuilder<HomeCtrl>(
                                      builder: (homeCtrl) {
                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isLike = !isLike;
                                                });

                                                if (isLike) {
                                                  homeCtrl.postLike(
                                                      post.id!, 1);
                                                } else {
                                                  homeCtrl.postLike(
                                                      post.id!, 0);
                                                }
                                              },
                                              child: isLike
                                                  ? const Icon(
                                                      Icons.favorite_outlined,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .favorite_border_outlined,
                                                      color: Colors.white,
                                                    ),
                                            ),
                                            const SizedBox(width: 8.0),
                                            InkWell(
                                              onTap: () {},
                                              child: const TextCustom(
                                                text: "Like",
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20.0),
                                    TextButton(
                                      onPressed: () {
                                        Get.find<HomeCtrl>()
                                            .fetchAllComment(post.id!);
                                        Get.to(
                                          CommentsPostScreen(
                                            uidPost: post.id!,
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
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            'assets/svg/send-icon.svg',
                                            height: 24,
                                            color: Colors.white)),
                                    IconButton(
                                        onPressed: () {},
                                        // onPressed: () => postBloc.add(OnSavePostByUser( posts.postUid )),
                                        icon: const Icon(
                                            Icons.bookmark_border_rounded,
                                            size: 27,
                                            color: Colors.white))
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
    });
  }
}
