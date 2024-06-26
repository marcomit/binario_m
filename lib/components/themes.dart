import 'package:binario_m/utils/global.dart';
import 'package:flutter/material.dart';

ThemeData LightTheme(Color colorSeed) {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: colorSeed,
    primaryColorDark: increaseColorFromPercentage(colorSeed, -.2),
    primaryColorLight: increaseColorFromPercentage(colorSeed, 0.5),
    // primarySwatch: ColorTools.createPrimarySwatch(colorSeed),
    // colorSchemeSeed: ColorTools.createPrimarySwatch(colorSeed),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.black,
        textColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.black),
        subtitleTextStyle: TextStyle(color: Colors.black),
        leadingAndTrailingTextStyle: TextStyle(color: Colors.black)),
    cardTheme: const CardTheme(color: Colors.white, shadowColor: Colors.black),
    shadowColor: Colors.black,
  );
}

ThemeData DarkTheme(Color colorSeed) {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: colorSeed,
    primaryColorDark: increaseColorFromPercentage(colorSeed, .5),
    primaryColorLight: increaseColorFromPercentage(colorSeed, -.5),
    //colorSchemeSeed: ColorTools.createPrimarySwatch(colorSeed),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey[600]),
      labelStyle: const TextStyle(color: Colors.black),
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.white),
        subtitleTextStyle: TextStyle(color: Colors.white),
        leadingAndTrailingTextStyle: TextStyle(color: Colors.white)),
    cardTheme: const CardTheme(color: Colors.black, shadowColor: Colors.white),
    shadowColor: Colors.white,
  );
}
