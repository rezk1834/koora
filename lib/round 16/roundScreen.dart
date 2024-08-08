import 'package:flutter/material.dart';
import 'package:football/round%2016/winnerScreen.dart';
import '../theme.dart';

class RoundScreen extends StatefulWidget {
  final List<String> names;
  final String title;

  RoundScreen({required this.names, required this.title});

  @override
  _RoundScreenState createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  late List<String> _currentRound;
  late List<String> _nextRound;
  late List<Color> _buttonColors;
  int _roundNumber = 16;

  @override
  void initState() {
    super.initState();
    _currentRound = List.from(widget.names)..shuffle();
    _nextRound = [];
    _buttonColors = List.generate(_currentRound.length, (_) => Colors.grey);
  }

  void _playNextRound() {
    if (_currentRound.length == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WinnerScreen(winner: _currentRound.first,title: widget.title)),
      );
    } else {
      setState(() {
        _currentRound = List.from(_nextRound);
        _nextRound.clear();
        _buttonColors = List.generate(_currentRound.length, (_) => Colors.grey);
        _roundNumber = _currentRound.length;
      });
    }
  }

  String titles(int x) {
    switch (x) {
      case 16:
        return 'دور ال16';
      case 8:
        return 'ربع النهائي';
      case 4:
        return 'نصف النهائي';
      case 2:
        return 'النهائي';
      case 1:
        return 'الفائز';
      default:
        return '';
    }
  }

  void _handleButtonPress(int index) {
    if (_buttonColors[index] != Colors.grey) return;

    setState(() {
      _buttonColors[index] = Colors.green;

      int otherIndex = (index % 2 == 0) ? index + 1 : index - 1;

      if (otherIndex >= 0 && otherIndex < _buttonColors.length) {
        _buttonColors[otherIndex] = Colors.red;
      }

      _nextRound.add(_currentRound[index]);

      if (_nextRound.length == _currentRound.length ~/ 2) {
        _playNextRound();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          titles(_currentRound.length),
          style: TextStyle(fontSize: 30, fontFamily: 'Teko', color: isDarkMode ? colors.mainText : colors.secondaryText),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              for (int i = 0; i < _currentRound.length; i += 2)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () => _handleButtonPress(i),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 2, color: _buttonColors[i]),
                            foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                            backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                          ),
                          child: Text(_currentRound[i], style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                    if (i + 1 < _currentRound.length)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () => _handleButtonPress(i + 1),
                            style: ElevatedButton.styleFrom(
                              side: BorderSide(width: 2, color: _buttonColors[i + 1]),
                              foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                              backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                            ),
                            child: Text(_currentRound[i + 1], style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
