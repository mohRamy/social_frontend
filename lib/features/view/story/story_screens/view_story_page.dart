import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_app/config/routes/app_pages.dart';
import 'package:social_app/features/data/models/story_model.dart';
import 'package:social_app/features/view/home/home_ctrl/home_ctrl.dart';
import 'package:social_app/features/view/story/story_ctrl/story_ctrl.dart';

import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../home/home_screens/post_comments_screen.dart';
import '../story_widgets/animated_line.dart';

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
  int _currentStory = 0;

  @override
  void initState() {
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
      setState(() => _currentStory--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutQuint);
      _showStory();
    }
  }

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

    bool isLike = false;

    return Scaffold(
      body: Stack(
            fit: StackFit.expand,
            children: [
              GestureDetector(
                onTapDown: (details) {
                  if (details.globalPosition.dx < size.width / 2) {
                    _previousStory();
                  } else {
                    _nextStory();
                  }
                },
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: widget.story.stories.length,
                  itemBuilder: (context, index) {
                    String storyData = widget.story.stories[index].story!;
                    return CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: storyData,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10.0),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: AnimatedLineStory(
                                index: index,
                                selectedIndex: _currentStory,
                                animationController: _animationController),
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
                    height: 330,
                    width: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GetBuilder<StoryCtrl>(
                      builder: (storyCtrl) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                                radius: 20,
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
                                        )
                                      : const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 30,
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
                                              Routes.LIKES,
                                              arguments: widget.story.likes,
                                            );
                                          }
                                        },
                                        child: TextCustom(
                                          text: widget.story.likes.length
                                              .toString(),
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
                                  PostCommentsScreen(
                                    uid: widget.story.id,
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.white,
                                size: 30,
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
                                size: 30,
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
