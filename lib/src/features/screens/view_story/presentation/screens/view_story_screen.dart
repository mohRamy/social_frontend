import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_app/src/features/screens/view_story/presentation/controllers/view_story_controller.dart';
import 'package:story_view/story_view.dart';

import '../../../../../controller/app_controller.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../helper/date_time_helper.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/font_family.dart';
import '../../../../../utils/sizer_custom/sizer.dart';
import '../../../../taps/home/data/models/story_model.dart';
import '../../../../taps/home/presentation/components/animated_line.dart';
import '../../../../taps/home/presentation/controllers/home_controller.dart';

class ViewStoryScreen extends StatefulWidget {
  final StoryModel story;

  const ViewStoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    initStoryPageItems();
    _pageController = PageController(viewportFraction: .99);
    _animationController = AnimationController(vsync: this);

    _showStory();
    _animationController.addStatusListener(_statusListener);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_statusListener);
    _animationController.dispose();

    _pageController.dispose();
    super.dispose();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.story.stories.length; i++) {
      storyItems.add(widget.story.stories[i].type == "video"
          ? StoryItem.pageVideo(
              widget.story.stories[i].story,
              controller: controller,
              imageFit: BoxFit.cover,
            )
          : StoryItem.pageImage(
              url: widget.story.stories[i].story,
              controller: controller,
              imageFit: BoxFit.cover,
            ));
    }
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _showStory() {
    _animationController
      ..reset()
      ..duration = const Duration(seconds: 4)
      ..forward();
  }

  int _currentStory = 0;

  void _nextStory() {
    if (_currentStory < widget.story.stories.length - 1) {
      setState(() => _currentStory++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutQuint);
      _showStory();
    }
  }

  void _previousStory() {
    if (_currentStory > 0) {
      // setState(() => _currentStory());
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutQuint);
      _showStory();
    }
  }

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          StoryView(
            storyItems: storyItems,
            controller: controller,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                AppNavigator.pop();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 30.0),

                // * Animated Line //
                Row(
                  children: List.generate(
                    widget.story.stories.length,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: AnimatedLineStory(
                          index: index,
                          selectedIndex: _currentStory,
                          animationController: _animationController,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (widget.story.userData.id !=
                            AppGet.authGet.userData!.id) {
                          AppNavigator.push(
                            AppRoutes.anotherProfile,
                            arguments: {
                              "user-id": widget.story.userData,
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
                                color: Colors.white,
                              ),
                              Text(
                                timeAgoCustom(widget.story.createdAt),
                                style: TextStyle(
                                  color: Get.isDarkMode ? mCL : colorBlack,
                                  fontFamily: FontFamily.lato,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => AppNavigator.pop(),
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
                    // bool meLike = widget.story.likes
                    //     .contains(AppGet.authGet.userData!.id);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(widget.story.userData.photo),
                        ),
                        GetBuilder<ViewStoryController>(
                            builder: (viewStoryCtrl) {
                          return GetBuilder<HomeController>(
                            builder: (homeCtrl) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      viewStoryCtrl.changeStoryLike(
                                        widget.story.id,
                                      );
                                    },
                                    child: homeCtrl.storyLikes
                                            .contains(widget.story.id)
                                        ? Icon(
                                            FontAwesomeIcons.solidThumbsUp,
                                            size: Dimensions.size30,
                                            color: colorPrimary,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.thumbsUp,
                                            size: Dimensions.size30,
                                            color: mCH,
                                          ),
                                  ),
                                  const SizedBox(height: 3),
                                  InkWell(
                                    onTap: () {
                                      AppNavigator.push(
                                        AppRoutes.like,
                                        arguments: {
                                          "users-id": widget.story.likes,
                                        },
                                      );
                                    },
                                    child: TextCustom(
                                      text: homeCtrl.countStoryLikes
                                              .containsKey(widget.story.id)
                                          ? homeCtrl
                                              .countStoryLikes[widget.story.id]
                                              .toString()
                                          : "0",
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              );
                            }
                          );
                        }),
                        InkWell(
                          onTap: () {
                            AppNavigator.push(
                              AppRoutes.comment,
                              arguments: {
                                "item-id": widget.story.id,
                                "item-type": 'story',
                              },
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.commentAlt,
                            size: Dimensions.size30,
                            color: mCH,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await Share.share(
                              widget.story.stories[0].story,
                            );
                          },
                          child: Icon(
                            FontAwesomeIcons.share,
                            size: Dimensions.size30,
                            color: mCH,
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
