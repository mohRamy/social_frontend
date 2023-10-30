import 'dart:ui';

// import 'package:lottie/lottie.dart';

import 'package:dio/dio.dart' as diox;

import '../core/error/exceptions.dart';
import '../models/language_model.dart';

class AppConstants {
  static const INCH_TO_DP = 160;

  static String COUNTRY_CODE = 'country_code';
  static String LANGUAGE_CODE = 'language_code';

  static const urlImageDefault = 'assets/icons/logo32.png';

  // Lottie
  static const LOTTIE_PATH = 'assets/lotties';
  // LottieBuilder splashLottie = Lottie.asset('$LOTTIE_PATH/splash.json');
  // LottieBuilder loadingLottie = Lottie.asset('$LOTTIE_PATH/cat_sleeping.json');
  // LottieBuilder loginLottie = Lottie.asset('$LOTTIE_PATH/login.json');

  // Image
  static const imgPath = 'assets/img';
  static const like32Asset = '$imgPath/like_32.png';
  static const liked32Asset = '$imgPath/liked_32.png';
  static const commentAsset = "$imgPath/comment_32.png";
  static const shareAsset = '$imgPath/share_32.png';

  // Icon
  static const ICON_PATH = 'assets/icons';
  static const LOGO32_ASSET = '$ICON_PATH/logo32.png';
  static const LOGO64_ASSET = '$ICON_PATH/logo64.png';

  // Language
  static const LANGUAGE_PATH = 'assets/languages';
  static const IN_LANGUAGE = '$LANGUAGE_PATH/en.json';
  static const AR_LANGUAGE = '$LANGUAGE_PATH/ar.json';


  static List<LanguageModel> languages = [
    LanguageModel(
      imageUrl: "en.png",
      languageName: 'English',
      languageCode: 'en',
      countryCode: 'US',
    ),
    LanguageModel(
      imageUrl: "ar.png",
      languageName: 'عربي',
      languageCode: 'ar',
      countryCode: 'SA',
    ),
  ];

  void handleApi({
  required diox.Response response,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
    break;
    case 400:
    throw ServerException(messageError: response.data['msg']);
    case 500:
    throw ServerException(messageError: response.data['error']);
    default:
    throw ServerException(messageError: response.data['error']);
  }
}
}
