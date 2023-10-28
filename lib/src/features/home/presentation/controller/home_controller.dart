import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/src/features/auth/domain/entities/auth.dart';
import 'package:social_app/src/features/home/data/models/comment_model.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';
import 'package:social_app/src/resources/local/favorite_local.dart';
import 'package:social_app/src/resources/local/user_local.dart';
import '../../../../controller/app_controller.dart';
import '../../../../public/components.dart';
import '../../../../core/error/handle_error_loading.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/add_story.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_posts.dart';
import '../../domain/usecases/get_all_post_comment.dart';
import '../../domain/usecases/get_all_stories.dart';
import '../../domain/usecases/get_all_story_comment.dart';
import '../../domain/usecases/add_comment_post.dart';
import '../../domain/usecases/add_like_comment_post.dart';
import '../../domain/usecases/add_like_post.dart';
import '../../domain/usecases/story_comment_like.dart';
import '../../domain/usecases/update_post.dart';

import '../../../../core/enums/story_enum.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/add_comment_Story.dart';
import '../../domain/usecases/story_like.dart';

class HomeController extends GetxController with HandleErrorLoading {
  // post
  final GetAllPostsUsecase getAllPostsUsecase;
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

  addLike(String id) {
    likesPost.add(id);
    update();
  }

  removelike(String id) {
    likesPost.remove(id);
    update();
  }

  List<String> likesCommentPost = [];

  setLikeCommentPost(String id) {
    likesCommentPost.add(id);
    update();
  }

  removelikeCommentPost(String id) {
    likesCommentPost.remove(id);
    update();
  }

  late TextEditingController postCommentController;
  late TextEditingController storyCommentController;

    Timer? fetchPostsTimer;
  
  @override
  void onInit() {
    getAllPosts();
    fetchPostsTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getAllPosts();
    });
    super.onInit();
  }

  @override
  void onClose() {
    fetchPostsTimer?.cancel();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   getAllStories();
  //   getAllPosts();
  //   postCommentController = TextEditingController();
  //   storyCommentController = TextEditingController();
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   postCommentController.dispose();
  //   storyCommentController.dispose();
  //   super.onClose();
  // }

  
  FutureOr<void> getAllPosts() async {
    final result = await getAllPostsUsecase();
    result.fold(
      (l) => Components.showSnackBar(l.message),
      (r) => null,
    );
    update();
  }

    RxList<Post> posts = <Post>[].obs;
    void goneAllPosts (dynamic data){
        List rawData = data;
        posts.value = rawData.map((e) => PostModel.fromMap(e)).toList();
        // if (posts.isNotEmpty) {
        //   for (var i = 0; i < data.length; i++) {
        //   if (data[i].likes.contains(UserLocal().getUserId())) {
        //     likesPost.add(data[i].id);
        //   }
        // for (var i = 0; i < data.length; i++) {
        //   countLikePost[data[i].id] = data[i].likes.length;
        // }
        // }
        // }
    update();
  }

  FutureOr<void> udpatePost(String postId, String description) async {
    showLoading();

    final result = await modifyPostUsecase(postId, description);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );
    hideLoading();
    update();
  }

  FutureOr<void> deletePost(String postId) async {
    showLoading();

    final result = await deletePostUsecase(postId);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );

    hideLoading();
    update();
  }

  FutureOr<void> addLikePost(String postId) async {
    final result = await addLikePostUsecase(postId);
    result.fold(
      (l) => handleError(l),
      (r) {
        FavoriteLocal().saveFavorites(likesPost);
      },
    );

    update();
  }

    Map<String, int> countLikePost = {};
    void addedLikePost (dynamic data){
    Post post = PostModel.fromMap(data);
    countLikePost[post.id] = post.likes.length;
    update();
  }

  FutureOr<void> addCommentPost(String postId, String comment) async {
    final result = await addCommentPostUsecase(postId, comment);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );

    update();
  }

  void addedCommentPost (dynamic data){
    List rawData = data;
    List<Comment> postsComment = rawData.map((e) => CommentModel.fromMap(e)).toList();
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
    result.fold(
      (l) => handleError(l),
      (r) {
        for (var i = 0; i < r.length; i++) {
          if (r[i].likes.contains(UserLocal().getUserId())) {
            likesCommentPost.add(r[i].id);
          }
        }
        for (var i = 0; i < r.length; i++) {
          countLikeCommentPost[r[i].id] = r[i].likes.length;
        }
        postComments = r;
        }
    );
    update();
  }

  FutureOr<void> addLikeCommentPost(String postId, String commentId) async {
    final result = await addLikeCommentPostUsecase(postId, commentId);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );
    update();
  }
    
    Map<String, int> countLikeCommentPost = {};
    void addedLikeCommentPost(dynamic data) async {
    Comment comment = CommentModel.fromMap(data);
    countLikeCommentPost[comment.id] = comment.likes.length;
    update();
  }

  List<Story> stories = [];
  Future<List<Story>> getAllStories() async {
    final result = await getAllStoriesUsecase();
    result.fold(
      (l) => handleError(l),
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

      int random = Random().nextInt(1000);

      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      for (var i = 0; i < itemsVal.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            itemsVal[i].path,
            folder: "$random",
          ),
        );
        storiesUrl.add(res.secureUrl);
      }

      final result = await addStoryUsecase(storiesUrl, storiesType);
      result.fold(
        (l) => handleError(l),
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
      (l) => handleError(l),
      (r) => storyCommentList = r,
    );

    update();
  }

  FutureOr<void> storyLike(String storyId) async {
    final result = await storyLikeUsecase(storyId);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );

    update();
  }

  FutureOr<void> storyComment(String storyId, String comment) async {
    final result = await storyCommentUsecase(storyId, comment);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );

    update();
  }

  void storyCommentLike(String storyId, String commentId) async {
    final result = await storyCommentLikeUsecase(storyId, commentId);
    result.fold(
      (l) => handleError(l),
      (r) => null,
    );

    update();
  }

  Future<List<Auth>> likesUser(List<String> usersId) async {
    List<Auth> users = [];
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
