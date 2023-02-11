import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:social_app/core/network/network_info.dart';
import 'package:social_app/features/data/api/local_source.dart';
import 'package:social_app/features/data/models/story_model.dart';

import '../../../../core/enums/story_enum.dart';
import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/models/post_model.dart';
import '../home_repo/home_repo.dart';

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  final NetworkInfo networkInfo;
  final PostLocalSource postLocalSource;
  HomeCtrl({
    required this.homeRepo,
    required this.networkInfo,
    required this.postLocalSource,
  });

  List<PostModel> posts = [];
  // List<CommentModel> postComments = [];

  List<StoryModel> stories = [];
  List<CommentModel> storyComments = [];

  late List<Map<StoryEnum, File>> imageFileSelected = [];

  late TextEditingController postCommentC;
  late TextEditingController storyCommentC;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    fetchAllStories();
    fetchAllPosts();
    postCommentC = TextEditingController();
    storyCommentC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    postCommentC.dispose();
    storyCommentC.dispose();
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
  ) async {
    try {
      http.Response res = await homeRepo.postLike(postId);

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
  List<CommentModel> postComments = [];
  void fetchAllPostComment(
    String postId,
  ) async {
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
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void postCommentLike(
    String postId,
    String commentId,
  ) async {
    try {
      http.Response res =
          await homeRepo.postCommentLike(postId, commentId);

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
          //   print('dddddddddddddddddddddddddddddddddddd');
          //   Map<String, dynamic> options = {
          //     "transports": ["websocket"],
          //     "autoConnect": false,
          //   };
          //   Io.Socket socket = Io.io(AppString.STORY_GET_URL, options);
          //   socket.connect();
          //   socket.onConnect((_) {
          //     print('ooooooooooooooooooooooooSOCKETooooooooooooooooooooo');
          //   });
          //   socket.emit("msg", "hello my name is mohammed");
          //   socket.on("res", (data) => print(data));
          //   socket.onDisconnect((_) {
          //     print('ooooooooooooooooooooooooDISSOCKETooooooooooooooooooooo');
          //   });
          //   // storyLocalSource.addToStoryList(stories);
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
        // stories = await storyLocalSource.getStoryList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  void addStory({
    required List<Map<StoryEnum, File>> story,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.addStory(
        story: story,
      );

      stateHandle(
        res: res,
        onSuccess: () {
          imageFileSelected = [];
          Get.back();
          Components.showCustomSnackBar(
            title: '',
            'Added Post!',
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

  Future<void> fetchAllStoryComment(
    String storyId,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.fetchAllStoryComment(
        storyId,
      );
      stateHandle(
        res: res,
        onSuccess: () async {
          storyComments = [];
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            storyComments.add(
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
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void storyLike(
    String storyId,
  ) async {
    try {
      http.Response res = await homeRepo.storyLike(storyId);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }

  void storyComment(
    String storyId,
    String comment,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.storyComment(
        storyId,
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

  void storyCommentLike(
    String storyId,
    String commentId,
  ) async {
    try {
      http.Response res =
          await homeRepo.storyCommentLike(storyId, commentId);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}
