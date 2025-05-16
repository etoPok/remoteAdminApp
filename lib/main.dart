import 'screen/splash.dart';

import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF2b2b2b);
  static const Color backgroundColor = Colors.black;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemoteAdmin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: backgroundColor,

        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          )
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: backgroundColor,
        ),
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
          selectedColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: primaryColor,
        ),

        dividerColor: Colors.grey
      ),
      home: const SplashPage(),
    );
  }
}