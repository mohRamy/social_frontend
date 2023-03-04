import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_constance.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../../auth/domain/entities/auth.dart';

import '../../../../core/utils/constants/state_handle.dart';

abstract class BaseSearchRemoteDataSource {
  Future<List<Auth>> searchUser(String searchQuery);
}

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  final ApiClient apiClient;
  SearchRemoteDataSource(this.apiClient);

  @override
  Future<List<Auth>> searchUser(String searchQuery) async {
    http.Response res = await apiClient.getData(
      "${ApiConstance.searchUser}/$searchQuery",
    );

    List<Auth> users = [];
    stateErrorHandle(
      res: res,
      onSuccess: () {
        for (var i = 0; i < jsonDecode(res.body).length; i++) {
          users.add(
            AuthModel.fromJson(
              jsonEncode(
                jsonDecode(
                  res.body,
                )[i],
              ),
            ),
          );
        }
      },
    );
    return users;
  }
}
