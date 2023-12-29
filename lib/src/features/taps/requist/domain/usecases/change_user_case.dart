import 'package:dartz/dartz.dart';
import '../repository/base_requist_repository.dart';

import '../../../../../core/error/failures.dart';

class ChangeUserCaseRequistUseCase {
  final RequistRepository baseRequistRepository;
  ChangeUserCaseRequistUseCase(this.baseRequistRepository);

  Future<Either<Failure, Unit>> call(String userId, bool isDelete) async {
    return await baseRequistRepository.changeUserCase(userId, isDelete);
  }
}