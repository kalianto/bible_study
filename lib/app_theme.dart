import 'dart:ui';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color darkGrey = Color(0xFF313A44);
  static const Color lightGrey = Color(0xFFCCCCCC);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color primarySwatch = Colors.blue;
  static const Color primaryColor = Color(0xFF1565C0);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color redText = Color(0xFFff595e);
  static const Color yellowText = Color(0xFFffca3a);
  static const Color greenText = Color(0xFF8ac926);
  static const Color blueText = Color(0xFF1982c4);
  static const Color purpleText = Color(0xFF6a4c93);

  static const Color purple = Color(0xFF4F39B5);
  static const Color mandarin = Color(0xFFfc6805);
  static const Color darkOrange = Color(0xFFfc934e);
  static const Color orange = Color(0xFFEAA375);
  static const Color lightOrange = Color(0xFFF9D9C3);
  static const Color lighterOrange = Color(0xFFFDEDE4);
  static const Color cyan = Color(0xFF4ED6F4);
  static const Color green = Color(0xFF99DB31);
  static const Color lightGreen = Color(0xFFDCF6DF);
  static const Color darkGreen = Color(0xFF73AB75);

  static const String fontName = 'FiraSansCondensed';

  static const TextTheme textTheme = TextTheme(
    headline1: headline1,
    headline2: headline2,
    headline3: headline3,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle1: subtitle1,
    subtitle2: subtitle2,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
    button: button,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle1 = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.15,
    color: darkText,
  );

  static const TextStyle subtitle2 = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.1,
    color: darkText,
  );

  static const TextStyle button = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 1.25,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextStyle headline1 = TextStyle(
    fontFamily: fontName,
    fontSize: 96.0,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontName,
    fontSize: 60.0,
    fontWeight: FontWeight.w900,
    letterSpacing: -0.5,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontName,
    fontSize: 48.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontName,
    fontSize: 34.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontName,
    fontSize: 24.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.0,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: fontName,
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  );

  static const OutlineInputBorder inputBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      color: darkGreen,
      width: 3.0,
    ),
  );

  static const OutlineInputBorder inputBorderless = OutlineInputBorder(
    borderSide: BorderSide(
      color: white,
      width: 0.0,
    ),
  );

  static final BoxDecoration boxDecoration = BoxDecoration(
    color: AppTheme.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4.0),
      bottomLeft: Radius.circular(4.0),
      bottomRight: Radius.circular(4.0),
      topRight: Radius.circular(4.0),
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: grey.withOpacity(0.3),
        offset: Offset(2, 2),
        blurRadius: 2.0,
      )
    ],
  );
}
