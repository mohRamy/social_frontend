import 'dart:convert';

class CommentModel {
  final String id;
  final String userId;
  final String comment;
  final List<String> likes;
  final int time;
  CommentModel({
    required this.id,
    required this.userId,
    required this.comment,
    required this.likes,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'comment': comment,
      'likes': likes,
      'time': time,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['_id'] ?? '',
      userId: map['userId']??'',
      comment: map['comment'] ?? '',
      likes: List<String>.from(map['likes']??[]),
      time: map['time']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source));

  CommentModel copyWith({
    String? id,
    String? userId,
    String? comment,
    List<String>? likes,
    int? time,
  }) {
    return CommentModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      comment: comment ?? this.comment,
      likes: likes ?? this.likes,
      time: time ?? this.time,
    );
  }
}
