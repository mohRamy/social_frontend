import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:social_app/src/features/navigation/index.dart';
import 'package:social_app/src/features/screens/profile/domain/usecases/update_avatar.dart';

import 'package:social_app/src/features/taps/home/index.dart';
import 'package:social_app/src/features/taps/notification/index.dart';
import 'package:social_app/src/features/taps/requist/index.dart';

import 'package:social_app/src/features/screens/add_post/index.dart';
import 'package:social_app/src/features/screens/add_story/index.dart';
import 'package:social_app/src/features/screens/another_profile/index.dart';
import 'package:social_app/src/features/screens/auth/index.dart';
import 'package:social_app/src/features/screens/change_password/index.dart';
import 'package:social_app/src/features/screens/chat/index.dart';
import 'package:social_app/src/features/screens/comment/index.dart';
import 'package:social_app/src/features/screens/friends/index.dart';
import 'package:social_app/src/features/screens/like/index.dart';
import 'package:social_app/src/features/screens/privacy/index.dart';
import 'package:social_app/src/features/screens/profile/index.dart';
import 'package:social_app/src/features/screens/search/index.dart';
import 'package:social_app/src/features/screens/update_info/index.dart';
import 'package:social_app/src/features/screens/update_post/index.dart';
import 'package:social_app/src/features/screens/view_story/index.dart';
import 'package:social_app/src/features/screens/voice_call/index.dart';

import '../lang/language_service.dart';
import '../models/language_model.dart';
import '../public/constants.dart';

import '../core/network/network_info.dart';

import '../resources/base_repository.dart';
class AppGet {
  static final localizationGet = Get.find<LocalizationController>();

  // Taps
  static final homeGet = Get.find<HomeController>();
  static final notificationGet = Get.find<NotificationController>();
  static final requistGet = Get.find<RequistController>();
  // Screens
  static final addPostGet = Get.find<AddPostController>();
  static final addStoryGet = Get.find<AddStoryController>();
  static final anotherProfileGet = Get.find<AnotherProfileController>();
  static final authGet = Get.find<AuthController>();
  static final changePasswordGet = Get.find<ChangePasswordController>();
  static final chatGet = Get.find<ChatController>();
  static final commentGet = Get.find<CommentController>();
  static final friendsGet = Get.find<FriendsController>();
  static final likeGet = Get.find<LikeController>();
  static final privacyGet = Get.find<PrivacyController>();
  static final profileGet = Get.find<ProfileController>();
  static final searchGet = Get.find<SearchController>();
  static final updateInfoGet = Get.find<UpdateInfoController>();
  static final updatePostGet = Get.find<UpdatePostController>();
  static final viewStoryGet = Get.find<ViewStoryController>();
  static final voiceCallGet = Get.find<VoiceCallController>();

