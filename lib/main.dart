import 'package:flutter/material.dart';
import 'package:football/home_screen.dart';
import 'package:football/round%2016/round.dart';
import 'package:football/games.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'احنا بتوع الكورة',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: ThemeMode.system,
      // Use system setting for light/dark mode
      home: home_screen(),
      routes: {
        '/games': (context) => Games(),
        '/round': (context) => NameEntryScreen(),
        '/home': (context) => home_screen(),

      },
    );
  }
}
  ThemeData get _lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.lightBackground,
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: "Amiri",
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        color: colors.lightAppbarBackground,
      ),
      scaffoldBackgroundColor: colors.lightBackground,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.secondaryText), // Updated from bodyText1
        bodyMedium: TextStyle(color: colors.tertiaryText), // Updated from bodyText2
      ),
      // Add other light theme properties here
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: colors.darkBackground,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: "Amiri",
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        color: colors.darkAppbarBackground,
      ),
      scaffoldBackgroundColor: colors.darkBackground,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.mainText), // Updated from bodyText1
        bodyMedium: TextStyle(color: colors.tertiaryText), // Updated from bodyText2
      ),
      // Add other dark theme properties here
    );
  }
