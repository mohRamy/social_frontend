import 'package:flutter/material.dart';
import 'package:social_app/src/app.dart';
import 'package:social_app/src/features/chat/presentation/screens/chat_home_screen.dart';
import 'package:social_app/src/features/navigation/screens/navigation.dart';
import 'package:social_app/src/features/profile/presentation/screens/profile_by_id.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/chat/presentation/components/contacts_list.dart';
import '../features/home/presentation/screens/likes_screen.dart';
import '../features/home/presentation/screens/post_comments_screen.dart';
import '../features/profile/presentation/screens/account_profile_page.dart';
import '../features/profile/presentation/screens/list_photos_profile_page.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/profile/presentation/screens/setting_profile_page.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../models/slide_mode.dart';
import 'scaffold_wrapper.dart';
import 'slides/slide_from_bottom_route.dart';
import 'slides/slide_from_left_route.dart';
import 'slides/slide_from_right_route.dart';
import 'slides/slide_from_top_route.dart';

part 'app_routes.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  SlideMode defautlSlide = SlideMode.right;
  Route<dynamic> getRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments = _getArguments(settings);
    switch (settings.name) {
      case AppRoutes.root:
        return _buildRoute(
          settings,
          const SocialApp(),
          _getSlideMode(arguments),
        );

      // Navication
      case AppRoutes.navigation:
        return _buildRoute(
          settings,
          const Navigation(),
          _getSlideMode(arguments),
        );

        // Authintication
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

      // Search
      case AppRoutes.search:
        return _buildRoute(
          settings,
          const SearchScreen(),
          _getSlideMode(arguments),
        );

        // Profile
      case AppRoutes.profile:
        return _buildRoute(
          settings,
          const ProfileScreen(),
          _getSlideMode(arguments),
        );
        case AppRoutes.profileById:
        return _buildRoute(
          settings,
          ProfileByIdScreen(
            userId: arguments!['userId'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.accountProfile:
        return _buildRoute(
          settings,
          AccountProfileScreen(
            userInfo: arguments!["userInfo"],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.listPhotoProfile:
        return _buildRoute(
          settings,
          const ListPhotosProfileScreen(),
          _getSlideMode(arguments),
        );

        // Post
        case AppRoutes.likes:
        return _buildRoute(
          settings,
          LikesScreen(usersId: arguments!["usersId"]),
          _getSlideMode(arguments),
        );
        case AppRoutes.postComments:
        return _buildRoute(
          settings,
          PostCommentsScreen(
            postId: arguments!["postId"],
          ),
          _getSlideMode(arguments),
        );

        case AppRoutes.settings:
        return _buildRoute(
          settings,
          const SettingProfileScreen(),
          _getSlideMode(arguments),
        );

      case AppRoutes.chat:
        return _buildRoute(
          settings,
          ChatHomeScreen(
          usersData: arguments!['usersData'],
          ),
          _getSlideMode(arguments),
        );
      case AppRoutes.contacts:
        return _buildRoute(
          settings,
          ContactsScreen(
          usersData: arguments!['usersData'],
          ),
          _getSlideMode(arguments),
        );

      default:
        return _buildRoute(settings, const Navigation(), SlideMode.right);
    }
  }

  _buildRoute(
    RouteSettings routeSettings,
    Widget builder,
    SlideMode slideMode,
  ) {
    switch (slideMode) {
      case SlideMode.bot:
        return SlideFromBottomRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.top:
        return SlideFromTopRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.left:
        return SlideFromLeftRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
      case SlideMode.right:
        return SlideFromRightRoute(
            page: ScaffoldWrapper(child: builder), settings: routeSettings);
    }
  }

  _getArguments(RouteSettings settings) {
    return settings.arguments;
  }

  _getSlideMode(Map<String, dynamic>? arguments) {
    if (arguments == null) {
      return SlideMode.right;
    } else {
      return arguments['slide'] ?? SlideMode.right;
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
