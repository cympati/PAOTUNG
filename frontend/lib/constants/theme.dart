import 'package:flutter/material.dart';
import 'package:paotung_frontend/utils/color.dart' as color;

class ThemeConstant {
  //Colors
  static Color colorPrimary = Color.fromRGBO(34, 176, 126, 1);
  static Color colorSecondary = const Color(0xFFF6C008);
  static Color colorThirdary = const Color(0xFFFE8453);
  static Color grey = Color.fromRGBO(230, 234, 242, 1);

  //Color swatch
  static MaterialColor swatchPrimary = color.createMaterialColor(colorPrimary);
  static MaterialColor swatchSecondary =
      color.createMaterialColor(colorSecondary);
  static MaterialColor swatchThirdary =
      color.createMaterialColor(colorThirdary);

  //shape
  static RoundedRectangleBorder pillBorderShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(99999.0));

  //Theme data
  static ThemeData theme = ThemeData(
    primarySwatch: swatchPrimary,
    buttonTheme: ButtonThemeData(shape: pillBorderShape),
  );
}
