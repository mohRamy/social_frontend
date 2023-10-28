import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// import 'package:photo_manager/photo_manager.dart';
import 'package:social_app/src/controller/app_controller.dart';
import 'package:social_app/src/core/widgets/post_widget.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import '../../../../routes/app_pages.dart';
import '../../../../themes/theme_service.dart';
import '../../../../utils/sizer_custom/sizer.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/story.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../chat/domain/entities/chat.dart';
import '../components/palette.dart';
import '../components/profile_avatar.dart';
import '../controller/home_controller.dart';
import 'view_story_page.dart';
import '../../../../core/displaies/display_image_video_card.dart';

import '../../../../core/widgets/widgets.dart';
import 'add_story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadResources() async {
    await AppGet.homeGet.getAllPosts();
    await AppGet.homeGet.getAllStories();
  }

  // late List<AssetEntity> mediaList = [];

  // @override
  // void initState() {
  //   // _assetImagesDevice();
  //   super.initState();
  // }

  // _assetImagesDevice() async {
  //   var result = await PhotoManager.requestPermissionExtend();
  //   if (result.isAuth) {
  //     List<AssetPathEntity> albums =
  //         await PhotoManager.getAssetPathList(onlyAll: true);

  //     if (albums.isNotEmpty) {
  //       List<AssetEntity> photos =
  //           await albums[0].getAssetListPaged(page: 0, size: 90);

  //       setState(() => mediaList = photos);
  //     }
  //   } else {
  //     PhotoManager.openSetting();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextCustom(
          text: AppString.appName,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.size20,
          isTitle: true,
        ),
        elevation: 0,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                themeService.changeTheme();
              },
              icon: Icon(
                  Get.isDarkMode
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
                  color: context.theme.dividerColor)),
          IconButton(
              splashRadius: 20,
              onPressed: () async {
                // if (AppGet.ChatGet.myChat != null) {
                Chat chatModel = AppGet.chatGet.userChat!;
                List<Auth> usersData = [];
                for (var i = 0; i < chatModel.contents.length; i++) {
                  usersData.add(await AppGet.authGet
                      .fetchInfoUserById(chatModel.contents[i].recieverId));
                }
                AppNavigator.push(
                  AppRoutes.chat,
                  arguments: {
                    'usersData': usersData,
                  },
                );
              },
              // },
              icon: SvgPicture.asset(
                'assets/svg/chat-icon.svg',
                height: 24,
                color: context.theme.dividerColor,
              )),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadResources();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // _ListViewStories(mediaList: mediaList),
              const SizedBox(height: 5.0),
              const _ListViewPosts(),
              // Expanded(
              //   child: ListView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: 10,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: const [
              //           CustomShimmer(),
              //           SizedBox(height: 10.0),
              //           CustomShimmer(),
              //           SizedBox(height: 10.0),
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListViewStories extends GetView<HomeController> {
  // final List<AssetEntity> mediaList;
  const _ListViewStories({
    Key? key,
    // required this.mediaList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UserController userCtrl = Get.find<UserController>();
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      height: 200.0,
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
                          //   future: mediaList.isEmpty
                          //       ? Future.sync(() => null)
                          //       : mediaList[i].thumbnailDataWithSize(
                          //           const ThumbnailSize(110, 110),
                          //         ),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.connectionState ==
                          //         ConnectionState.done) {
                          //       return mediaList.isNotEmpty
                          //           ? Container(
                          //               decoration: BoxDecoration(
                          //                 image: DecorationImage(
                          //                   fit: BoxFit.cover,
                          //                   image: MemoryImage(snapshot.data!),
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
                        "Add Story",
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
          controller.stories.isEmpty
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 8.0,
                  ),
                  itemCount: controller.stories.length,
                  itemBuilder: (context, i) {
                    final Story storyData = controller.stories[i];
                    return SizedBox(
                      width: 110,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            ViewStoryScreen(
                              story: storyData,
                            ),
                          );
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
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

class _ListViewPosts extends StatefulWidget {
  const _ListViewPosts({
    Key? key,
  }) : super(key: key);

  @override
  State<_ListViewPosts> createState() => _ListViewPostsState();
}

class _ListViewPostsState extends State<_ListViewPosts> {
  String userId = UserLocal().getUserId();

  @override
  Widget build(BuildContext context) {
    HomeController homeCtrl = AppGet.homeGet;
    return Obx(
      () => homeCtrl.posts.isEmpty
          ? _ListWithoutPosts()
          : ListView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: homeCtrl.posts.length,
              itemBuilder: (BuildContext context, int index) {
                final Post postData = homeCtrl.posts[index];
                return PostWidget(postData: postData);
              },
            ),
    );
    //PostWidget(posts: homeCtrl.posts);
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
