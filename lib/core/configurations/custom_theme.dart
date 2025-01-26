import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => Colors.white),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) => Colors.black),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.black,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );
}
