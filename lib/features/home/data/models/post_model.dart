import 'dart:convert';
import '../../domain/entities/post.dart';

import '../../../auth/data/models/auth_model.dart';
import 'comment_model.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.userData,
    required super.userId,
    required super.time,
    required super.posts,
    required super.likes,
    required super.comments,
    super.description,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['_id'] ?? map['id'],
      userData: AuthModel.fromMap(map['userData']),
      userId: map['userId'] ?? '',
      time: map['time'] ?? 0,
      posts: List<PostsModel>.from(
          map['posts']?.map((x) => PostsModel.fromMap(x)) ?? []),
      likes: List<String>.from(map['likes'] ?? []),
      comments: List<CommentModel>.from(
          map['comments']?.map((x) => CommentModel.fromMap(x)) ?? []),
      description: map['description'] ?? "",
    );
  }

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));
}

class PostsModel extends Posts {
  const PostsModel({
    required super.post,
    required super.type,
  });

  factory PostsModel.fromMap(Map<String, dynamic> map) {
    return PostsModel(
      post: map['post'],
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post'] = post;
    data['type'] = type;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMap(json.decode(source));
}
