import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:photo_manager/photo_manager.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/story.dart';

import '../controller/home_controller.dart';
import '../screens/add_story_screen.dart';
import '../screens/view_story_page.dart';
import 'palette.dart';
import 'profile_avatar.dart';
import '../../../../core/displaies/display_image_video_card.dart';

class ListViewStory extends StatefulWidget {
  const ListViewStory({
    Key? key,
  }) : super(key: key);

  @override
  State<ListViewStory> createState() => _ListViewStoryState();
}

class _ListViewStoryState extends State<ListViewStory> {
  // late List<AssetEntity> _mediaList = [];

  @override
  void initState() {
    // _assetImagesDevice();
    super.initState();
  }

  // _assetImagesDevice() async {
  //   var result = await PhotoManager.requestPermissionExtend();
  //   if (result.isAuth) {
  //     List<AssetPathEntity> albums =
  //         await PhotoManager.getAssetPathList(onlyAll: true);

  //     if (albums.isNotEmpty) {
  //       List<AssetEntity> photos =
  //           await albums[0].getAssetListPaged(page: 0, size: 90);

  //       setState(() => _mediaList = photos);
  //     }
  //   } else {
  //     PhotoManager.openSetting();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 200.0,

      // width: Dimensions.screenWidth
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
         InkWell(
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
                            return Container();
                            // return FutureBuilder(
                            //   future: _mediaList.isEmpty
                            //       ? Future.sync(() => null)
                            //       : _mediaList[i].thumbnailDataWithSize(
                            //           const ThumbnailSize(110, 110),
                            //         ),
                            //   builder: (context, snapshot) {
                            //     if (snapshot.connectionState ==
                            //         ConnectionState.done) {
                            //       return _mediaList.isNotEmpty
                            //           ? Container(
                            //               decoration: BoxDecoration(
                            //                 image: DecorationImage(
                            //                   fit: BoxFit.cover,
                            //                   image:
                            //                       MemoryImage(snapshot.data!),
                            //                 ),
                            //               ),
                            //             )
                            //           : Container();
                            //     }
                            //     return const SizedBox();
                            //   },
                            // );
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
            ),
          GetBuilder<HomeController>(builder: (homeCtrl) {
            return FutureBuilder<List<Story>>(
              future: homeCtrl.getAllStories(),
              builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const CustomShimmer()
                  : ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Story story = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Get.to(
                              ViewStoryScreen(
                                story: story,
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: _StoryCard(story: story),
                          ),
                        );
                      },
                    );
            });
          }),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Story story;

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
          child: DisplayImageVideoCard(
            file: story.stories[0].story,
            type: story.stories[0].type,
            isOut: false,
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
