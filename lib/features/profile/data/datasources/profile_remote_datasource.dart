import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constance.dart';
import '../../../../core/utils/constants/state_handle.dart';
import '../../../home/data/models/post_model.dart';

import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> followUser(String userId);
  Future<List<Post>> getUserPost(String userId);
  Future<Unit> modifyMyData(Auth myData);
  Future<Unit> privateAccount();
  Future<Unit> changePassword(String currentPassword, String newPassword);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiClient apiClient;
  ProfileRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Unit> changePassword(
      String currentPassword, String newPassword) async {
    http.Response res = await apiClient.postData(
      ApiConstance.changePassword,
      jsonEncode({
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> followUser(String userId) async {
    http.Response res = await apiClient.postData(
      ApiConstance.followUser,
      jsonEncode({
        "userId": userId,
      }),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<List<Post>> getUserPost(String userId) async {
    http.Response res = await apiClient.getData(
      "${ApiConstance.getUserPost}?userId=$userId",
    );
    List<Post> posts = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          posts.add(
            PostModel.fromJson(
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
    return posts;
  }

  @override
  Future<Unit> modifyMyData(Auth myData) async {
    http.Response res = await apiClient.postData(
      ApiConstance.modifyMyInfo,
      jsonEncode(myData),
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }

  @override
  Future<Unit> privateAccount() async {
    http.Response res = await apiClient.updateData(
      ApiConstance.private,
    );
    stateErrorHandle(
      res: res,
      onSuccess: () {},
    );
    return Future.value(unit);
  }
}
