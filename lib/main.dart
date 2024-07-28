import 'package:flutter/material.dart';
import 'package:football/round%2016/round.dart';
import 'package:football/saba7o/saba7o.dart';
import '30 challenge/challenge.dart';
import 'aqua ta7ady/aqua.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'احنا بتوع الكورة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily:"Amiri",
      ),
      home: home_screen(),
      routes: {
        '/saba7o': (context) => saba7o(),
        '/aqua': (context) => aqua(),
        '/challenge': (context) => challenge(),
        '/round': (context) => NameEntryScreen(),

      },
    );
  }
}
