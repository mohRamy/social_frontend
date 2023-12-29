import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../repository/base_profile_repository.dart';
class UpdateAvatarUseCase {
  final ProfileRepository baseProfileRepository;
  UpdateAvatarUseCase(this.baseProfileRepository);

  Future<Either<Failure, Unit>> call(String photo, bool isPhoto) async {
    return await baseProfileRepository.updateAvatar(photo, isPhoto);
  }
}