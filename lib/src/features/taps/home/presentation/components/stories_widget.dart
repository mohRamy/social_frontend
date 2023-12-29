import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../../resources/local/user_local.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/sizer_custom/sizer.dart';

import '../../../../../core/displaies/display_image_video_card.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../data/models/story_model.dart';
import '../controllers/home_controller.dart';
import 'palette.dart';
import 'profile_avatar.dart';

class StoriesWidget extends GetView<HomeController> {
  const StoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      padding: EdgeInsets.only(
        top: Dimensions.size5,
        bottom: Dimensions.size5,
        left: Dimensions.size10,
        right: Dimensions.size10,
        ),
      child: GetBuilder<HomeController>(
        builder: (homeCtrl) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                onTap: () {
                  AppNavigator.push(AppRoutes.addStory);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 110,
                          height: double.infinity,
                          child: GridView.builder(
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 4 / 7,
                            ),
                            itemBuilder: (context, i) {
                              return FutureBuilder(
                                future: homeCtrl.mediaList.isEmpty
                                    ? Future.sync(() => null)
                                    : homeCtrl.mediaList[i].thumbnailDataWithSize(
                                        const ThumbnailSize(110, 110),
                                      ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return homeCtrl.mediaList.isNotEmpty
                                        ? Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: MemoryImage(snapshot.data!),
                                              ),
                                            ),
                                          )
                                        : Container();
                                  }
                                  return const SizedBox();
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: 110.0,
                          decoration: BoxDecoration(
                            gradient: Palette.storyGradient,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: ProfileAvatar(
                            imageUrl: UserLocal().getUser()!.photo,
                            hasBorder: false,
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          left: 8.0,
                          right: 8.0,
                          child: Text(
                            "add_story".tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              homeCtrl.stories.isNotEmpty
                  ? ListView.builder(
                      itemCount: homeCtrl.stories.length,
                      reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final StoryModel storyData = homeCtrl.stories[index];
                        return InkWell(
                          onTap: () {
                            AppNavigator.push(
                              AppRoutes.viewStory, 
                              arguments: {
                              'story': storyData,
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: DisplayImageVideoCard(
                                    file: storyData.stories[0].story,
                                    type: storyData.stories[0].type,
                                    isOut: true,
                                  ),
                                ),
                                Container(
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: Palette.storyGradient,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                Positioned(
                                  top: 8.0,
                                  left: 8.0,
                                  child: ProfileAvatar(
                                    imageUrl: storyData.userData.photo,
                                    hasBorder: false,
                                  ),
                                ),
                                Positioned(
                                  bottom: 8.0,
                                  left: 8.0,
                                  right: 8.0,
                                  child: TextCustom(
                                    text: storyData.userData.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ],
          );
        }
      ),
    );
  }
}
