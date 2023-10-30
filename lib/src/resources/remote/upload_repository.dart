import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/upload_response_model.dart';
import '../../public/api_gateway.dart';
import '../base_repository.dart';

class UploadRepository {
  Future<UploadResponseModel?> uploadSingleFile({
    required File file,
  }) async {
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        file.readAsBytesSync(),
        filename: file.path,
      ),
    });

    Response response = await BaseRepository().sendFormData(
      ApiGateway.uploadSingleFile,
      formData,
    );

    if ([200, 201].contains(response.statusCode)) {
      var jsonResponse = await response.data;
      return UploadResponseModel.fromMap(jsonResponse);
    }

    return null;
  }

  Future<List<UploadResponseModel>?> uploadMultipleFile({
    required List<File> files,
  }) async {
    List filesBody = [];
    files.forEach((item) async {
      filesBody.add(MultipartFile.fromBytes(
        item.readAsBytesSync(),
        filename: item.path,
      ));
    });
    FormData formData = FormData.fromMap({
      'files': files,
    });

    Response response = await BaseRepository().sendFormData(
      ApiGateway.uploadMulipleFile,
      formData,
    );

    if ([200, 201].contains(response.statusCode)) {
      List jsonResponses = await response.data['data'];
      return jsonResponses
          .map((item) => UploadResponseModel.fromMap(item))
          .toList();
    }

    return null;
  }
}
