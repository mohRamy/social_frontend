import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_home_repository.dart';

class AddStoryUsecase {
  final HomeRepository baseHomeRepository;
  AddStoryUsecase(this.baseHomeRepository);

  Future<Either<Failure, Unit>> call(List<String> storiesUrl, List<String> storiesType) async {
    return await baseHomeRepository.addStory(storiesUrl, storiesType);
  }
}