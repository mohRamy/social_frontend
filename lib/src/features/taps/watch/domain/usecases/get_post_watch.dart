import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/taps/watch/domain/repository/base_watch_repository.dart';

import '../../../../../core/error/failures.dart';

class GetPostWatchUseCase {
  final WatchRepository baseWatchRepository;
  GetPostWatchUseCase(this.baseWatchRepository);

  Future<Either<Failure, Unit>> call() async {
    return await baseWatchRepository.getPostWatch();
  }
}