  static Future<Map<String, Map<String, String>>> init() async {
    // Share Preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);

    // Base repository
    Get.lazyPut(() => BaseRepository());

    // Network Info
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
    Get.lazyPut(() => InternetConnectionChecker());
    
    // Repository & Data
    // Taps
    Get.lazyPut<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(Get.find()));
    Get.lazyPut<HomeRepository>(
        () => HomeRepositoryImpl(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<NotificationRemoteDataSource>(
        () => NotificationRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<NotificationRepository>(
        () => NotificationRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<RequistRemoteDataSource>(
        () => RequistRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<RequistRepository>(
        () => RequistRepositoryImpl(Get.find(), Get.find()));
    // Screens
    Get.lazyPut<AddPostRemoteDataSource>(
        () => AddPostRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AddPostRepository>(
        () => AddPostRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<AddStoryRemoteDataSource>(
        () => AddStoryRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AddStoryRepository>(
        () => AddStoryRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<AnotherProfileRemoteDataSource>(
        () => AnotherProfileRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AnotherProfileRepository>(
        () => AnotherProfileRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(Get.find()));
    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<ChangePasswordRemoteDataSource>(
        () => ChangePasswordRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<ChangePasswordRepository>(
        () => ChangePasswordRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<ChatLocalDataSource>(() => ChatLocalDataSourceImpl(Get.find()));
    Get.lazyPut<ChatRepository>(
        () => ChatRepositoryImpl(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<CommentRemoteDataSource>(
        () => CommentRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<CommentRepository>(
        () => CommentRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<FriendsRemoteDataSource>(
        () => FriendsRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<FriendsRepository>(
        () => FriendsRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<PrivacyRemoteDataSource>(
        () => PrivacyRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<PrivacyRepository>(
        () => PrivacyRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<ProfileRemoteDataSource>(
        () => ProfileRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<ProfileRepository>(
        () => ProfileRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<SearchRemoteDataSource>(
        () => SearchRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<SearchRepository>(
        () => SearchRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<UpdateInfoRemoteDataSource>(
        () => UpdateInfoRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<UpdateInfoRepository>(
        () => UpdateInfoRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<UpdatePostRemoteDataSource>(
        () => UpdatePostRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<UpdatePostRepository>(
        () => UpdatePostRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<ViewStoryRemoteDataSource>(
        () => ViewStoryRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<ViewStoryRepository>(
        () => ViewStoryRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<VoiceCallRemoteDataSource>(
        () => VoiceCallRemoteDataSourceImpl(Get.find()));
    Get.lazyPut<VoiceCallRepository>(
        () => VoiceCallRepositoryImpl(Get.find(), Get.find()));

    //controllers
    Get.lazyPut(() => LocalizationController(Get.find()));

    Get.lazyPut(() => NavigationController());
    // Taps
    Get.lazyPut(() => GetAllPostsUsecase(Get.find()));
    Get.lazyPut(() => GetAllPostsSocketUsecase(Get.find()));
    Get.lazyPut(() => GetAllStoriesUsecase(Get.find()));
    Get.lazyPut(() => ChangePostLikeUsecase(Get.find()));
    Get.lazyPut(() => AddPostShareUsecase(Get.find()));
    Get.lazyPut(() => DeletePostUsecase(Get.find()));
    Get.lazyPut(() => HomeController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut(() => GetNotificationsUseCase(Get.find()));
    Get.lazyPut(() => PushNotificationUseCase(Get.find()));
    Get.lazyPut(() => NotificationSeenUseCase(Get.find()));
    Get.lazyPut(() => NotificationController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut(() => ChangeUserCaseRequistUseCase(Get.find()));
    Get.lazyPut(() => RequistController(
          Get.find(),
        ));

    // Screens
    Get.lazyPut(() => AddPostUseCase(Get.find()));
    Get.lazyPut(() => AddPostController(Get.find()));

    Get.lazyPut(() => AddStoryUsecase(Get.find()));
    Get.lazyPut(() => AddStoryController(Get.find()));

    Get.lazyPut(() => ChangeUserCaseUseCase(Get.find()));
    Get.lazyPut(() => GetAnotherUserPostsUseCase(Get.find()));
    Get.lazyPut(() => AnotherProfileController(Get.find(), Get.find()));

    Get.lazyPut(() => LoginAuthUsecase(Get.find()));
    Get.lazyPut(() => RegisterAuthUsecase(Get.find()));
    Get.lazyPut(() => IsTokenValidAuthUsecase(Get.find()));
    Get.lazyPut(() => GetUserInfoAuthUsecase(Get.find()));
    Get.lazyPut(() => GetUserInfoByIdAuthUsecase(Get.find()));
    Get.lazyPut(() => IsUserOnlineUsecase(Get.find()));
    Get.lazyPut(() => AddUserFcmTokenUsecase(Get.find()));
    Get.lazyPut(() => AuthController(
          loginAuthUsecase: Get.find(),
          regiserAuthUsecase: Get.find(),
          isTokenValidAuthUsecase: Get.find(),
          getUserInfoAuthUsecase: Get.find(),
          getUserInfoByIdAuthUsecase: Get.find(),
          isUserOnlineUsecase: Get.find(),
          addUserFcmTokenUsecase: Get.find(),
        ));

    Get.lazyPut(() => ChangepasswordUseCase(Get.find()));
    Get.lazyPut(() => ChangePasswordController(Get.find()));

    Get.lazyPut(() => GetUserChatUseCase(Get.find()));
    Get.lazyPut(() => AddMessageUseCase(Get.find()));
    Get.lazyPut(() => IsMessageSeenUseCase(Get.find()));
    Get.lazyPut(() => ChatController(
          Get.find(),
          Get.find(),
          Get.find(),
        ));

    Get.lazyPut(() => AddCommentUseCase(Get.find()));
    Get.lazyPut(() => ChangeCommentLikeUsecase(Get.find()));
    Get.lazyPut(() => GetCommentsUseCase(Get.find()));
    Get.lazyPut(() => CommentController(Get.find(), Get.find(), Get.find()));

    Get.lazyPut(() => RemoveFriendUseCase(Get.find()));
    Get.lazyPut(() => FriendsController(Get.find()));

    Get.lazyPut(() => LikeController());

    Get.lazyPut(() => PrivateAccountUseCase(Get.find()));
    Get.lazyPut(() => PrivacyController(Get.find()));

    Get.lazyPut(() => GetUserPostsUseCase(Get.find()));
    Get.lazyPut(() => UpdateAvatarUseCase(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find(), Get.find()));

    Get.lazyPut(() => SearchUserUseCase(Get.find()));
    Get.lazyPut(() => SearchControlle(Get.find()));

    Get.lazyPut(() => UpdateInfoUseCase(Get.find()));
    Get.lazyPut(() => UpdateInfoController(Get.find()));

    Get.lazyPut(() => UpdatePostUseCase(Get.find()));
    Get.lazyPut(() => UpdatePostController(Get.find()));

    Get.lazyPut(() => ChangeStoryLikeUsecase(Get.find()));
    Get.lazyPut(() => ViewStoryController(Get.find()));

    Get.lazyPut(() => VoiceCallUsecase(Get.find()));
    Get.lazyPut(() => VoiceCallController(Get.find()));

    Map<String, Map<String, String>> languages = {};
    for (LanguageModel languageModel in AppConstants.languages) {
      String jsonStringValues = await rootBundle
          .loadString('assets/languages/${languageModel.languageCode}.json');
      Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
      Map<String, String> jsonMap = {};
      mappedJson.forEach((key, value) {
        jsonMap[key] = value.toString();
      });
      languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
          jsonMap;
    }
    return languages;
  }

  ///Singleton factory
  static final AppGet _instance = AppGet._internal();

  factory AppGet() {
    return _instance;
  }

  AppGet._internal();
}
