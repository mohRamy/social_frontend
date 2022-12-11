import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {

static Gradient gradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xff149e8e),
        Color(0xff36ea7d),
      ],
    );

static Color primary = HexColor("FF0088CC");
static Color bgColor = HexColor("FF010101");
static Color bgBlackColor = HexColor("FF284855");
static Color white = HexColor("FFFFFFFF");
static Color black = HexColor("FF000000");
static Color textfieldColor = HexColor("FF1c1d1f");
static Color greyColor = HexColor("FF161616");
static Color chatBoxOther = HexColor("FF3d3d3f");
static Color chatBoxMe = HexColor("FF066162");
}
