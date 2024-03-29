import 'package:dio/dio.dart';

import '../../features/screens/auth/data/models/auth_model.dart';
import '../../public/api_gateway.dart';
import '../base_repository.dart';

class UserRepository {
  Future<AuthModel?> getInfoUser({String? token}) async {
    Response response = await BaseRepository().getRoute(
      ApiGateway.getUserInfo,
      token: token,
    );
    if (response.statusCode == 200) {
      return AuthModel.fromMap(response.data['data'] as Map<String, dynamic>);
    }
    return null;
  }

  Future<AuthModel?> updateUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String intro,
  }) async {
    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "intro": intro,
      "phone": phone,
    };

    Response response =
        await BaseRepository().patchRoute(ApiGateway.getUserInfo, body: body);

    print(response.data);

    if ([200, 201].contains(response.statusCode)) {
      return AuthModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<AuthModel?> updateAvatar({
    required String avatar,
    required String blurHash,
  }) async {
    var body = {
      "blurHash": blurHash,
      "image": avatar,
    };
    Response response = await BaseRepository().patchRoute(
      ApiGateway.updateAvatar,
      body: body,
    );
    if ([200, 201].contains(response.statusCode)) {
      return AuthModel.fromMap(response.data as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> deleteAccount() async {
    Response response =
        await BaseRepository().deleteRoute(ApiGateway.deleteAccount);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
