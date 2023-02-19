
import 'dart:convert';

import 'package:social_app/features/auth/data/models/auth_model.dart';

import '../../auth/domain/entities/auth.dart';
import 'comment_model.dart';
import 'user_model.dart';

class StoryModel {
  String id;
  Auth userData;
  DateTime createdAt;
  List<Stories> stories;
  List<String> likes;
  List<CommentMode> comments;

  StoryModel({
    required this.id,
    required this.userData,
    required this.createdAt,
    required this.stories,
    required this.likes,
    required this.comments,
  });

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
    id: map['_id']??map['id'],
    userData: AuthModel.fromJson(map['userData']),
    createdAt: DateTime.parse(map["createdAt"]),
    stories : List<Stories>.from(map['stories']?.map((x) => Stories.fromJson(x))??[]),
    likes : List<String>.from(map['likes']),
    comments: List<CommentMode>.from(map['comments']?.map((x) => CommentMode.fromMap(x))??[]),
    );
  }

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source));
}

class Stories {
  String? story;
  String? type;

  
  Stories.fromJson(Map<String, dynamic> json) {
    story = json['story'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['story'] = story;
    data['type'] = type;
    return data;
  }
}