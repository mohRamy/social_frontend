import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';
import 'package:social_app/src/features/home/data/models/story_model.dart';
import 'package:social_app/src/resources/local/user_local.dart';

import '../../../../controller/app_controller.dart';
import '../../../../core/enums/story_enum.dart';
import '../../../../core/error/handle_error_loading.dart';
import '../../../../core/widgets/app_clouding.dart';
import '../../../../public/components.dart';
import '../../../../resources/local/favorite_local.dart';
import '../../data/models/comment_model.dart';
import '../../data/models/post_model.dart';
import '../../domain/entities/comment.dart';
import '../../domain/usecases/add_comment_Story.dart';
import '../../domain/usecases/add_comment_post.dart';
import '../../domain/usecases/add_like_comment_post.dart';
import '../../domain/usecases/add_like_post.dart';
import '../../domain/usecases/add_story.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_post_comment.dart';
import '../../domain/usecases/get_all_posts.dart';
import '../../domain/usecases/get_all_posts_socket.dart';
import '../../domain/usecases/get_all_stories.dart';
import '../../domain/usecases/get_all_story_comment.dart';
import '../../domain/usecases/story_comment_like.dart';
import '../../domain/usecases/story_like.dart';
import '../../domain/usecases/update_post.dart';

class HomeController extends GetxController with HandleLoading {
  // post
  final GetAllPostsUsecase getAllPostsUsecase;
  final GetAllPostsSocketUsecase getAllPostsSocketUsecase;
  final ModifyPostUsecase modifyPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final AddLikePostUsecase addLikePostUsecase;
  final AddCommentPostUsecase addCommentPostUsecase;
  final GetAllPostCommentUsecase getAllPostCommentUsecase;
  final AddLikeCommentPostUsecase addLikeCommentPostUsecase;
  // story
  final GetAllStoriesUsecase getAllStoriesUsecase;
  final AddStoryUsecase addStoryUsecase;
  final StoryLikeUsecase storyLikeUsecase;
  final AddCommentStoryUsecase storyCommentUsecase;
  final GetAllStoryCommentUsecase getAllStoryCommentUsecase;
  final StoryCommentLikeUsecase storyCommentLikeUsecase;
  HomeController({
    required this.getAllPostsUsecase,
    required this.getAllPostsSocketUsecase,
    required this.modifyPostUsecase,
    required this.deletePostUsecase,
    required this.addLikePostUsecase,
    required this.addCommentPostUsecase,
    required this.getAllPostCommentUsecase,
    required this.addLikeCommentPostUsecase,
    required this.getAllStoriesUsecase,
    required this.addStoryUsecase,
    required this.storyLikeUsecase,
    required this.storyCommentUsecase,
    required this.getAllStoryCommentUsecase,
    required this.storyCommentLikeUsecase,
  });

  late List<Map<StoryEnum, File>> imageFileSelected = [];

  List<String> likesPost = [];
  Map<String, int> countLikePost = {};

  addLike(String id) {
    likesPost.add(id);
    countLikePost[id] = countLikePost[id] !+ 1;
    update();
  }

  removelike(String id) {
    likesPost.remove(id);
    countLikePost[id] = countLikePost[id] !- 1;
    update();
  }

  List<String> likesCommentPost = [];
  Map<String, int> countLikeCommentPost = {};

  setCommentLike(String id) {
    likesCommentPost.add(id);
    countLikeCommentPost[id] = countLikeCommentPost[id] !+ 1;
    update();
  }

  removeCommentlike(String id) {
    likesCommentPost.remove(id);
    countLikeCommentPost[id] = countLikeCommentPost[id] !- 1;
    update();
  }

  late TextEditingController postCommentController;
  late TextEditingController storyCommentController;

  Timer? fetchPostsTimer;

