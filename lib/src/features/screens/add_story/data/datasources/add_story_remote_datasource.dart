import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as diox;
import '../../../../../public/api_gateway.dart';
import '../../../../../public/constants.dart';
import '../../../../../resources/base_repository.dart';

abstract class AddStoryRemoteDataSource {
  Future<Unit> addStory(List<String> storiesUrl, List<String> storiesType);
}

class AddStoryRemoteDataSourceImpl extends AddStoryRemoteDataSource {
  final BaseRepository baseRepository;
  AddStoryRemoteDataSourceImpl(this.baseRepository);

  @override
  Future<Unit> addStory(
    List<String> storiesUrl,
    List<String> storiesType,
  ) async {
    var body = {
      "storiesUrl": storiesUrl,
      "storiesType": storiesType,
    };

    diox.Response response = await baseRepository.postRoute(
      ApiGateway.addStory,
      body,
    );

    AppConstants().handleApi(
      response: response,
      onSuccess: () {},
    );

    return Future.value(unit);
  }
}
