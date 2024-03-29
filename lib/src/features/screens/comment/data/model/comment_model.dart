import 'dart:convert';

import '../../domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.userId,
    required super.comment,
    required super.likes,
    required super.createdAt,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] ?? '',
      userId: map['userId']??'',
      comment: map['comment'] ?? '',
      likes: List<String>.from(map['likes']??[]),
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'comment': comment,
      'likes': likes,
    };
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));
}
