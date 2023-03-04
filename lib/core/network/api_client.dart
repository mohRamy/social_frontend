import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/app_strings.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late GetStorage box;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.box, required this.appBaseUrl }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = box.read(AppString.token) ?? '';
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppString.tokenKey: token,
    };
  }

  void updateHeaders(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppString.tokenKey: token,
    };
  }

  Future<http.Response> getData(String uri,
      {Map<String, String>? headers}) async {
    http.Response response = await http.get(
      Uri.parse(uri),
      headers: headers ?? _mainHeaders,
    );
    return response;
  }

  Future<http.Response> postData(String uri, Object? body) async {
    http.Response res = await http.post(
      Uri.parse(uri),
      body: body,
      headers: _mainHeaders,
    );
    return res;
  }

  Future<http.Response> updateData(String uri)async{
    http.Response res = await http.put(
      Uri.parse(uri),
      headers: _mainHeaders,
      );
    return res;
  }

  // Future<http.Response> postDatac(String uri, Object? body) async {
  //   http.Response res = await http.post(
  //     Uri.parse(uri),
  //     body: body,
  //     headers: _mainHeaders,
  //   );
  //   return res;
  // }

  // Future<Response> getData(String uri) async {
  //   Response res = await get(
  //     "$baseUrl/$uri",
  //     headers: _mainHeaders,
  //     );
  //   return res;
  // }

  // Future<Response> postData(String uri, Object? body) async {
  //   Response res = await post(
  //     "$baseUrl/$uri",
  //     body,
  //     headers: _mainHeaders,
  //   );
  //   return res;
  // }

  // Future<Response> putData(String uri, Object? body) async {
  //   Response res = await put(
  //     "$baseUrl/$uri",
  //     body,
  //     headers: _mainHeaders,
  //   );
  //   return res;
  // }

  // Future<Response> deleteData(String uri) async {
  //   Response res = await delete(
  //     "$baseUrl/$uri",
  //     headers: _mainHeaders,
  //   );
  //   return res;
  // }
}
