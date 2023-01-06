import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/core/utils/app_strings.dart';

import '../../../data/models/story_model.dart';


class StoryLocalSource {
  final SharedPreferences sharedPreferences;
  StoryLocalSource({
    required this.sharedPreferences,
  });

  String story = '';

  Future<void> addToStoryList(List<StoryModel> storyModels) {
    List storyModelsToJson = storyModels
        .map<Map<String, dynamic>>((storyModel) => storyModel.toMap())
        .toList();
    sharedPreferences.setString(AppString.CACHED_STORIES, json.encode(storyModelsToJson));
    return Future.value();
  }

  Future<List<StoryModel>> getStoryList() {
    final jsonString = sharedPreferences.getString(AppString.CACHED_STORIES);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<StoryModel> jsonToStoryModels = decodeJsonData
      .map<StoryModel>((jsonStoryModel) => StoryModel.fromMap(jsonStoryModel))
      .toList();
      return Future.value(jsonToStoryModels);
    }else{
      throw Future.value();
    }
  }
}
