// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'hex_color.dart';

// class AppColors {
//   static Color origin = HexColor("FF0088CC");
//   static Color branch = HexColor("FF34495E");
//   static Color backgroundLight = HexColor("FFECF9FF");
//   static Color backgroundDark = Colors.black;
//   static Color blackColor = HexColor("FF34495E");
//   static Color white = HexColor("FFFFFFFF");
//   static Color textfieldColor = HexColor("FF1c1d1f");
//   static Color greyColor = HexColor("FF161616");
//   static Color chatBoxOther = HexColor("FF3d3d3f");
//   static Color chatBoxMe = HexColor("FF066162");

//   static Gradient gradient = LinearGradient(
//     begin: Alignment.centerLeft,
//     end: Alignment.centerRight,
//     colors: [
//       origin,
//       branch,
//     ],
//   );
// }

// class Themes {
//   static final light = ThemeData(
//       scaffoldBackgroundColor: AppColors.backgroundLight,
//       dividerColor: AppColors.backgroundDark,
//       brightness: Brightness.light,
//       primaryColor: AppColors.origin,
//       canvasColor: AppColors.branch,
//       appBarTheme: AppBarTheme(
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: AppColors.backgroundLight,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//       ),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.backgroundLight,
//       ),
//       textTheme: const TextTheme(
//         bodyText1: TextStyle(
//           color: Colors.black,
//         ),
//         bodyText2: TextStyle(
//           color: Colors.white,
//         ),
      
//       ),
//       iconTheme: IconThemeData(
//         color: AppColors.backgroundDark,
//       ),
//       bottomSheetTheme: BottomSheetThemeData(
//         backgroundColor: AppColors.backgroundLight,
//       )
//       );

//   static final dark = ThemeData(
//       scaffoldBackgroundColor: AppColors.backgroundDark,
//       dividerColor: Colors.white,
//       brightness: Brightness.dark,
//       primaryColor: AppColors.blackColor,
//       canvasColor: AppColors.branch,
//       // backgroundColor: AppColors.greyColor,
//       appBarTheme: AppBarTheme(
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: AppColors.backgroundDark,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//       ),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         backgroundColor: AppColors.backgroundDark,
//       ),
//       textTheme: const TextTheme(
//         bodyText1: TextStyle(
//           color: Colors.white,
//         ),
//         bodyText2: TextStyle(
//           color: Colors.black,
//         ),
//       ),
//       iconTheme: IconThemeData(
//         color: AppColors.backgroundLight,
//       ),
//       bottomSheetTheme: BottomSheetThemeData(
//         backgroundColor: AppColors.backgroundDark,
//       )
//       );
// }
