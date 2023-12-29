import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import '../models/story_model.dart';

abstract class HomeLocalDataSource {
  Future<Unit> saveAllPosts(List<PostModel> posts);
  List<PostModel> getAllPosts();
  Future<bool> clearAllPosts();

  Future<Unit> saveAllStories(List<StoryModel> stories);
  List<StoryModel> getAllStories();
  Future<bool> clearAllStories();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SharedPreferences sharedPreferences;
  HomeLocalDataSourceImpl(this.sharedPreferences);

  final postsKey = 'posts-key';
  final storiesKey = 'stories-key';
  
  @override
  Future<Unit> saveAllPosts(List<PostModel> posts) async {
    try {
      List<String> postsList = posts.map((item) => jsonEncode(item.toJson())).toList();
      await sharedPreferences.setStringList(postsKey, postsList);
      return Future.value(unit);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
  List<PostModel> getAllPosts() {
    try {
      List<String>? rawData = sharedPreferences.getStringList(postsKey);
      return rawData!.map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }
  
  @override
  Future<bool> clearAllPosts() async {
    try {
      return await sharedPreferences.remove(postsKey);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
  Future<Unit> saveAllStories(List<StoryModel> stories) async {
    try {
      List<String> storiesList = stories.map((item) => jsonEncode(item.toJson())).toList();
      await sharedPreferences.setStringList(storiesKey, storiesList);
      return Future.value(unit);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }

  @override
  List<StoryModel> getAllStories() {
    try {
      List<String>? rawData = sharedPreferences.getStringList(storiesKey);
      return rawData!.map((e) => StoryModel.fromJson(e)).toList();
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }
  

  @override
  Future<bool> clearAllStories() async {
    try {
      return await sharedPreferences.remove(storiesKey);
    } catch (e) {
      throw LocalException(messageError: e.toString());
    }
  }
}
