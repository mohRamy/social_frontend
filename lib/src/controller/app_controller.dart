import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_app/src/features/chat/domain/usecases/add_message.dart';

import '../core/network/network_info.dart';
import '../features/auth/data/datasources/auth_remote_datasource.dart';
import '../features/auth/data/repository/auth_repository.dart';
import '../features/auth/domain/repository/base_auth_repository.dart';
import '../features/auth/domain/usecases/get_user_info.dart';
import '../features/auth/domain/usecases/get_user_info_by_id.dart';
import '../features/auth/domain/usecases/is_token_valid.dart';
import '../features/auth/domain/usecases/sign_in.dart';
import '../features/auth/domain/usecases/sign_up.dart';
import '../features/auth/presentation/controller/auth_controller.dart';
import '../features/chat/data/datasources/chat_remote_datasource.dart';
import '../features/chat/data/repository/chat_repository.dart';
import '../features/chat/domain/repository/base_chat_repository.dart';
import '../features/chat/domain/usecases/chat_message_seen.dart';
import '../features/chat/domain/usecases/get_user_chat.dart';
import '../features/chat/domain/usecases/message_notification.dart';
import '../features/chat/presentation/controller/chat_controller.dart';
import '../features/home/data/datasources/home_remote_datasource.dart';
import '../features/home/data/repository/home_repository.dart';
import '../features/home/domain/repository/base_home_repository.dart';
import '../features/home/domain/usecases/add_story.dart';
import '../features/home/domain/usecases/delete_post.dart';
import '../features/home/domain/usecases/get_all_posts.dart';
import '../features/home/domain/usecases/get_all_post_comment.dart';
import '../features/home/domain/usecases/get_all_stories.dart';
import '../features/home/domain/usecases/get_all_story_comment.dart';
import '../features/home/domain/usecases/add_comment_post.dart';
import '../features/home/domain/usecases/add_like_comment_post.dart';
import '../features/home/domain/usecases/add_like_post.dart';
import '../features/home/domain/usecases/add_comment_Story.dart';
import '../features/home/domain/usecases/story_comment_like.dart';
import '../features/home/domain/usecases/story_like.dart';
import '../features/home/domain/usecases/update_post.dart';
import '../features/home/presentation/controller/home_controller.dart';
import '../features/navigation/controller/navigation_controller.dart';
import '../features/post/data/datasources/post_remote_datasource.dart';
import '../features/post/data/repository/post_repository.dart';
import '../features/post/domain/repository/base_post_repository.dart';
import '../features/post/domain/usecases/add_post.dart';
import '../features/post/presentation/controller/post_controller.dart';
import '../features/profile/data/datasources/profile_remote_datasource.dart';
import '../features/profile/data/repository/profile_repository.dart';
import '../features/profile/domain/repository/base_profile_repository.dart';
import '../features/profile/domain/usecases/change_password.dart';
import '../features/profile/domain/usecases/follow_user.dart';
import '../features/profile/domain/usecases/get_user_posts.dart';
import '../features/profile/domain/usecases/get_user_posts_by_id.dart';
import '../features/profile/domain/usecases/modify_my_data.dart';
import '../features/profile/domain/usecases/private_account.dart';
import '../features/profile/presentation/controller/profile_controller.dart';
import '../features/search/data/datasources/search_remote_datasource.dart';
import '../features/search/data/repository/search_repository.dart';
import '../features/search/domain/repository/base_search_repository.dart';
import '../features/search/domain/usecases/add_post.dart';
import '../features/search/presentation/controller/search_controller.dart';

import '../resources/base_repository.dart';
import 'theme_controller.dart';

class AppGet {
  static final themeGet = Get.find<ThemeController>();
  // static final notificationGet = Get.find<NotificationController>();

  static final authGet = Get.find<AuthController>();

  static final homeGet = Get.find<HomeController>();

  static final postGet = Get.find<PostController>();

  static final searchGet = Get.find<SearchController>();

  static final profileGet = Get.find<ProfileController>();

  static final chatGet = Get.find<ChatController>();


  static Future<void> init() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut(() => sharedPreferences);    


    // base repository
    Get.lazyPut(() => BaseRepository());

    // netInfo
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
    Get.lazyPut(() => InternetConnectionChecker());

    // Language
    // Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));

    // base and impl
  Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<PostRepository>(() => PostRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<SearchRepository>(
      () => SearchRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<ProfileRepository>(
      () => ProfileRepositoryImpl(Get.find(), Get.find()));

  Get.lazyPut<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(Get.find()));
  Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(Get.find(), Get.find()));


