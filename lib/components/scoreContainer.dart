import 'package:flutter/material.dart';

Widget scoreContainer(String title, Color color, double fontSize,bool isDarkMode) {
  return Container(
    width: 50, // Set the width to make it a square
    height: 50, // Set the height to match the width
    decoration: BoxDecoration(
      color: isDarkMode? Color(0xff1f252c):Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(8), // Set slight border radius for a smooth corner
      border: Border.all(
        color: color, // Set the border color
        width: 2, // Set the border width
      ),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.7), // Apply shadow with opacity
          offset: Offset(5, 5), // Offset the shadow to the bottom right
          blurRadius: 4, // Optional: Blur the shadow for a softer effect
        ),
      ],
    ),
    child: Center(
      child: FittedBox( // Handle long titles
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(color: color, fontSize: 35,fontFamily: "Sarpanch"),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
