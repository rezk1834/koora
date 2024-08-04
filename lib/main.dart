import 'package:flutter/material.dart';
import 'package:football/round%2016/round.dart';
import 'package:football/games.dart';
import 'package:football/saba7o/saba7o.dart';
import 'saba7o/challenge.dart';
import 'aqua ta7ady/aqua.dart';
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
      themeMode: ThemeMode.system, // Use system setting for light/dark mode
      home: Games(),
      routes: {
        '/games': (context) => Games(),
        '/aqua': (context) => aqua(),
        '/challenge': (context) => challenge(),
        '/round': (context) => NameEntryScreen(),
      },
    );
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
        bodyText1: TextStyle(color: colors.secondaryText),
        bodyText2: TextStyle(color: colors.tertiaryText),
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
        bodyText1: TextStyle(color: colors.mainText),
        bodyText2: TextStyle(color: colors.tertiaryText),
      ),
      // Add other dark theme properties here
    );
  }
}
