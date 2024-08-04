import 'package:flutter/material.dart';
import 'package:football/theme.dart';

Widget scoreContainer(String title, Color color, double fontSize) {
  return Container(
    width: 70,
    height: 40,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(
        color: color, // Set the border color here
        width: 2, // Set the border width here
      ),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: color, fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
