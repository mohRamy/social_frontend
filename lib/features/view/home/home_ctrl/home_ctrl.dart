import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_app/core/network/network_info.dart';
import 'package:social_app/features/data/api/local_source.dart';
import 'package:social_app/features/data/models/comment_model.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/post_model.dart';
import '../home_repo/home_repo.dart';

class HomeCtrl extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  final NetworkInfo networkInfo;
  final LocalSource localSource;
  HomeCtrl({
    required this.homeRepo,
    required this.networkInfo,
    required this.localSource,
  });

  List<PostModel> posts = [];
  List<CommentModel> comments = [];

  late TextEditingController commentC;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
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
            print(res.body);
            print('ooooooooooooooooooooooooooooooooooooooooooooooooo');
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              posts.add(
                PostModel.fromMap(
                  jsonDecode(res.body)[i],
                ),
              );
            }
            localSource.addToPostList(posts);
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
        posts = await localSource.getPostList();
        _isLoading = false;
        update();
      } catch (e) {
        Components.showCustomSnackBar(e.toString());
      }
    }
  }

  void postLike(
    String postId,
    int isAdd,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.postLike(postId, isAdd);

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

  Future<void> fetchAllComment(
    String postId,
  ) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await homeRepo.fetchAllComment(
        postId,
      );
      stateHandle(
        res: res,
        onSuccess: () async {
          comments = [];
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            comments.add(
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
}
