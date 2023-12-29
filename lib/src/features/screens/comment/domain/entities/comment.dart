import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String userId;
  final String comment;
  final List<String> likes;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.userId,
    required this.comment,
    required this.likes,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        comment,
        likes,
        createdAt,
      ];
}
