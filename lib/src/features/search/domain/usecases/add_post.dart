import 'package:dartz/dartz.dart';
import 'package:social_app/src/features/auth/data/models/auth_model.dart';

import '../../../../core/error/failures.dart';
import '../repository/base_search_repository.dart';

class SearchUserUseCase {
  final SearchRepository baseSearchRepository;
  SearchUserUseCase(this.baseSearchRepository);

  Future<Either<Failure, List<AuthModel>>> execute(String searchQuery) async {
    return await baseSearchRepository.searchUser(searchQuery);
  }

}
