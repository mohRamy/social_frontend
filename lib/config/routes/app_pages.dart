
import 'package:get/get.dart';
import 'package:social_app/features/view/chat/widgets/contacts_list.dart';
import 'package:social_app/features/view/home/home_screens/likes_screen.dart';
import 'package:social_app/features/view/home/home_screens/post_comments_screen.dart';
import 'package:social_app/features/view/profile/profile_screen/account_profile_page.dart';

import '../../features/view/auth/auth_screens/signin_screen.dart';
import '../../features/view/auth/auth_screens/signup_screen.dart';
import '../../features/view/home/home_screens/home_screen.dart';
import '../../features/view/nav/nav_screen/nav_user_screen.dart';
import '../../features/view/profile/profile_screen/list_photos_profile_page.dart';
import '../../features/view/profile/profile_screen/profile_screen.dart';
import '../../features/view/search/search_screens/search_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> routes = [
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () =>  const SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NAV_USER_SCREEN,
      page: () => const NavUserScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () =>  const SearchScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () =>  const ProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LIST_PHOTO_PROFILE,
      page: () =>  const ListPhotosProfileScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LIKES,
      page: () => LikesScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.POST_COMMENTS,
      page: () => const PostCommentsScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CONTACTS_LIST,
      page: () => const ContactsList(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ACCOUNT_PROFILE,
      page: () => const AccountProfilePage(),
      transition: Transition.fadeIn,
    ),
  ];
}
