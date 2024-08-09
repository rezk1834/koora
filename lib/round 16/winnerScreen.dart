import 'package:flutter/material.dart';
import '../drawer.dart';
import '../theme.dart';

class WinnerScreen extends StatefulWidget {
  final String winner;
  final String title;

  const WinnerScreen({Key? key, required this.winner, required this.title}) : super(key: key);

  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String modifiedTitle = widget.title.replaceAll('افضل', '').trim();
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Winner',style: TextStyle(
          fontSize: 30,
          fontFamily: 'Teko',
          color: isDarkMode ? colors.mainText : colors.secondaryText,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
    ),
      drawer: TheDrawer(),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'أفضل $modifiedTitle هو ${widget.winner}', style: TextStyle( color: isDarkMode ? colors.mainText : colors.secondaryText,fontSize: 40), // Adjust text style if needed
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                    foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                    backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                  ),
                  onPressed: () {
                    // Navigate to RoundScreen
                    Navigator.pushReplacementNamed(context, '/round');
                  },
                  child: Text('لعب مناقشة اخري'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                    foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                    backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                  ),
                  onPressed: () {
                    // Navigate to HomeScreen
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text('العودة الي القائمة الرئيسية'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
