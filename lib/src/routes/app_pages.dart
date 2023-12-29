import 'package:flutter/material.dart';
import 'package:social_app/src/features/screens/language/presentation/screens/language_screen.dart';
import 'package:social_app/src/features/screens/profile/presentation/screens/profile_screen.dart';
import 'package:social_app/src/features/screens/voice_call/index.dart';
import '../core/enums/slide_enum.dart';
import '../features/screens/add_post/presentation/screens/add_post_screen.dart';
import '../features/screens/theme/presentation/screens/theme_screen.dart';
import '../features/screens/privacy/presentation/screens/privacy_screen.dart';
import '../features/screens/change_password/presentation/screens/change_password_screen.dart';

import '../features/navigation/screens/navigation.dart';

import '../features/screens/auth/presentation/screens/login_screen.dart';
import '../features/screens/auth/presentation/screens/register_screen.dart';
import '../features/screens/chat/presentation/components/contacts_list.dart';
import '../features/screens/chat/presentation/screens/chat_home_screen.dart';
import '../features/screens/chat/presentation/screens/chat_screen.dart';
import '../features/screens/search/presentation/screens/search_screen.dart';
import '../features/screens/update_info_details/presentation/screens/update_info_details_screen.dart';
import '../features/screens/view_post/presentation/screens/view_post_screen.dart';
import '../features/screens/add_story/presentation/screens/add_story_screen.dart';
import '../features/screens/like/presentation/screens/like_screen.dart';
import '../features/screens/update_post/presentation/screens/update_post_screen.dart';
import '../features/screens/comment/presentation/screens/comment_screen.dart';
import '../features/screens/view_story/presentation/screens/view_story_screen.dart';
import '../features/screens/update_info/presentation/screens/update_info_screen.dart';
import '../features/screens/friends/presentation/screens/friends_screen.dart';
import '../features/screens/profile/presentation/screens/list_photos_profile_page.dart';
import '../features/screens/another_profile/presentation/screens/another_profile_screen.dart';
import '../features/screens/setting/presentation/screens/setting_screen.dart';
import 'scaffold_wrapper.dart';
import 'slides/slide_from_bottom_route.dart';
import 'slides/slide_from_left_route.dart';
import 'slides/slide_from_right_route.dart';
import 'slides/slide_from_top_route.dart';

part 'app_routes.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  SlideEnum defautlSlide = SlideEnum.right;
  Route<dynamic> getRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments = _getArguments(settings);
    switch (settings.name) {
      // Navication
      case AppRoutes.navigation:
        return _buildRoute(
          settings,
          const Navigation(),
          _getSlideMode(arguments),
        );

      case AppRoutes.addPost:
        return _buildRoute(
          settings,
          const AddPostScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.addStory:
        return _buildRoute(
          settings,
          const AddStoryScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.anotherProfile:
        return _buildRoute(
          settings,
          AnotherProfileScreen(
            userId: arguments!["user-id"],
          ),
          _getSlideMode(arguments),
        );

      case AppRoutes.login:
        return _buildRoute(
          settings,
          const LoginScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.register:
        return _buildRoute(
          settings,
          const RegisterScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.changePassword:
        return _buildRoute(
          settings,
          const ChangePasswordScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.chatHome:
        return _buildRoute(
          settings,
          const ChatHomeScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.chat:
        return _buildRoute(
          settings,
          ChatScreen(
            userData: arguments!["user-data"],
            isGroupChat: arguments["is-group-chat"],
          ),
          _getSlideMode(arguments),
        );

      case AppRoutes.comment:
        return _buildRoute(
          settings,
          CommentScreen(
            itemId: arguments!["item-id"],
            itemType: arguments["item-type"],
          ),
          _getSlideMode(arguments),
        );

      case AppRoutes.friends:
        return _buildRoute(
          settings,
          FriendsScreen(
            friendsId: arguments!["friends"],
          ),
          _getSlideMode(arguments),
        );

      case AppRoutes.language:
        return _buildRoute(
          settings,
          const LanguageScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.like:
        return _buildRoute(
          settings,
          LikeScreen(usersId: arguments!["users-id"]),
          _getSlideMode(arguments),
        );

      case AppRoutes.privacy:
        return _buildRoute(
          settings,
          const PrivacyScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.profile:
        return _buildRoute(
          settings,
          const ProfileScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.search:
        return _buildRoute(
          settings,
          const SearchScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.setting:
        return _buildRoute(
          settings,
          const SettingScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.theme:
        return _buildRoute(
          settings,
          const ThemeScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.updateInfo:
        return _buildRoute(
          settings,
          const UpdateInfoScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.updateInfoDetails:
        return _buildRoute(
          settings,
          const UpdateInfoDetailsScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.updatePost:
        return _buildRoute(
          settings,
          UpdatePostScreen(post: arguments!["post"]),
          _getSlideMode(arguments),
        );

      case AppRoutes.viewPost:
        return _buildRoute(
          settings,
          ViewPostScreen(post: arguments!["post"]),
          _getSlideMode(arguments),
        );

      case AppRoutes.viewStory:
        return _buildRoute(
          settings,
          ViewStoryScreen(story: arguments!["story"]),
          _getSlideMode(arguments),
        );

      case AppRoutes.voiceCall:
        return _buildRoute(
          settings,
          VoiceCallScreen(
            name: arguments!["name"],
            avatar: arguments["avatar"],
          ),
          _getSlideMode(arguments),
        );

      case AppRoutes.listPhotoProfile:
        return _buildRoute(
          settings,
          const ListPhotosProfileScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.contacts:
        return _buildRoute(
          settings,
          const ContactsScreen(),
          _getSlideMode(arguments),
        );

      default:
        return _buildRoute(settings, const Navigation(), SlideEnum.right);
    }
  }

  _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
    SlideEnum slideEnum,
  ) {
    switch (slideEnum) {
      case SlideEnum.bot:
        return SlideFromBottomRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideEnum.top:
        return SlideFromTopRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideEnum.left:
        return SlideFromLeftRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideEnum.right:
        return SlideFromRightRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
    }
  }

  _getArguments(RouteSettings settings) {
    return settings.arguments;
  }

  _getSlideMode(Map<String, dynamic>? arguments) {
    if (arguments == null) {
      return SlideEnum.right;
    } else {
      return arguments['slide'] ?? SlideEnum.right;
    }
  }

  static Future push<T>(
    String route, {
    Object? arguments,
  }) {
    return state.pushNamed(route, arguments: arguments);
  }

  static Future replaceWith<T>(
    String route, {
    Map<String, dynamic>? arguments,
  }) {
    return state.pushReplacementNamed(route, arguments: arguments);
  }

  static void popUntil<T>(String route) =>
      state.popUntil(ModalRoute.withName(route));

  static void pop() {
    if (state.canPop()) {
      state.pop();
    }
  }

  static String currentRoute(context) => ModalRoute.of(context)!.settings.name!;

  static NavigatorState get state => navigatorKey.currentState!;
}
