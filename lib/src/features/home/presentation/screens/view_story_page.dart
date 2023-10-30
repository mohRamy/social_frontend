import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../resources/local/user_local.dart';
import '../../../../controller/app_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../domain/entities/story.dart';
import '../controller/home_controller.dart';
import 'story_comment_screen.dart';
// import 'package:story_view/controller/story_controller.dart';
// import 'package:story_view/utils.dart';
// import 'package:story_view/widgets/story_view.dart';

import '../../../../core/widgets/widgets.dart';

class ViewStoryScreen extends StatefulWidget {
  final Story story;

  const ViewStoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with TickerProviderStateMixin {
  // late PageController _pageController;
  late AnimationController _animationController;

  // StoryController controller = StoryController();
  // List<StoryItem> storyItems = [];

  @override
  void initState() {
    // initStoryPageItems();
    // _pageController = PageController(viewportFraction: .99);
    _animationController = AnimationController(vsync: this);

    _showStory();
    //_animationController.addStatusListener(_statusListener);

    super.initState();
  }

  @override
  void dispose() {
    //_animationController.removeStatusListener(_statusListener);
    _animationController.dispose();

    // _pageController.dispose();
    super.dispose();
  }

  // void initStoryPageItems() {
  //   for (int i = 0; i < widget.story.stories.length; i++) {
  //     storyItems.add(widget.story.stories[i].type == "video"
  //         ? StoryItem.pageVideo(
  //             widget.story.stories[i].story,
  //             controller: controller,
  //             imageFit: BoxFit.cover,
  //           )
  //         : StoryItem.pageImage(
  //             url: widget.story.stories[i].story,
  //             controller: controller,
  //             imageFit: BoxFit.cover,
  //           ));
  //   }
  // }

  // void _statusListener(AnimationStatus status) {
  //   if (status == AnimationStatus.completed) {
  //     _nextStory();
  //   }
  // }

  void _showStory() {
    _animationController
      ..reset()
      ..duration = const Duration(seconds: 4)
      ..forward();
  }

  // void _nextStory() {
  //   if (_currentStory < widget.story.stories.length - 1) {
  //     setState(() => _currentStory++);
  //     _pageController.nextPage(
  //         duration: const Duration(milliseconds: 400),
  //         curve: Curves.easeInOutQuint);
  //     _showStory();
  //   }
  // }

  // void _previousStory() {
  //   if (_currentStory > 0) {
  //     setState(() => _currentStory--);
  //     _pageController.previousPage(
  //         duration: const Duration(milliseconds: 400),
  //         curve: Curves.easeInOutQuint);
  //     _showStory();
  //   }
  // }

  bool isLike = false;

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

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // StoryView(
          //   storyItems: storyItems,
          //   controller: controller,
          //   onVerticalSwipeComplete: (direction) {
          //     if (direction == Direction.down) {
          //       AppNavigator.pop;
          //     }
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30.0),

                // * Animated Line //
                // Row(
                //   children: List.generate(
                //     widget.story.stories.length,
                //     (index) => Expanded(
                //       child: Padding(
                //         padding:
                //             const EdgeInsets.symmetric(horizontal: 3.0),
                //         child: AnimatedLineStory(
                //             index: index,
                //             selectedIndex: _currentStory,
                //             animationController: _animationController),
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.story.userData.id !=
                            UserLocal().getUserId()) {
                          AppNavigator.push(
                            AppRoutes.profileById,
                            arguments: {
                              "userId": widget.story.userData,
                            },
                          );
                        } else {
                          AppNavigator.push(
                            AppRoutes.profile,
                          );
                        }
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkImage(widget.story.userData.photo),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextCustom(
                                  text: widget.story.userData.name,
                                  color: Colors.white),
                              TextCustom(
                                text: timeAgoCustom(widget.story.createdAt),
                                color: Colors.white70,
                                fontSize: 14,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ))
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.size15),
              child: Container(
                height: 430,
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GetBuilder<HomeController>(
                  builder: (homeCtrl) {
                    bool meLike = widget.story.likes
                        .contains(UserLocal().getUserId());
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(widget.story.userData.photo),
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    isLike = !isLike;
                                  });
                                  homeCtrl.storyLike(
                                    widget.story.id,
                                  );
                                },
                                child: Icon(
                                  (meLike || isLike)
                                      ? Icons.favorite_outlined
                                      : Icons.favorite_border_outlined,
                                  color: (meLike || isLike)
                                      ? Colors.red
                                      : Colors.white,
                                  size: 40,
                                )),
                            const SizedBox(
                              height: 3,
                            ),
                            widget.story.likes.isNotEmpty
                                ? InkWell(
                                    onTap: () async {
                                      if (widget.story.likes.isNotEmpty) {
                                        List<Auth> userLikes = [];
                                        for (var i = 0;
                                            i < widget.story.likes.length;
                                            i++) {
                                          userLikes.add(
                                              await AppGet.authGet
                                                  .fetchInfoUserById(
                                                      widget.story.likes[i]));
                                        }
                                        AppNavigator.push(
                                          AppRoutes.likes,
                                          arguments: userLikes,
                                        );
                                      }
                                    },
                                    child: TextCustom(
                                      text:
                                          widget.story.likes.length.toString(),
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Get.to(
                              StoryCommentsScreen(
                                storyId: widget.story.id,
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.comment,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Share.share(
                              widget.story.stories[0].story,
                            );
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
