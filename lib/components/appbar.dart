import 'package:flutter/material.dart';
import '../theme.dart';

class TheAppBar extends StatefulWidget {
  final String title;
  const TheAppBar({super.key, required this.title});

  @override
  State<TheAppBar> createState() => _TheAppBarState();
}

class _TheAppBarState extends State<TheAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AppBar(
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Teko',
          color: isDarkMode ? colors.mainText : colors.secondaryText,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
    );
  }
}
