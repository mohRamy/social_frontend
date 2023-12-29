import 'package:dartz/dartz.dart';
import '../repository/base_another_profile_repository.dart';

import '../../../../../core/error/failures.dart';

class ChangeUserCaseUseCase {
  final AnotherProfileRepository baseAnotherUserRepository;
  ChangeUserCaseUseCase(this.baseAnotherUserRepository);

  Future<Either<Failure, Unit>> call(String userId, bool isDelete) async {
    return await baseAnotherUserRepository.changeUserCase(userId, isDelete);
  }
}