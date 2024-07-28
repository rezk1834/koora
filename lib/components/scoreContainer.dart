import 'package:flutter/material.dart';

Widget scoreContainer(String title, Color color,double fontSize) {
  return Container(
    width: 70,
    height: 40,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: fontSize=fontSize),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
