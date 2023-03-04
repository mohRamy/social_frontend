import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_strings.dart';

class ApiClie extends GetConnect implements GetxService {
  late String token;
  //final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  ApiClie({required this.sharedPreferences}) {
    //baseUrl = appBaseUrl;
    timeout = const Duration(
        seconds: 30); // بجلب البيانات apiClient كم من الوقت يأخد ال
    token = sharedPreferences.getString(AppString.token) ?? '';
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

  Future<Response> postDataGet(String uri, Object? body) async {
    Response res = await post(
      uri,
      body,
      headers: _mainHeaders,
    );
    return res;
  }

  Future<http.Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: headers ?? _mainHeaders,
    );
    return response;
  }
}
