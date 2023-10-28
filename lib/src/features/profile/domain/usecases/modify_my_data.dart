import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../auth/domain/entities/auth.dart';
import '../repository/base_profile_repository.dart';

class UpdataUserInfoUseCase {
  final ProfileRepository baseProfileRepository;
  UpdataUserInfoUseCase(this.baseProfileRepository);

  Future<Either<Failure, Unit>> call(Auth myData) async {
    return await baseProfileRepository.modifyMyData(myData);
  }
}
