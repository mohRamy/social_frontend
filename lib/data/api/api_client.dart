import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/utils/app_strings.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token_key;
  //final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.sharedPreferences}) {
    //baseUrl = appBaseUrl;
    timeout = const Duration(
        seconds: 30); // بجلب البيانات apiClient كم من الوقت يأخد ال
    token_key = sharedPreferences.getString(AppString.TOKEN_KEY) ?? '';
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppString.TOKEN: token_key,
    };
  }

  void updateHeaders(String tokenKey) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      AppString.TOKEN: tokenKey,
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

  

  Future<http.Response> postData(String uri, Object? body)async{
    http.Response res = await http.post(
      Uri.parse(uri),
      body: body,
      headers: _mainHeaders,
    );
    return res;
  }

  Future<Response> postDataGet(String uri, Object? body)async{
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
