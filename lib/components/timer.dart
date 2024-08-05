import 'dart:async';
import 'package:flutter/material.dart';

import '../theme.dart';

class CountdownTimer extends StatefulWidget {
  final int seconds;

  CountdownTimer({required Key key, required this.seconds}) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remainingSeconds;
  Timer? _timer;
  bool _isRunning = false; // Track if the timer is running

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    if (!_isRunning) {
      _timer?.cancel();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
        } else {
          _timer?.cancel();
          setState(() {
            _isRunning = false;
          });
        }
      });
      setState(() {
        _isRunning = true;
      });
    } else {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void resetTimer() {
    setState(() {
      _remainingSeconds = widget.seconds;
      _isRunning = false;
    });
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _remainingSeconds / widget.seconds;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey,
                  valueColor:isDarkMode ? AlwaysStoppedAnimation<Color>(Colors.white): AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
              Text(
                _remainingSeconds.toString(),
                style: TextStyle(fontSize: 30, color: isDarkMode ? colors.mainText : colors.secondaryText,),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: startTimer,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text(
                  _isRunning ? 'Stop' : 'Start',
                  style: TextStyle(fontSize: 20,),
                ),
              ),
              ElevatedButton(
                onPressed: resetTimer,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
