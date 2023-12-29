import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../../resources/base_repository.dart';
import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<Unit> changePassword(String currentPassword, String newPassword);
}

class ChangePasswordRemoteDataSourceImpl extends ChangePasswordRemoteDataSource {
  final BaseRepository baseRepository;
  ChangePasswordRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    var body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.changePassword,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
