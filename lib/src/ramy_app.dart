import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'lang/language_service.dart';
import 'controller/app_controller.dart';
import 'lang/localization.dart';
import 'public/constants.dart';
import 'utils/sizer_custom/sizer.dart';
import 'routes/app_pages.dart';
import 'themes/theme_service.dart';
import 'themes/themes.dart';

class RamyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const RamyApp({
    Key? key,
    required this.languages,
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
        child: GetBuilder<LocalizationController>(
          builder: (localizationController) {
            return GetMaterialApp(
              navigatorKey: AppNavigator.navigatorKey,
              debugShowCheckedModeBanner: false,
              // localizationsDelegates: [
              //       GlobalMaterialLocalizations.delegate,
              //       GlobalWidgetsLocalizations.delegate,
              //       GlobalCupertinoLocalizations.delegate,
              //     ],
              locale: localizationController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(
                    AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode,
                  ),
              themeMode: ThemeService().theme,
              theme: AppTheme.light().data,
              darkTheme: AppTheme.dark().data,
              onGenerateRoute: (settings) {
                return AppNavigator().getRoute(settings);
              },
              // home: const HomeeScreen(),
              initialRoute: initRoute(),
            );
          }
        ),
      );
    });
  }
}
