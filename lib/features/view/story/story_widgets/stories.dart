import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_app/core/utils/dimensions.dart';

import 'package:social_app/features/data/models/story_model.dart';
import 'package:social_app/features/view/home/home_ctrl/home_ctrl.dart';
import 'package:social_app/features/view/story/story_widgets/palette.dart';
import 'package:social_app/features/view/story/story_widgets/profile_avatar.dart';

import '../../../../controller/user_ctrl.dart';
import '../../../../core/widgets/widgets.dart';
import '../story_screens/add_story_page.dart';
import '../story_screens/view_story_page.dart';

class Storiess extends StatefulWidget {
  const Storiess({
    Key? key,
  }) : super(key: key);

  @override
  State<Storiess> createState() => _StoriessState();
}

class _StoriessState extends State<Storiess> {
  late List<AssetEntity> _mediaList = [];

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);

        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 200.0,
      alignment: Alignment.center,
      // width: Dimensions.screenWidth
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          GetBuilder<UserCtrl>(builder: (userCtrl) {
            return InkWell(
              onTap: () {
                Get.to(
                  const AddStoryScreen(),
                );
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
                              future: _mediaList[i].thumbnailDataWithSize(
                                const ThumbnailSize(110, 110),
                              ),
                              builder: (context,
                                  AsyncSnapshot<Uint8List?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(snapshot.data!),
                                      ),
                                    ),
                                  );
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
                          imageUrl: userCtrl.user.photo,
                          hasBorder: false,
                        ),
                      ),
                      const Positioned(
                        bottom: 8.0,
                        left: 8.0,
                        right: 8.0,
                        child: Text(
                          'Add Story',
                          style: TextStyle(
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
            );
          }),
          GetBuilder<HomeCtrl>(builder: (homeCtrl) {
            return SizedBox(
              height: 200.0,
              width: Dimensions.screenWidth * 10,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 8.0,
                ),
                itemCount: homeCtrl.stories.length,
                itemBuilder: (BuildContext context, int index) {
                  final StoryModel story = homeCtrl.stories[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        ViewStoryScreen(
                          story: story,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _StoryCard(story: story),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final StoryModel story;

  const _StoryCard({
    Key? key,
    required this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: story.stories[0].story!,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
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
            imageUrl: story.userData.photo,
            hasBorder: false,
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            story.userData.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
