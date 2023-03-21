import 'package:get/get.dart';
import '../../../../core/error/handle_error_loading.dart';

import '../../../auth/domain/entities/auth.dart';
import '../../domain/usecases/add_post.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/utils/app_component.dart';

class SearchController extends GetxController with HandleErrorLoading {
  final SearchUserUseCase searchUserUseCase;
  final ApiClient apiClient;
  SearchController({
    required this.searchUserUseCase,
    required this.apiClient,
  });
  
  List<Auth> users = [];
  
  void changeSearchStatus(String query) async {
    if (query != '') {
      users = await fetchSearchUser(
        searchQuery: query,
      );
    } else {
      users = [];
    }
    update();
  }

  Future<List<Auth>> fetchSearchUser({
    required String searchQuery,
  }) async {
    List<Auth> users = [];
    try {
      final result = await searchUserUseCase.execute(searchQuery);

    result.fold(
      (l) => handleError(l),
      (r) {
        for (var i = 0; i < r.length; i++) {
          users.add(r[i]);
        }
      },
    );
      update();
    } catch (e) {
      AppComponents.showCustomSnackBar(e.toString());
    }
    return users;
  }
}
