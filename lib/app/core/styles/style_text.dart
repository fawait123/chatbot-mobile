import 'package:apps_consultation_pregnant/app/core/styles/style_color.dart';
import 'package:flutter/material.dart';

class CustomText {

  // font light
  static TextStyle Light({Color colorText = CustomColor.netral300, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoLight',
        color: colorText,
        fontSize: fontSize,
      );
  static TextStyle LightItalic({Color colorText = CustomColor.netral300, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoLightItalic',
        color: colorText,
        fontSize: fontSize,
      );

  // font regular
  static TextStyle Regular({Color colorText = CustomColor.netral400, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoRegular',
        color: colorText,
        fontSize: fontSize,
      );

  // font medium
  static TextStyle Medium({Color colorText = CustomColor.netral500, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoMedium',
        color: colorText,
        fontSize: fontSize,
      );
  static TextStyle MediumItalic({Color colorText = CustomColor.netral500, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoMediumItalic',
        color: colorText,
        fontSize: fontSize,
      );

  // font bold
  static TextStyle Bold({Color colorText = CustomColor.netral700, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoBold',
        color: colorText,
        fontSize: fontSize,
      );
  static TextStyle BoldItalic({Color colorText = CustomColor.netral700, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoBoldItalic',
        color: colorText,
        fontSize: fontSize,
      );

  // font black
  static TextStyle Black({Color colorText = CustomColor.netral900, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoBlack',
        color: colorText,
        fontSize: fontSize,
      );
  static TextStyle BlackItalic({Color colorText = CustomColor.netral900, fontSize = 10.0}) =>
      TextStyle(
        fontFamily: 'RobotoBlackItalic',
        color: colorText,
        fontSize: fontSize,
      );
}
