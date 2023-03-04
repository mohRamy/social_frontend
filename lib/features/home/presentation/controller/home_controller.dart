import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../auth/presentation/controller/user_controller.dart';
import '../../../../core/error/handle_error_loading.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/add_story.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_post.dart';
import '../../domain/usecases/get_all_post_comment.dart';
import '../../domain/usecases/get_all_stories.dart';
import '../../domain/usecases/get_all_story_comment.dart';
import '../../domain/usecases/post_comment.dart';
import '../../domain/usecases/post_comment_like.dart';
import '../../domain/usecases/post_like.dart';
import '../../domain/usecases/story_comment_like.dart';
import '../../domain/usecases/update_post.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/utils/app_component.dart';
import '../../domain/entities/story.dart';
import '../../domain/usecases/story_comment.dart';
import '../../domain/usecases/story_like.dart';

class HomeController extends GetxController with HandleErrorLoading {
  // post
  final GetAllPostsUsecase getAllPostsUsecase;
  final ModifyPostUsecase modifyPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final PostLikeUsecase postLikeUsecase;
  final PostCommentUsecase postCommentUsecase;
  final GetAllPostCommentUsecase getAllPostCommentUsecase;
  final PostCommentLikeUsecase postCommentLikeUsecase;
  // story
  final GetAllStoriesUsecase getAllStoriesUsecase;
  final AddStoryUsecase addStoryUsecase;
  final StoryLikeUsecase storyLikeUsecase;
  final StoryCommentUsecase storyCommentUsecase;
  final GetAllStoryCommentUsecase getAllStoryCommentUsecase;
  final StoryCommentLikeUsecase storyCommentLikeUsecase;
  HomeController({
    required this.getAllPostsUsecase,
    required this.modifyPostUsecase,
    required this.deletePostUsecase,
    required this.postLikeUsecase,
    required this.postCommentUsecase,
    required this.getAllPostCommentUsecase,
    required this.postCommentLikeUsecase,
    required this.getAllStoriesUsecase,
    required this.addStoryUsecase,
    required this.storyLikeUsecase,
    required this.storyCommentUsecase,
    required this.getAllStoryCommentUsecase,
    required this.storyCommentLikeUsecase,
  });

  late List<Map<StoryEnum, File>> imageFileSelected = [];

  late TextEditingController postCommentController;
  late TextEditingController storyCommentController;

  @override
  void onInit() {
    Get.lazyPut(()=> UserController());
    getAllStories();
    getAllPosts();
    postCommentController = TextEditingController();
    storyCommentController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    postCommentController.dispose();
    storyCommentController.dispose();
    super.onClose();
  }

  List<Post> posts = [];
  FutureOr<void> getAllPosts() async {
    final result = await getAllPostsUsecase();
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => posts = r,
    );

    update();
  }

  FutureOr<void> modifyPost(String postId, String description) async {
    showLoading();

    final result = await modifyPostUsecase(postId, description);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
    update();
  }

  FutureOr<void> deletePost(String postId) async {
    showLoading();

    final result = await deletePostUsecase(postId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
    update();
  }

  FutureOr<void> postLike(String postId) async {
    final result = await postLikeUsecase(postId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    update();
  }

  FutureOr<void> postComment(String postId, String comment) async {
    final result = await postCommentUsecase(postId, comment);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );
    
    update();
  }


  List<Comment> postCommentList = [];
  FutureOr<void> getAllPostComment(String postId) async {
    final result = await getAllPostCommentUsecase(postId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => postCommentList = r,
    );
    update();
  }

  FutureOr<void> postCommentLike(String postId, String commentId) async {
    final result = await postCommentLikeUsecase(postId, commentId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );
    update();
  }

  List<Story> stories = [];
  FutureOr<void> getAllStories() async {
    final result = await getAllStoriesUsecase();
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => stories = r,
    );
    update();
  }

  void addStory(List<Map<StoryEnum, File>> story) async {
    showLoading();
    List<StoryEnum> itemsKey = [];
    List<File> itemsVal = [];

    List<String> storiesType = [];

    List<String> storiesUrl = [];

    story
        .map((e) => e.forEach((key, value) {
              itemsKey.add(key);
            }))
        .toList();
    story
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
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
    update();
  }

  List<Comment> storyCommentList = [];
  FutureOr<void> getAllStoryComment(String storyId) async {
    showLoading();

    final result = await getAllStoryCommentUsecase(storyId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => storyCommentList = r,
    );

    hideLoading();
    update();
  }

  FutureOr<void> storyLike(String storyId) async {
    final result = await storyLikeUsecase(storyId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    update();
  }

  FutureOr<void> storyComment(String storyId, String comment) async {
    final result = await storyCommentUsecase(storyId, comment);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    update();
  }

  void storyCommentLike(String storyId, String commentId) async {
    showLoading();

    final result = await storyCommentLikeUsecase(storyId, commentId);
    result.fold(
      (l) => AppComponent.showCustomSnackBar(l.message),
      (r) => null,
    );

    hideLoading();
  }

  
}
