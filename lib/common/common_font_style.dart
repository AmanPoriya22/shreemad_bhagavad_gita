import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:shreemad_bhagavad_gita/utils/my_colors.dart';
import 'package:shreemad_bhagavad_gita/utils/fonts_util.dart';

class MyTextStyles {

  /// All Text Style
  TextStyle? myTextStyle({double? fontSize, Color? color, FontWeight? fontWeight}){
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontFamily: MyFonts.amaranth,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? MyColor.textColor,

    );
  }

}


