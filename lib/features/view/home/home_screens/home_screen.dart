import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:social_app/features/auth/domain/entities/auth.dart';
import 'package:social_app/features/auth/presentation/controller/auth_controller.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../config/themes/theme_services.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_component.dart';
import '../../chat/controller/chat_ctrl.dart';
import 'modify_post.dart';
import 'view_story_page.dart';
import 'package:social_app/core/displaies/display_image_video_card.dart';

import '../../../../controller/user_ctrl.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/widgets/expandable_text_widget.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/story_model.dart';
import '../home_ctrl/home_ctrl.dart';
import '../home_widgets/palette.dart';
import '../home_widgets/profile_avatar.dart';
import 'add_story_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadResources() async {
    await Get.find<HomeCtrl>().fetchAllPosts();
    await Get.find<HomeCtrl>().fetchAllStories();
  }

  late List<AssetEntity> mediaList = [];

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

        setState(() => mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextCustom(
          text: AppString.APP_NAME,
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.font20,
          isTitle: true,
        ),
        elevation: 0,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                ModeTheme().changeTheme();
              },
              icon: Icon(
                  Get.isDarkMode
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
                  color: context.theme.dividerColor)),
          IconButton(
              splashRadius: 20,
              onPressed: () async {
                if (Get.find<ChatCtrl>().chatContacts.contents != null) {
                  ChatModel chatModel = Get.find<ChatCtrl>().chatContacts;
                  List<Auth> usersData = [];
                  for (var i = 0; i < chatModel.contents!.length; i++) {
                    usersData.add(await Get.find<AuthController>()
                        .getUserData(chatModel.contents![i].recieverId!));
                  }
                  Get.toNamed(Routes.CONTACTS_LIST, arguments: usersData);
                }
              },
              icon: SvgPicture.asset(
                'assets/svg/chat-icon.svg',
                height: 24,
                color: context.theme.dividerColor,
              )),
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
                _ListViewStories(mediaList: mediaList),
                const SizedBox(height: 5.0),
                homeCtrl.posts.isNotEmpty
                    ? !homeCtrl.isLoading
                        ? const _ListViewPosts()
                        : _ListWithoutPosts()
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
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _ListViewStories extends StatelessWidget {
  final List<AssetEntity> mediaList;
  const _ListViewStories({
    Key? key,
    required this.mediaList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCtrl homeCtrl = Get.find<HomeCtrl>();
    UserCtrl userCtrl = Get.find<UserCtrl>();
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
                          return FutureBuilder(
                            future: mediaList.isEmpty
                                ? Future.sync(() => null)
                                : mediaList[i].thumbnailDataWithSize(
                                    const ThumbnailSize(110, 110),
                                  ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return mediaList.isNotEmpty
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
                        imageUrl: userCtrl.user.photo,
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
          homeCtrl.stories.isNotEmpty
              ? !homeCtrl.isLoading
                  ? ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                      itemCount: homeCtrl.stories.length,
                      itemBuilder: (context, index) {
                        final StoryModel storyData = homeCtrl.stories[index];
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: DisplayImageVideoCard(
                                      file: storyData.stories[0].story!,
                                      type: storyData.stories[0].type!,
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
                    )
                  : Container()
              : Container(),
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
  HomeCtrl homeCtrl = Get.find<HomeCtrl>();
  UserCtrl userCtrl = Get.find<UserCtrl>();

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

    return ListView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: homeCtrl.posts.length,
      itemBuilder: (context, index) {
        PostModel postData = homeCtrl.posts[index];
        List<Posts> posts = postData.posts!;
        bool meLike = postData.likes!.contains(Get.find<UserCtrl>().user.id);
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
                                  Get.toNamed(
                                    Routes.PROFILE,
                                    arguments: postData.userData!.id,
                                  );
                                },
                                child: Row(
                                  children: [
                                    ProfileAvatar(
                                      imageUrl: postData.userData!.photo,
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
                                        SizedBox(
                                            height: Dimensions.height10 - 5),
                                        TextCustom(
                                          text: timeAgoCustom(
                                            DateTime.fromMillisecondsSinceEpoch(
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
                        userCtrl.user.id == postData.userId
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      SingleChildScrollView(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius15),
                                            color: Get.isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                            top: 4,
                                          ),
                                          width: Dimensions.screenWidth,
                                          height: Dimensions.height10 * 15,
                                          child: Column(
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  height: 6,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Get.isDarkMode
                                                        ? Colors.grey[600]
                                                        : Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              AppComponent.buildbottomsheet(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: AppColors.primary,
                                                ),
                                                label: "Modify post",
                                                ontap: () {
                                                  Get.to(
                                                    () =>
                                                        const ModifyPostScreen(),
                                                    arguments: postData,
                                                  );
                                                },
                                              ),
                                              Divider(
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              AppComponent.buildbottomsheet(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                label: "Delete post",
                                                ontap: () {
                                                  AppComponent.showDialog(
                                                    title: "delete Post",
                                                    description:
                                                        "Are you sure to delete this post ?",
                                                    onPressed: () {
                                                      homeCtrl.deletePost(
                                                        postId: postData.id!,
                                                      );
                                                      Get.back();
                                                      Get.back();
                                                    },
                                                    color: Colors.red,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      elevation: 0.4,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.more_vert_rounded,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ExpandableTextWidget(
                    text: postData.description!,
                  ),
                ),
                postData.posts!.isNotEmpty
                    ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          SizedBox(
                            height: 400,
                            child: CarouselSlider.builder(
                                itemCount: postData.posts!.length,
                                options: CarouselOptions(
                                  viewportFraction: 1.0,
                                  enableInfiniteScroll: false,
                                  height: 400,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: false,
                                ),
                                itemBuilder: (context, i, realIndex) =>
                                    DisplayImageVideoCard(
                                      file: posts[i].post!,
                                      type: posts[i].type!,
                                      isOut: false,
                                    )),
                          ),
                          Positioned(
                            top: Dimensions.height10,
                            left: Dimensions.height10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                postData.posts!.length > 1
                                    ? const Icon(
                                        Icons.layers_outlined,
                                        size: 30,
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              height: 45,
                              width: Dimensions.screenWidth * .9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 5.0, sigmaY: 5.0),
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
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        isLike = !isLike;
                                                      });
                                                      homeCtrl.postLike(
                                                        postData.id!,
                                                      );
                                                    },
                                                    child: Icon(
                                                      (meLike || isLike)
                                                          ? Icons
                                                              .favorite_outlined
                                                          : Icons
                                                              .favorite_border_outlined,
                                                      color: (meLike || isLike)
                                                          ? Colors.red
                                                          : Colors.white,
                                                    )),
                                                const SizedBox(width: 8.0),
                                                GestureDetector(
                                                  onTap: () async {
                                                    if (postData
                                                        .likes!.isNotEmpty) {
                                                      List<Auth>
                                                          userLikes = [];
                                                      for (var i = 0;
                                                          i <
                                                              postData.likes!
                                                                  .length;
                                                          i++) {
                                                        userLikes.add(await Get
                                                                .find<
                                                                    AuthController>()
                                                            .getUserData(
                                                                postData.likes![
                                                                    i]));
                                                      }
                                                      Get.toNamed(
                                                        Routes.LIKES,
                                                        arguments: userLikes,
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
                                            GestureDetector(
                                              onTap: () {
                                                Get.find<HomeCtrl>()
                                                    .fetchAllPostComment(
                                                        postData.id!);
                                                Get.toNamed(
                                                  Routes.POST_COMMENTS,
                                                  arguments: postData.id,
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
                      )
                    : SizedBox(
                        height: 45,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          color: Colors.grey.withOpacity(0.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isLike = !isLike;
                                            });
                                            homeCtrl.postLike(
                                              postData.id!,
                                            );
                                          },
                                          child: Icon(
                                            (meLike || isLike)
                                                ? Icons.favorite_outlined
                                                : Icons
                                                    .favorite_border_outlined,
                                            color: (meLike || isLike)
                                                ? Colors.red
                                                : context.theme.dividerColor,
                                          )),
                                      const SizedBox(width: 8.0),
                                      GestureDetector(
                                        onTap: () async {
                                          if (postData.likes!.isNotEmpty) {
                                            List<Auth> userLikes = [];
                                            for (var i = 0;
                                                i < postData.likes!.length;
                                                i++) {
                                              userLikes.add(
                                                  await Get.find<AuthController>()
                                                      .getUserData(
                                                          postData.likes![i]));
                                            }
                                            Get.toNamed(
                                              Routes.LIKES,
                                              arguments: userLikes,
                                            );
                                          }
                                        },
                                        child: TextCustom(
                                          text: postData.likes!.isEmpty
                                              ? "Like"
                                              : postData.likes!.length
                                                  .toString(),
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 20.0),
                                  GestureDetector(
                                    onTap: () {
                                      Get.find<HomeCtrl>()
                                          .fetchAllPostComment(postData.id!);
                                      Get.toNamed(
                                        Routes.POST_COMMENTS,
                                        arguments: postData.id,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/message-icon.svg',
                                          color: context.theme.dividerColor,
                                        ),
                                        const SizedBox(width: 5.0),
                                        const TextCustom(
                                          text: "Comment",
                                          fontSize: 16,
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
                                      color: context.theme.dividerColor,
                                      height: 24,
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
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
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
