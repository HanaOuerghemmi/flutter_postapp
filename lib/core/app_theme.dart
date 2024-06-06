
import 'package:flutter/material.dart';

final primaryColor = Color.fromRGBO(202, 198, 198, 1);
final secondaryColor = Color.fromARGB(255, 249, 249, 249);
final BgColor = Color.fromRGBO(222, 218, 218, 1);
final blackColor = Colors.black;

final appTheme = ThemeData(
  
  scaffoldBackgroundColor: BgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrangeAccent,
      foregroundColor: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: blackColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        )));

  
  final baseBoxDecoration = BoxDecoration(
  color: secondaryColor.withOpacity(0.2),
  borderRadius: BorderRadius.all(Radius.circular(25)), // Const border radius
  boxShadow: [
    BoxShadow(
      color: secondaryColor.withOpacity(0.4),
      spreadRadius: 2, // Can be const if it was a constant value
      blurRadius: 5, // Can be const if it was a constant value
      offset: Offset(0, 3), // Const offset
    ),
  ],
);

