import 'package:get/get.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/profile/presentation/screens/account_profile_page.dart';
import '../../features/profile/presentation/screens/list_photos_profile_page.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/chat/presentation/components/contacts_list.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/likes_screen.dart';
import '../../features/home/presentation/screens/post_comments_screen.dart';

import '../../features/nav/screens/nav_user_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';

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
      page: () => const AccountProfileScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
