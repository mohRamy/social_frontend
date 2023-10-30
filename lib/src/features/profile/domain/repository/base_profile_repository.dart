import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../../home/domain/entities/post.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> followUser(String userId);
  Future<Either<Failure, List<Post>>> getUserPosts();
  Future<Either<Failure, List<Post>>> getUserPostsById(String userId);
  Future<Either<Failure, Unit>> modifyMyData(Auth myData);
  Future<Either<Failure, Unit>> privateAccount();
  Future<Either<Failure, Unit>> changePassword(
      String currentPassword, String newPassword);
}
