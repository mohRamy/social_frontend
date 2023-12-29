import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../auth/data/models/auth_model.dart';
import '../repository/base_search_repository.dart';

class SearchUserUseCase {
  final SearchRepository baseSearchRepository;
  SearchUserUseCase(this.baseSearchRepository);

  Future<Either<Failure, List<AuthModel>>> execute(String searchQuery) async {
    return await baseSearchRepository.searchUser(searchQuery);
  }

}
