import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/screens/auth/data/models/auth_model.dart';
import 'package:social_app/src/features/screens/update_info/domain/repository/base_update_info_repository.dart';

import '../../../../../core/error/failures.dart';

class UpdateInfoUseCase {
  final UpdateInfoRepository baseUpdateInfoRepository;
  UpdateInfoUseCase(this.baseUpdateInfoRepository);

  Future<Either<Failure, Unit>> call(AuthModel userInfo) async {
    return await baseUpdateInfoRepository.updateInfo(
      userInfo,
    );
  }
}
