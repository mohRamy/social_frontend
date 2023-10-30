import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../features/home/data/models/story_model.dart';
import '../../features/home/domain/entities/story.dart';

class PostLocal {
  final _getStorage = GetStorage();
  final storiesKey = 'stories';
  
  void saveStories(List<Story> stories) async {
    _getStorage.write(storiesKey, stories);
  }

  List<Story?> getStories() {
    var response = _getStorage.read(storiesKey);    
    if (response != null) {
      List<Story> stories = [];
      List rawData = response;
      stories = rawData.map((e) => StoryModel.fromMap(json.decode(e))).toList();
      return stories;
    }
    return [];
  }

  void clearStories() async {
    _getStorage.remove(storiesKey);
  }
}
