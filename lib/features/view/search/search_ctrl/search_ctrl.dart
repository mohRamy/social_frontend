import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../core/utils/components/components.dart';
import '../../../../data/models/user_model.dart';

import '../search_repo/search_repo.dart';

import '../../../../core/utils/constants/error_handling.dart';

class SearchCtrl extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchCtrl({
    required this.searchRepo,
  });

  List<UserModel> users = [];

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

  Future<List<UserModel>> fetchSearchUser({
    required String searchQuery,
  }) async {
    List<UserModel> users = [];
    try {
      http.Response res =
          await searchRepo.fetchSearchUser(searchQuery: searchQuery);

      stateHandle(
        res: res,
        onSuccess: () {
          
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
            users.add(
              UserModel.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          
        },
      );
      update();
      
    } catch (e) {
      Components.showCustomSnackBar(e.toString());
      
    }
    return users;
  }
}
