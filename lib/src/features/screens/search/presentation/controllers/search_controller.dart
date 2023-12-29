import 'package:get/get.dart';

import '../../../../../core/error/handle_error_loading.dart';
import '../../../../../public/components.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../domain/usecases/search.dart';

class SearchControlle extends GetxController with HandleLoading {
  final SearchUserUseCase searchUserUseCase;
  SearchControlle(
    this.searchUserUseCase,
  );

  @override
  void onInit() {
    users.value = [];
    super.onInit();
  }

  RxList<AuthModel> users = <AuthModel>[].obs;
  RxString searchQuery = ''.obs;

  Future<void> fetchSearchUsers({String? query}) async {
    try {
      final result = await searchUserUseCase.execute(query!);

      result.fold(
        (l) => handleLoading(l),
        (r) {
          users.value = r;
        },
      );

      update();
    } catch (e) {
      Components.showSnackBar(e.toString());
    }
  }

  void changeSearchStatus(String value) {
    searchQuery.value = value;

    if (value != '') {
      fetchSearchUsers(query: value);
    } else {
      users.value = [];
    }
  }
}
