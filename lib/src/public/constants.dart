import 'dart:ui';

// import 'package:lottie/lottie.dart';

import 'package:dio/dio.dart' as diox;

import '../core/error/exceptions.dart';
import '../models/language_model.dart';

class AppConstants {
  static const inchToDP = 160;

  static String countryCode = 'country_code';
  static String languageCode = 'language_code';

  static const urlImageDefault = "https://thumbs.dreamstime.com/b/person-gray-photo-placeholder-man-silhouette-sign-white-background-139139332.jpg";

  // Lottie
  static const lottiePath = 'assets/lotties';
  // LottieBuilder splashLottie = Lottie.asset('$LOTTIE_PATH/splash.json');
  // LottieBuilder loadingLottie = Lottie.asset('$LOTTIE_PATH/cat_sleeping.json');
  // LottieBuilder loginLottie = Lottie.asset('$LOTTIE_PATH/login.json');

  // Image
  static const imgPath = 'assets/img';
  static const like32Asset = '$imgPath/like_32.png';
  static const liked32Asset = '$imgPath/liked_32.png';
  static const commentAsset = "$imgPath/comment_32.png";
  static const shareAsset = '$imgPath/share_32.png';
  static const personAsset = '$imgPath/person.webp';

  // Icon
  static const iconPath = 'assets/icons';
  static const logo32Asset = '$iconPath/logo32.png';
  static const logo64Asset = '$iconPath/logo64.png';

  // Language
  static const languagePath = 'assets/languages';
  static const inLanguage = '$languagePath/en.json';
  static const arLanguage = '$languagePath/ar.json';


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
