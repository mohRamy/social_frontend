import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../data/api/api_client.dart';
import '../../../data/models/user_model.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });
  // sign up user
  Future<http.Response> signUpUser({
    required String name,
    required String email,
    required String password,
    required File? photo,
  }) async {
    String photoCloudinary =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

    if (photo != null) {
      final cloudinary = CloudinaryPublic('dvn9z2jmy', 'qle4ipae');

      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          photo.path,
          folder: name,
        ),
      );
      photoCloudinary = res.secureUrl;
    }
    
    UserModel user = UserModel(
      id: '',
      name: name,
      email: email,
      bio: '',
      followers: [],
      following: [],
      photo: photoCloudinary,
      backgroundImage: '',
      phone: '',
      password: password,
      address: '',
      type: '',
      token: '',
    );

    return await apiClient.postData(AppString.SIGN_UP_URL, user.toJson());
  }

  //sign in user
  Future<http.Response> login(String email, String password) async {
    return await apiClient.postData(
      AppString.SIGN_IN_URL,
      jsonEncode({
        'email': email,
        'password': password,
      }),
    );
  }

  // token is valid
  Future<http.Response> tokenIsValid() async {
    return await apiClient.postData(
        AppString.TOKEN_IS_VALID_URL, 
        jsonEncode({}),
        );
  }

  // fetch my data
  Future<http.Response> fetchMyData() async {
    return await apiClient.getData('${AppString.BASE_URL}/');
  }

  // fetch user data
  Future<http.Response> fetchUserData(String userId) async {
    return await apiClient.getData('${AppString.USER_BY_ID_URL}?userId=$userId');
  }

  // save user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeaders(token);
    return await sharedPreferences.setString(AppString.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppString.TOKEN) ?? '';
  }

  String getUserType() {
    return sharedPreferences.getString(AppString.TYPE_KEY) ?? '';
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppString.TOKEN);
  }
}
