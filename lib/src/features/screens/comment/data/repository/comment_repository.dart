import 'package:dartz/dartz.dart';
import '../datasources/comment_remote_datasource.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/network/network_info.dart';
import '../../../../screens/comment/domain/entities/comment.dart';
import '../../domain/repository/base_comment_repository.dart';

typedef GetMessage = Future<Unit> Function();

class CommentRepositoryImpl extends CommentRepository {
  final CommentRemoteDataSource baseCommentRemoteDataSource;
  final NetworkInfo networkInfo;
  CommentRepositoryImpl(
    this.baseCommentRemoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, List<Comment>>> getComments(
    String itemId,
    String itemType,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await baseCommentRemoteDataSource.getComments(
          itemId,
          itemType,
        );
        return Right(result);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(
    String itemId,
    String itemType,
    String comment,
  ) async {
    return await _getMessage(() {
      return baseCommentRemoteDataSource.addComment(itemId, itemType, comment );
    });
  }

  @override
  Future<Either<Failure, Unit>> changeCommentLike(
    String itemId,
    String itemType,
    String commentId,
  ) async {
    return await _getMessage(() {
      return baseCommentRemoteDataSource.changeCommentLike(itemId, itemType, commentId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(GetMessage getMessage) async {
    if (await networkInfo.isConnected) {
      try {
        await getMessage();
        return const Right(unit);
      } on ServerException catch (failure) {
        return Left(ServerFailure(message: failure.messageError));
      }
    } else {
      return const Left(OfflineFailure(message: "Offline failure"));
    }
  }
}
