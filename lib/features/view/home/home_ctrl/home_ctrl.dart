import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:social_app/core/network/network_info.dart';
import 'package:social_app/features/data/api/local_source.dart';
import 'package:social_app/features/data/models/story_model.dart';
import 'package:social_app/features/view/story/data_sources/story_local_data_source.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/post_model.dart';
import '../home_repo/home_repo.dart';

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  final NetworkInfo networkInfo;
  final PostLocalSource postLocalSource;
  final StoryLocalSource storyLocalSource;
  HomeCtrl({
    required this.homeRepo,
    required this.networkInfo,
    required this.postLocalSource,
    required this.storyLocalSource,
  });

  List<PostModel> posts = [];
  List<CommentModel> postComments = [];

  List<StoryModel> stories = [];
  

  late TextEditingController commentC;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    fetchAllStories();
    fetchAllPosts();
    commentC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    commentC.clear();
    commentC.dispose();
    super.onClose();
  }

  Future<void> fetchAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await homeRepo.fetchAllPosts();
        stateHandle(
          res: res,
          onSuccess: () {
            posts = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              posts.add(
                PostModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            postLocalSource.addToPostList(posts);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        posts = await postLocalSource.getPostList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  void updatePost({
    required String description,
    required String postUrl,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.updatePost(
        description: description,
        postUrl: postUrl,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Modified Post!',
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void deletePost({
    required String postId,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.deletePost(
        postId: postId,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          Components.showCustomSnackBar(
            title: '',
            'Deleted Post!',
            color: Colors.green,
          );
        },
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
    _isLoading = false;
    update();
  }

  void postLike(
    String postId,
    int isAdd,
  ) async {
    try {
      http.Response res = await homeRepo.postLike(postId, isAdd);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void postComment(
    String postId,
    String comment,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.postComment(
        postId,
        comment,
      );

      stateHandle(
        res: res,
        onSuccess: () {},
      );
      _isLoading = false;
      update();
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  Future<List<CommentModel>> fetchAllPostComment(
    String postId,
  ) async {
    List<CommentModel> postComments = [];
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.fetchAllPostComment(
        postId,
      );
      stateHandle(
        res: res,
        onSuccess: () async {
          postComments = [];
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            postComments.add(
              CommentModel.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        },
      );
      _isLoading = false;
      update();
      return postComments;
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
      return Future.value();
    }
  }

  void postCommentLike(
    String postId,
    String commentId,
    int isAdd,
  ) async {
    try {
      http.Response res = await homeRepo.postCommentLike(postId, commentId, isAdd);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  Future<void> fetchAllStories() async {
    if (await networkInfo.isConnected) {
      try {
        _isLoading = true;
        update();
        http.Response res = await homeRepo.fetchAllStories();
        stateHandle(
          res: res,
          onSuccess: () {
            stories = [];
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              stories.add(
                StoryModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            storyLocalSource.addToStoryList(stories);
          },
        );
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    } else {
      try {
        _isLoading = true;
        update();
        stories = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  
}
