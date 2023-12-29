import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;

import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';

abstract class PrivacyRemoteDataSource {
  Future<Unit> privateAccount();
}

class PrivacyRemoteDataSourceImpl extends PrivacyRemoteDataSource {
  final BaseRepository baseRepository;
  PrivacyRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> privateAccount() async {
    diox.Response response = await baseRepository.postRoute(
      ApiGateway.private,
      {},
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
