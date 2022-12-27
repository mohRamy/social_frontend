import 'dart:convert';

import 'user_model.dart';

class CommentModel {
  final String id;
  final UserModel userData;
  final String comment;
  final int likes;
  CommentModel({
    required this.id,
    required this.userData,
    required this.comment,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userData': userData.toMap(),
      'comment': comment,
      'like': likes,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] ?? '',
      userData: UserModel.fromMap(map['userData']),
      comment: map['comment'] ?? '',
      likes: map['like']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));

  CommentModel copyWith({
    String? id,
    UserModel? userData,
    String? comment,
    int? like,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userData: userData ?? this.userData,
      comment: comment ?? this.comment,
      likes: like ?? this.likes,
    );
  }
}
