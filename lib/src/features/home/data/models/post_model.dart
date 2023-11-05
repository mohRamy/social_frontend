import 'dart:convert';
import '../../domain/entities/post.dart';

import '../../../auth/data/models/auth_model.dart';
import 'comment_model.dart';

class PostModel {
  final String id;
  final AuthModel userData;
  final String userId;
  final int time;
  final List<Posts> posts;
  final List<String> likes;
  final List<CommentModel> comments;
  final List<String> shares;
  final String? description;
  const PostModel({
    required this.id,
    required this.userData,
    required this.userId,
    required this.time,
    required this.posts,
    required this.likes,
    required this.comments,
    required this.shares,
    this.description,
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
          shares: List<String>.from(map['likes'] ?? []),
      description: map['description'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userData': userData,
      'userId': userId,
      'posts': posts,
      'likes': likes,
      'comments': comments,
      'shared': shares,
      'description': description,
    };
  }

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
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
    return {
      'post': post,
      'type': type,
    };
  }

  factory PostsModel.fromJson(String source) =>
      PostsModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}
