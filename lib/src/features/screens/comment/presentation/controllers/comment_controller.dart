import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import '../../data/model/comment_model.dart';
import '../../domain/usecases/add_comment.dart';
import '../../domain/usecases/change_comment_like.dart';

import '../../domain/usecases/get_comments.dart';
import '../../../../../resources/local/user_local.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../domain/entities/comment.dart';

class CommentController extends GetxController with HandleLoading {
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUsecase;
  final ChangeCommentLikeUsecase changeCommentLikeUseCase;
  CommentController(
    this.getCommentsUseCase,
    this.addCommentUsecase,
    this.changeCommentLikeUseCase,
  );

  late TextEditingController commentController;

  @override
  void onInit() {
    commentController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  List<String> commentLikes = [];
  Map<String, int> countCommentLikes = {};

  changeLike(String commentId) {
    if (commentLikes.contains(commentId)) {
      commentLikes.remove(commentId);
      countCommentLikes[commentId] = countCommentLikes[commentId]! - 1;
    } else {
      commentLikes.add(commentId);
      countCommentLikes[commentId] = countCommentLikes[commentId]! + 1;
    }
    update();
  }

  List<Comment> comments = [];
  Future<List<Comment>> getComments(
    String itemId,
    String itemType,
  ) async {
    final result = await getCommentsUseCase(itemId, itemType);
    result.fold((l) => handleLoading(l), (r) {
      comments = r;
      for (var i = 0; i < r.length; i++) {
        if (r[i].likes.contains(UserLocal().getUserId())) {
          commentLikes.add(r[i].id);
        }
      }
      for (var i = 0; i < r.length; i++) {
        countCommentLikes[r[i].id] = r[i].likes.length;
      }
    });
    update();
    return comments;
  }

  FutureOr<void> addComment(
    String itemId,
    String itemType,
    String comment,
  ) async {
    commentController.text = '';
    final result = await addCommentUsecase(itemId, itemType, comment);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    update();
  }

  void addedComment(dynamic data) {
    CommentModel rawData = CommentModel.fromMap(data);
    comments.add(rawData);
    update();
  }

  FutureOr<void> changeCommentLike(
    String itemId,
    String itemType,
    String commentId,
  ) async {
    changeLike(commentId);
    final result = await changeCommentLikeUseCase(itemId, itemType, commentId);
    result.fold(
      (l) => handleLoading(l),
      (r) => null,
    );
    update();
  }

  void changedCommentLike(dynamic data) async {
    update();
  }
}
