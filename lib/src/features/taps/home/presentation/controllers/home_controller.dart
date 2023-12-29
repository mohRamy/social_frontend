import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../resources/local/user_local.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../../../core/enums/story_enum.dart';
import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../themes/app_colors.dart';
import '../../data/models/post_model.dart';
import '../../data/models/story_model.dart';
import '../../domain/usecases/change_post_like.dart';
import '../../domain/usecases/add_post_share.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_posts.dart';
import '../../domain/usecases/get_all_posts_socket.dart';
import '../../domain/usecases/get_all_stories.dart';

class HomeController extends GetxController
    with HandleLoading, WidgetsBindingObserver {
  final GetAllPostsUsecase getAllPostsUsecase;
  final GetAllPostsSocketUsecase getAllPostsSocketUsecase;
  final GetAllStoriesUsecase getAllStoriesUsecase;
  final ChangePostLikeUsecase changePostLikeUsecase;
  final AddPostShareUsecase addSharePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  HomeController(
    this.getAllPostsUsecase,
    this.getAllPostsSocketUsecase,
    this.getAllStoriesUsecase,
    this.changePostLikeUsecase,
    this.deletePostUsecase,
    this.addSharePostUsecase,
  );

  late List<AssetEntity> mediaList = [];

  late List<Map<StoryEnum, File>> imageFileSelected = [];

  List<String> postLikes = [];
  Map<String, int> countPostLikes = {};

  changeLike(String postId) {
    if (postLikes.contains(postId)) {
      postLikes.remove(postId);
      countPostLikes[postId] = countPostLikes[postId]! - 1;
    } else {
      postLikes.add(postId);
      countPostLikes[postId] = countPostLikes[postId]! + 1;
    }
    update();
  }

  List<String> storyLikes = [];
  Map<String, int> countStoryLikes = {};

  // addLike(String id) {
  //   likesPost.add(id);
  //   countLikePost[id] = countLikePost[id]! + 1;
  //   update();
  // }

  // removelike(String id) {
  //   likesPost.remove(id);
  //   countLikePost[id] = countLikePost[id]! - 1;
  //   update();
  // }

  late TextEditingController storyCommentController;
  late TextEditingController createPostController;

  Timer? fetchPostsTimer;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    _assetImagesDevice();
    getAllPosts();
    getAllStories();
    createPostController = TextEditingController();
    // fetchPostsTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
    //   getAllPostsSocket();
    // });
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    fetchPostsTimer?.cancel();
    // postCommentController.dispose();
    createPostController.dispose();
    super.onClose();
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      if (albums.isNotEmpty) {
        List<AssetEntity> photos =
            await albums[0].getAssetListPaged(page: 0, size: 90);
        mediaList = photos;
        update();
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  var userState = false.obs;

  void setUserState(bool newState) {
    userState.value = newState;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        setUserState(false);
        break;
    }
  }

  RxList<PostModel> posts = <PostModel>[].obs;
  FutureOr<void> getAllPosts() async {
    final result = await getAllPostsUsecase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        posts.value = r;
        for (var i = 0; i < r.length; i++) {
          if (r[i].likes.contains(UserLocal().getUserId())) {
            postLikes.add(r[i].id);
          }
          countPostLikes[r[i].id] = r[i].likes.length;
        }
      },
    );
    update();
  }

  FutureOr<void> getAllPostsSocket() async {
    final result = await getAllPostsSocketUsecase();
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    update();
  }

  void goneAllPosts(dynamic data) {
    List rawData = data;
    posts.value = rawData.map((e) => PostModel.fromMap(e)).toList();
    update();
  }

  List<StoryModel> stories = [];
  Future<List<StoryModel>> getAllStories() async {
    final result = await getAllStoriesUsecase();
    result.fold(
      (l) => handleLoading(l),
      (r) {
        stories = r;
        for (var i = 0; i < r.length; i++) {
          if (r[i].likes.contains(UserLocal().getUserId())) {
            storyLikes.add(r[i].id);
          }
          countStoryLikes[r[i].id] = r[i].likes.length;
        }
      },
    );
    update();
    return stories;
  }

  FutureOr<void> changePostLike(String postId) async {
    changeLike(postId);
    final result = await changePostLikeUsecase(postId);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        // FavoriteLocal().saveFavorites(likesPost);
      },
    );

    update();
  }

  void changedPostLike(dynamic data) {
    update();
  }

  FutureOr<void> addPostShare(String postId) async {
    final result = await addSharePostUsecase(postId);
    result.fold(
      (l) => handleLoading(l),
      (r) {},
    );

    update();
  }

  void addedPostShare(dynamic data) {
    update();
  }

  FutureOr<void> deletePost(String postId) async {
    showLoading();

    final result = await deletePostUsecase(postId);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        hideLoading();
        update();
        Components.showSnackBar(
          "Deleted your post",
          title: "Added Delete",
          color: colorPrimary,
        );
        getAllPosts();
        AppNavigator.pop();
      },
    );

    hideLoading();
    update();
  }
}
