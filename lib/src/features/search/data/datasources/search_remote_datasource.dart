import 'package:dio/dio.dart' as diox;

import '../../../../public/api_gateway.dart';
import '../../../../public/constants.dart';
import '../../../../resources/base_repository.dart';
import '../../../auth/data/models/auth_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<AuthModel>> searchUser(String searchQuery);
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final BaseRepository baseRepository;
  SearchRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<List<AuthModel>> searchUser(String searchQuery) async {
        diox.Response response = await baseRepository.getRoute(
      "${ApiGateway.searchUser}/$searchQuery",
    );

    List<AuthModel> users = [];
    
    AppConstants().handleApi(
      response: response,
      onSuccess: () {
        List rawData = response.data;
        users = rawData.map((e) => AuthModel.fromMap(e)).toList();
      },
    );

    return users;
  }
}
