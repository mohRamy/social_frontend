import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/core/utils/app_strings.dart';

import '../models/post_model.dart';

class LocalSource {
  final SharedPreferences sharedPreferences;
  LocalSource({
    required this.sharedPreferences,
  });

  String post = '';

  Future<void> addToPostList(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toMap())
        .toList();
    sharedPreferences.setString(AppString.CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value();
  }

  Future<List<PostModel>> getPostList() {
    final jsonString = sharedPreferences.getString(AppString.CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
      .map<PostModel>((jsonPostModel) => PostModel.fromMap(jsonPostModel))
      .toList();
      return Future.value(jsonToPostModels);
    }else{
      throw Future.value();
    }
  }
}
