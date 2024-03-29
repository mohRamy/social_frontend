import 'dart:convert';

import '../../../../screens/auth/data/models/auth_model.dart';
import '../../domain/entities/story.dart';
import '../../../../screens/comment/data/model/comment_model.dart';

class StoryModel {
  final String id;
  final AuthModel userData;
  final DateTime createdAt;
  final List<Stories> stories;
  final List<String> likes;
  final List<CommentModel> comments;
  const StoryModel({
    required this.id,
    required this.userData,
    required this.createdAt,
    required this.stories,
    required this.likes,
    required this.comments,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['_id'] ?? map['id'],
      userData: AuthModel.fromMap(map['userData']),
      createdAt: DateTime.parse(map["createdAt"]),
      stories: List<StoriesModel>.from(
          map['stories']?.map((x) => StoriesModel.fromMap(x)) ?? []),
      likes: List<String>.from(map['likes']),
      comments: List<CommentModel>.from(
          map['comments']?.map((x) => CommentModel.fromMap(x)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userData': userData,
      'stories': stories,
      'likes': likes,
      'comments': comments,
    };
  }

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
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
