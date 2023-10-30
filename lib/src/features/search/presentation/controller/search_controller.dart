import 'package:get/get.dart';

import '../../../../core/error/handle_error_loading.dart';
import '../../../../public/components.dart';
import '../../../auth/domain/entities/auth.dart';
import '../../domain/usecases/add_post.dart';


class SearchControlle extends GetxController with HandleErrorLoading {
  final SearchUserUseCase searchUserUseCase;
  SearchControlle({
    required this.searchUserUseCase,
  });

  @override
  void onInit() {
    users.value = [];
    super.onInit();
  }
  
  RxList<Auth> users = <Auth>[].obs;
  RxString searchQuery = ''.obs;

  Future<void> fetchSearchUsers({String? query}) async {
  try {
    final result = await searchUserUseCase.execute(query!);

    result.fold(
      (l) => handleError(l),
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
