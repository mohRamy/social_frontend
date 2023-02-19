import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:social_app/features/home/domain/entities/story.dart';

import '../../../auth/data/models/auth_model.dart';
import '../../../data/models/comment_model.dart';

class StoryModel extends Story {
  const StoryModel({
    required super.id,
    required super.userData,
    required super.createdAt,
    required super.stories,
    required super.likes,
    required super.comments,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['_id'] ?? map['id'],
      userData: AuthModel.fromJson(map['userData']),
      createdAt: DateTime.parse(map["createdAt"]),
      stories: List<StoriesModel>.from(
          map['stories']?.map((x) => StoriesModel.fromJson(x)) ?? []),
      likes: List<String>.from(map['likes']),
      comments: List<CommentMode>.from(
          map['comments']?.map((x) => CommentMode.fromMap(x)) ?? []),
    );
  }

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source));
}

class StoriesModel extends Stories {
  const StoriesModel({
    required super.story,
    required super.type,
  });

  factory StoriesModel.fromMap(Map<String, dynamic> map) {
    return StoriesModel(
      story: map['story'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['story'] = story;
    data['type'] = type;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory StoriesModel.fromJson(String source) =>
      StoriesModel.fromMap(json.decode(source));
}
