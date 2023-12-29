import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../domain/entities/comment.dart';

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';
import '../../../../../services/socket/socket_emit.dart';
import '../model/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<Comment>> getComments(
    String itemId,
    String itemType,
  );
  Future<Unit> addComment(
    String itemId,
    String itemType,
    String comment,
  );
  Future<Unit> changeCommentLike(
    String itemId,
    String itemType,
    String commentId,
  );
}

class CommentRemoteDataSourceImpl extends CommentRemoteDataSource {
  final BaseRepository baseRepository;
  CommentRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<List<Comment>> getComments(
    String itemId,
    String itemType,
  ) async {
    diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.getComments}?itemId=$itemId&itemType=$itemType",
    );

    List<Comment> comments = [];

    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        comments = rawData.map((e) => CommentModel.fromMap(e)).toList();
      },
    );

    return comments;
  }

  @override
  Future<Unit> addComment(
    String itemId,
    String itemType,
    String comment,
  ) {
    SocketEmit().addCommentEmit(itemId, itemType, comment);
    return Future.value(unit);
  }

  @override
  Future<Unit> changeCommentLike(String itemId, itemType, commentId) {
    SocketEmit().changeCommentLikeEmit(itemId, itemType, commentId);
    return Future.value(unit);
  }
}
