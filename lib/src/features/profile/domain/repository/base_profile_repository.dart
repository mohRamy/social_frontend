import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/home/data/models/post_model.dart';

import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> followUser(String userId);
  Future<Either<Failure, List<PostModel>>> getUserPosts();
  Future<Either<Failure, List<PostModel>>> getUserPostsById(String userId);
  Future<Either<Failure, Unit>> modifyMyData(Auth myData);
  Future<Either<Failure, Unit>> privateAccount();
  Future<Either<Failure, Unit>> changePassword(
      String currentPassword, String newPassword);
}
