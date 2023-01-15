import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_app/config/routes/app_pages.dart';
import 'package:social_app/features/data/models/story_model.dart';
import 'package:social_app/features/view/story/story_ctrl/story_ctrl.dart';
import 'package:social_app/features/view/story/story_screens/story_comment_screen.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/widgets.dart';

class ViewStoryScreen extends StatefulWidget {
  final StoryModel story;

  const ViewStoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with TickerProviderStateMixin {
  // late PageController _pageController;
  late AnimationController _animationController;
  int _currentStory = 0;

  StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    initStoryPageItems();
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

  void initStoryPageItems() {
    for (int i = 0; i < widget.story.stories.length; i++) {
      storyItems.add(widget.story.stories[i].type == "video"
          ? StoryItem.pageVideo(
              widget.story.stories[i].story!,
              controller: controller,
              imageFit: BoxFit.cover,
            )
          : StoryItem.pageImage(
              url: widget.story.stories[i].story!,
              controller: controller,
              imageFit: BoxFit.cover,
            ));
    }
  }

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
    final size = MediaQuery.of(context).size;

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
          StoryView(
            storyItems: storyItems,
            controller: controller,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Get.back();
              }
            },
          ),
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
                            Get.find<UserCtrl>().user.id) {
                          Get.toNamed(
                            Routes.PROFILE,
                            arguments: widget.story.userData,
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
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
              child: Container(
                height: 430,
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: GetBuilder<StoryCtrl>(
                  builder: (storyCtrl) {
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
                                  if (isLike) {
                                    storyCtrl.storyLike(
                                      widget.story.id,
                                      1,
                                    );
                                  } else {
                                    storyCtrl.storyLike(
                                      widget.story.id,
                                      0,
                                    );
                                  }
                                });
                              },
                              child: isLike
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 40,
                                    )
                                  : const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            widget.story.likes.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      if (widget.story.likes.isNotEmpty) {
                                        Get.toNamed(
                                          Routes.POST_LIKES,
                                          arguments: widget.story.likes,
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
                            Get.find<StoryCtrl>()
                                .fetchAllStoryComment(widget.story.id);
                            Get.to(
                              StoryCommentsScreen(
                                uid: widget.story.id,
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
                              widget.story.stories[0].story!,
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
