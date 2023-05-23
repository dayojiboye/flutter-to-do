import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/utils/colors.dart';

class AppThemeData {
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: kBackGroundColor,
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryTextColor,
    dividerColor: kBorder,
    fontFamily: GoogleFonts.interTight().fontFamily,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: kBackGroundColor,
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: kPrimaryTextColor,
        fontWeight: FontWeight.w500,
        fontFamily: GoogleFonts.interTight().fontFamily,
      ),
      iconTheme: const IconThemeData(color: kSecondaryTextColor),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
    ),
    cardTheme: const CardTheme(color: Colors.white),
    cardColor: Colors.white,
    iconTheme: const IconThemeData(color: kPrimaryTextColor),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: kBackGroundColor),
    textTheme: GoogleFonts.interTightTextTheme().copyWith(
      labelLarge: const TextStyle(color: kPrimaryTextColor),
      titleLarge: const TextStyle(color: kPrimaryTextColor),
      titleSmall: const TextStyle(color: kPrimaryTextColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: OpenUpwardsPageTransitionsBuilder(),
        }),
  );

// To-Do: Implement Dark theme
  // static final ThemeData darkTheme = ThemeData();
}
