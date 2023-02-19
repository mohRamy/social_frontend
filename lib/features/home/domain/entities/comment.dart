import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String userId;
  final String comment;
  final List<String> likes;
  final int time;

  const Comment({
    required this.id,
    required this.userId,
    required this.comment,
    required this.likes,
    required this.time,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        comment,
        likes,
        time,
      ];
}