  @override
  void onInit() {
    getAllPosts();
    fetchPostsTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getAllPostsSocket();
    });
    super.onInit();
  }

  @override
  void onClose() {
    fetchPostsTimer?.cancel();
    super.onClose();
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
          likesPost.add(r[i].id);
        }
        for (var i = 0; i < r.length; i++) {
          countLikePost[r[i].id] = r[i].likes.length;
        }
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

  FutureOr<void> udpatePost(String postId, String description) async {
    showLoading();

    final result = await modifyPostUsecase(postId, description);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    hideLoading();
    update();
  }

  FutureOr<void> deletePost(String postId) async {
    showLoading();

    final result = await deletePostUsecase(postId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    hideLoading();
    update();
  }

  FutureOr<void> addLikePost(String postId) async {
    final result = await addLikePostUsecase(postId);
    result.fold(
      (l) => handleLoading(l),
      (r) {
        FavoriteLocal().saveFavorites(likesPost);
      },
    );

    update();
  }

  
  void addedLikePost(dynamic data) {
    // PostModel post = PostModel.fromMap(data);
    // countLikePost[post.id] = post.likes.length;
    update();
  }

  FutureOr<void> addCommentPost(String postId, String comment) async {
    final result = await addCommentPostUsecase(postId, comment);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  void addedCommentPost(dynamic data) {
    List rawData = data;
    List<Comment> postsComment =
        rawData.map((e) => CommentModel.fromMap(e)).toList();
    for (var i = 0; i < postsComment.length; i++) {
      if (!postComments.contains(postsComment[i])) {
        postComments.add(postsComment[i]);
      }
    }
    update();
  }

  List<Comment> postComments = [];
  FutureOr<void> getAllPostComment(String postId) async {
    final result = await getAllPostCommentUsecase(postId);
    result.fold((l) => handleLoading(l), (r) {
      for (var i = 0; i < r.length; i++) {
        if (r[i].likes.contains(AppGet.authGet.userData!.id)) {
          likesCommentPost.add(r[i].id);
        }
      }
      for (var i = 0; i < r.length; i++) {
        countLikeCommentPost[r[i].id] = r[i].likes.length;
      }
      postComments = r;
    });
    update();
  }

  FutureOr<void> addLikeCommentPost(String postId, String commentId) async {
    final result = await addLikeCommentPostUsecase(postId, commentId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    update();
  }
  
  void addedLikeCommentPost(dynamic data) async {
    // Comment comment = CommentModel.fromMap(data);
    // countLikeCommentPost[comment.id] = comment.likes.length;
    // update();
  }

  List<StoryModel> stories = [];
  Future<List<StoryModel>> getAllStories() async {
    final result = await getAllStoriesUsecase();
    result.fold(
      (l) => handleLoading(l),
      (r) => stories = r,
    );
    update();
    return stories;
  }

  void addStory(List<Map<StoryEnum, File>> stories) async {
    try {
      showLoading();
      List<StoryEnum> itemsKey = [];
      List<File> itemsVal = [];

      List<String> storiesType = [];

      List<String> storiesUrl = [];

      stories
          .map((e) => e.forEach((key, value) {
                itemsKey.add(key);
              }))
          .toList();
      stories
          .map((e) => e.forEach((key, value) {
                itemsVal.add(value);
              }))
          .toList();

      for (var i = 0; i < itemsKey.length; i++) {
        switch (itemsKey[i]) {
          case StoryEnum.image:
            storiesType.add("image");
            break;
          case StoryEnum.video:
            storiesType.add("video");
            break;
          default:
            storiesType.add("image");
        }
      }

      for (var i = 0; i < itemsVal.length; i++) {        
          storiesUrl.add(await cloudinaryPuplic(itemsVal[i].path));
      }

      final result = await addStoryUsecase(storiesUrl, storiesType);
      result.fold(
        (l) => handleLoading(l),
        (r) => null,
      );

      hideLoading();
      update();
    } catch (e) {
      hideLoading();
      update();
      Components.showSnackBar(e.toString());
    }
  }

  List<Comment> storyCommentList = [];
  FutureOr<void> getAllStoryComment(String storyId) async {
    final result = await getAllStoryCommentUsecase(storyId);
    result.fold(
      (l) => handleLoading(l),
      (r) => storyCommentList = r,
    );

    update();
  }

  FutureOr<void> storyLike(String storyId) async {
    final result = await storyLikeUsecase(storyId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  FutureOr<void> storyComment(String storyId, String comment) async {
    final result = await storyCommentUsecase(storyId, comment);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  void storyCommentLike(String storyId, String commentId) async {
    final result = await storyCommentLikeUsecase(storyId, commentId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );

    update();
  }

  Future<List<AuthModel>> likesUser(List<String> usersId) async {
    List<AuthModel> users = [];
    for (var i = 0; i < usersId.length; i++) {
      users.add(
        await AppGet.authGet.fetchInfoUserById(
          usersId[i],
        ),
      );
    }
    update();
    return users;
  }
}
