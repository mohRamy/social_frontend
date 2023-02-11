
import 'dart:convert';

import 'comment_model.dart';
import 'user_model.dart';

class StoryModel {
  String id;
  UserModel userData;
  DateTime createdAt;
  List<Stories> stories;
  List<String> likes;
  List<CommentModel> comments;

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
    userData: UserModel.fromMap(map['userData']),
    createdAt: DateTime.parse(map["createdAt"]),
    stories : List<Stories>.from(map['stories']?.map((x) => Stories.fromJson(x))??[]),
    likes : List<String>.from(map['likes']),
    comments: List<CommentModel>.from(map['comments']?.map((x) => CommentModel.fromMap(x))??[]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userData': userData.toMap(),
      'comments': comments,
      'likes': likes,
      'createdAt': createdAt,
      'stories': stories.map((v) => v.toJson()).toList(),

    };
  }

  String toJson() => json.encode(toMap());

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