import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/components/timer.dart';
import '../database/database.dart';
import '../database/saba7o database/labes_sa7bak_data.dart';

class labesSa7bak extends StatefulWidget {
  final int redScore;
  final int blueScore;

  labesSa7bak({required this.redScore, required this.blueScore});

  @override
  State<labesSa7bak> createState() => _labesSa7bakState();
}

class _labesSa7bakState extends State<labesSa7bak> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  late Key timerKey;
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    timerKey = UniqueKey();
    randomNumbers = generateUniqueRandomNumbers(8, labesSa7bak_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();
    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }
    return uniqueNumbers.toList();
  }

  void nextQuestion() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
      timerKey = UniqueKey();
    });
  }


  void _showWinnerDialog(String winningTeam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: winningTeam == 'Draw' ? Colors.grey : (winningTeam == 'Blue Team' ? Colors.blue : Colors.red),
          content: Text(
            winningTeam == 'Draw' ? '$winningTeam!' : '$winningTeam wins!',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        );
      },
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context); // Close the alert dialog
      Navigator.pop(context, [redScore, blueScore]); // Navigate back
    });
  }

  void _checkGameEnd() {
    if (questionsNumber == 8) {
      questionsNumber--;
      if (gameRedScore > gameBlueScore) {
        redScore++;
        _showWinnerDialog('Red Team');
      } else if (gameRedScore < gameBlueScore) {
        blueScore++;
        _showWinnerDialog('Blue Team');
      } else {
        _showWinnerDialog('Draw');
      }
    }
  }

  void updateScores(int increment) {
    setState(() {
      if (increment == 1) {
        gameRedScore++;
        nextQuestion();
        _checkGameEnd();
      } else if (increment == 2) {
        gameBlueScore++;
        nextQuestion();
        _checkGameEnd();
      }
    });
  }

  Widget buildScoreColumn(Color color, int score, Function() onPressed) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add, color: color),
          onPressed: onPressed,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title:  Text('لبس صاحبك', style: TextStyle(fontSize: 30,fontFamily: 'Teko'),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildScoreColumn(Colors.red, gameRedScore, () => updateScores(1)),
                  Text(
                    'Question No.${questionsNumber + 1}',
                    style: TextStyle(fontSize: 27,fontFamily: 'Zain'),
                  ),
                  buildScoreColumn(Colors.blue, gameBlueScore, () => updateScores(2)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  labesSa7bak_data[randomNumbers[questionsNumber]]['question'] as String,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            CountdownTimer(key: timerKey, seconds: 30),
          ],
        ),
      ),
    );
  }
}
