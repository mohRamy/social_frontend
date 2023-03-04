import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_app/core/utils/app_colors.dart';
import 'package:social_app/core/utils/app_component.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constance.dart';

import '../../../../core/utils/constants/state_handle.dart';

abstract class PostRemoteDataSource {
  Future<Unit> addPost(String description, List<String> postsUrl, List<String> postsType);
}

class PostRemoteDataSourceImpl extends PostRemoteDataSource {
  final ApiClient apiClient;
  PostRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Unit> addPost(
      String description, List<String> postsUrl, List<String> postsType) async {
    http.Response res = await apiClient.postData(
      ApiConstance.addPost,
      jsonEncode({
        "description": description,
        "postsUrl": postsUrl,
        "postsType": postsType,
      }),
    );

    stateErrorHandle(
      res: res,
      onSuccess: () {
        AppComponent.showCustomSnackBar("added your post", color: AppColors.bgLightColor);
      },
    );
    return Future.value(unit);
  }
}
