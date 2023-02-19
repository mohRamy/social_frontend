import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'hex_color.dart';

class AppColors {
  

  static Color primary = HexColor("FF0088CC");
  static Color canvas = HexColor("FF34495E");
  static Color bgLightColor = HexColor("FFECF9FF");
  static Color bgDarkColor = Colors.black;
  static Color blackColor = HexColor("FF34495E");
  static Color white = HexColor("FFFFFFFF");
  static Color textfieldColor = HexColor("FF1c1d1f");
  static Color greyColor = HexColor("FF161616");
  static Color chatBoxOther = HexColor("FF3d3d3f");
  static Color chatBoxMe = HexColor("FF066162");

  static Gradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      // Color(0xFF0088CC),
      // Color(0xFF34495E),
      primary,
      canvas,
    ],
  );
}

class Themes {
  static final light = ThemeData(
      scaffoldBackgroundColor: AppColors.bgLightColor,
      dividerColor: AppColors.bgDarkColor,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      canvasColor: AppColors.canvas,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.bgLightColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgLightColor,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      
      ),
      iconTheme: IconThemeData(
        color: AppColors.bgDarkColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.bgLightColor,
      )
      );

  static final dark = ThemeData(
      scaffoldBackgroundColor: AppColors.bgDarkColor,
      dividerColor: Colors.white,
      brightness: Brightness.dark,
      primaryColor: AppColors.blackColor,
      canvasColor: AppColors.canvas,
      backgroundColor: AppColors.greyColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.bgDarkColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.bgDarkColor,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.bgLightColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.bgDarkColor,
      )
      );
}
