import 'package:flutter/material.dart';
import '../theme.dart';

class AppyBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppyBar({super.key, required this.title});

  @override
  State<AppyBar> createState() => _AppyBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppyBarState extends State<AppyBar> {
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