  //controllers
  // Get.lazyPut(() => UserController());

  Get.lazyPut(()=>GetAllPostsUsecase(Get.find()));
  Get.lazyPut(()=>ModifyPostUsecase(Get.find()));
  Get.lazyPut(()=>DeletePostUsecase(Get.find()));
  Get.lazyPut(()=>AddLikePostUsecase(Get.find()));
  Get.lazyPut(()=>AddCommentPostUsecase(Get.find()));
  Get.lazyPut(()=>GetAllPostCommentUsecase(Get.find()));
  Get.lazyPut(()=>AddLikeCommentPostUsecase(Get.find()));
  Get.lazyPut(()=>GetAllStoriesUsecase(Get.find()));
  Get.lazyPut(()=>AddStoryUsecase(Get.find()));
  Get.lazyPut(()=>StoryLikeUsecase(Get.find()));
  Get.lazyPut(()=>AddCommentStoryUsecase(Get.find()));
  Get.lazyPut(()=>GetAllStoryCommentUsecase(Get.find()));
  Get.lazyPut(()=>StoryCommentLikeUsecase(Get.find()));
  Get.lazyPut(() => HomeController(
        getAllPostsUsecase: Get.find(),
        modifyPostUsecase: Get.find(),
        deletePostUsecase: Get.find(),
        addLikePostUsecase: Get.find(),
        addCommentPostUsecase: Get.find(),
        getAllPostCommentUsecase: Get.find(),
        addLikeCommentPostUsecase: Get.find(),
        getAllStoriesUsecase: Get.find(),
        addStoryUsecase: Get.find(),
        storyLikeUsecase: Get.find(),
        storyCommentUsecase: Get.find(),
        getAllStoryCommentUsecase: Get.find(),
        storyCommentLikeUsecase: Get.find(),
      ));

  Get.lazyPut(()=>SignInAuthUsecase(Get.find()));
  Get.lazyPut(()=>SignUpAuthUsecase(Get.find()));
  Get.lazyPut(()=>IsTokenValidAuthUsecase(Get.find()));
  Get.lazyPut(()=>GetUserInfoAuthUsecase(Get.find()));
  Get.lazyPut(()=>GetUserInfoByIdAuthUsecase(Get.find()));
  Get.lazyPut(() => AuthController(
        signInAuthUsecase: Get.find(),
        signUpAuthUsecase: Get.find(),
        isTokenValidAuthUsecase: Get.find(),
        getUserInfoAuthUsecase: Get.find(),
        getUserInfoByIdAuthUsecase: Get.find(),
        // box: Get.find(),
      ));
      
  Get.lazyPut(() => NavigationController());

  Get.lazyPut(()=>AddPostUseCase(Get.find()));
  Get.lazyPut(() => PostController(addPostUseCase: Get.find()));
  
  Get.lazyPut(()=>SearchUserUseCase(Get.find()));
  Get.lazyPut(() => SearchControlle(
        searchUserUseCase: Get.find(),
      ));
  
  Get.lazyPut(()=>FollowUserUseCase(Get.find()));
  Get.lazyPut(()=>GetUserPostsUseCase(Get.find()));
  Get.lazyPut(()=>GetUserPostsByIdUseCase(Get.find()));
  Get.lazyPut(()=>UpdataUserInfoUseCase(Get.find()));
  Get.lazyPut(()=>PrivateAccountUseCase(Get.find()));
  Get.lazyPut(()=>ChangepasswordUseCase(Get.find()));
  Get.lazyPut(() => ProfileController(
        followUserUseCase: Get.find(),
        getUserPostsUseCase: Get.find(),
        getUserPostsByIdUseCase: Get.find(),
        updataUserInfoUseCase: Get.find(),
        privateAccountUseCase: Get.find(),
        changepasswordUseCase: Get.find(),
      ));

  Get.lazyPut(()=>GetUserChatUseCase(Get.find()));
  Get.lazyPut(()=>AddMessageUseCase(Get.find()));
  Get.lazyPut(()=>ChatMessageSeenUseCase(Get.find()));
  Get.lazyPut(()=>MessageNotificationUseCase(Get.find()));
  Get.lazyPut(() => ChatController(
        getUserChatUseCase: Get.find(),
        addMessageUseCase: Get.find(),
        chatMessageSeenUseCase: Get.find(),
        messageNotificationUseCase: Get.find(),
      ));
  }

  static void dispose() {
    themeGet.dispose;
  }

  ///Singleton factory
  static final AppGet _instance = AppGet._internal();

  factory AppGet() {
    return _instance;
  }

  AppGet._internal();
}
