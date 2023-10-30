import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'controller/app_controller.dart';
import 'utils/sizer_custom/sizer.dart';
import 'routes/app_pages.dart';
import 'themes/theme_service.dart';
import 'themes/themes.dart';

class SocialApp extends StatelessWidget {
  const SocialApp({
    Key? key,
  }) : super(key: key);

  String initRoute() {
    if (AppGet.authGet.onAuthCheck()) {
      return AppRoutes.navigation;
    } else {
      return AppRoutes.login;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return I18n(
        child: GetMaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          // localizationsDelegates: [
          //       GlobalMaterialLocalizations.delegate,
          //       GlobalWidgetsLocalizations.delegate,
          //       GlobalCupertinoLocalizations.delegate,
          //     ],
          themeMode: ThemeService().theme,
          theme: AppTheme.light().data,
          darkTheme: AppTheme.dark().data,
          onGenerateRoute: (settings) {
            return AppNavigator().getRoute(settings);
          },
          initialRoute: initRoute(),
          // home: const SplashScreen(),
        ),
      );
    });
  }
}
