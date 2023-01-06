import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_app/core/enums/story_enum.dart';

import '../../../../core/utils/components/components.dart';
import '../../../../core/utils/constants/error_handling.dart';
import '../../../data/models/comment_model.dart';
import '../data_sources/story_remote_data_source.dart';
import 'package:http/http.dart' as http;


class StoryCtrl extends GetxController implements GetxService {
  final StoryRepo storyRepo;
  StoryCtrl({
    required this.storyRepo,
  });

  late List<Map<StoryEnum, File>> imageFileSelected = []; 

  List<CommentModel> storyComments = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late TextEditingController commentC;

  @override
  void onInit() {
    commentC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    commentC.clear();
    commentC.dispose();
    super.onClose();
  }

  void addStory({
    required List<Map<StoryEnum, File>> story,
  }) async {
    try {
      _isLoading = true;
      update();
      http.Response res = await storyRepo.addStory(
        story: story,
      );
      
      stateHandle(
        res: res,
        onSuccess: () {
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
      http.Response res = await storyRepo.fetchAllStoryComment(
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
    int isAdd,
  ) async {
    try {
      http.Response res = await storyRepo.storyLike(storyId, isAdd);

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
      http.Response res = await storyRepo.storyComment(
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
    int isAdd,
  ) async {
    try {
      http.Response res = await storyRepo.storyCommentLike(storyId, commentId, isAdd);

      stateHandle(
        res: res,
        onSuccess: () {},
      );
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
    }
  }
}