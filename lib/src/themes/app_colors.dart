import 'package:flutter/material.dart';

import '../core/utils/hex_color.dart';


var colorPrimary = HexColor("FF0088CC");
var colorBranch = HexColor("FF34495E");
var colorDarkPrimary = HexColor("FF14171A");
var colorDarkBranch = HexColor("FF282828");
var colorBlack = HexColor("FF121212");

var colorError = Colors.redAccent;
var colorAccent = HexColor("FF17c063");
var colorBottom = HexColor("FF657786");
var chatBoxOther = HexColor("FF3d3d3f");
var chatBoxUser = HexColor("FF066162");

// var colorStar = HexColor('FFFF9900');

Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCM = Colors.grey.shade200;
Color mCH = Colors.grey.shade400;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCD = Colors.grey.shade700;
Color fCL = Colors.grey;

Gradient gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      colorPrimary,
      colorBranch,
    ],
  );

class AppColors {
  final Color primary;
  final Color background;
  final Color accent;
  final Color disabled;
  final Color error;
  final Color divider;
  final Color header;
  final Color button;
  final Color contentText1;
  final Color contentText2;

  const AppColors({
    required this.header,
    required this.primary,
    required this.background,
    required this.accent,
    required this.disabled,
    required this.error,
    required this.divider,
    required this.button,
    required this.contentText1,
    required this.contentText2,
  });

  factory AppColors.light() {
    return AppColors(
      header: colorBlack,
      primary: colorPrimary,
      background: mC,
      accent: colorAccent,
      disabled: Colors.black12,
      error: colorError,
      divider: Colors.black26,
      button: colorBottom,
      contentText1: colorBlack,
      contentText2: fCL,
    );
  }

  factory AppColors.dark() {
    return AppColors(
      header: mCL,
      primary: colorPrimary,
      background: colorBlack,
      accent: colorAccent,
      disabled: Colors.white12,
      error: colorError,
      divider: Colors.white24,
      button: mCL,
      contentText1: mCL,
      contentText2: fCL,
    );
  }
}
