import 'package:flutter/material.dart';

import '../utils/sizer_custom/sizer.dart';
import 'app_colors.dart';
import 'font_family.dart';

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.background,
        elevation: 0.4,
        shape: const RoundedRectangleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorBranch,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        elevation: 0.0,
      ),
      iconTheme: IconThemeData(
        color: appColors.header,
        size: 20.sp,
      ),
      textTheme: TextTheme(
        displayMedium: TextStyle(
          color: appColors.header,
          fontWeight: FontWeight.w500,
          fontSize: 30.sp,
        ),
        titleLarge: TextStyle(
          color: appColors.contentText1,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          fontFamily: FontFamily.lato,
        ),
        titleMedium: TextStyle(
          color: appColors.contentText1,
          fontFamily: FontFamily.lato,
        ),
        bodyLarge: TextStyle(
          color: appColors.contentText2,
          fontWeight: FontWeight.w300,
          fontFamily: FontFamily.lato,
        ),
      ),
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      primaryColor: appColors.primary,
      scaffoldBackgroundColor: appColors.background,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.background,
        elevation: 0.4,
        shape: const RoundedRectangleBorder(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: appColors.background,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorBranch,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.background,
        elevation: 0.0,
      ),
      iconTheme: IconThemeData(
        color: appColors.header,
        size: 20.sp,
      ),
      textTheme: TextTheme(
        displayMedium: TextStyle(
          color: appColors.header,
          fontWeight: FontWeight.w500,
          fontSize: 30.sp,
        ),
        titleLarge: TextStyle(
          color: appColors.contentText1,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          fontFamily: FontFamily.lato,
        ),
        titleMedium: TextStyle(
          color: appColors.contentText1,
          fontFamily: FontFamily.lato,
        ),
        bodyLarge: TextStyle(
          color: appColors.contentText2,
          fontWeight: FontWeight.w300,
          fontFamily: FontFamily.lato,
        ),
      ),
      dividerColor: appColors.divider,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppColors appColors;
}
