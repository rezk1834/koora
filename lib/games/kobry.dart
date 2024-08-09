import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/components/timer.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/games database/Kobry_data.dart';
import '../drawer.dart';
import '../theme.dart';
class Kobry extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Kobry({required this.redScore, required this.blueScore});

  @override
  State<Kobry> createState() => _KobryState();
}

class _KobryState extends State<Kobry> {
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
    randomNumbers = generateUniqueRandomNumbers(8, Kobry_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }


  void _checkGameEnd() {
    if (questionsNumber == 8) {
      questionsNumber--;
      if (gameRedScore > gameBlueScore) {
        redScore++;
        showWinnerDialog('Red Team', context, redScore, blueScore);
      } else if (gameRedScore < gameBlueScore) {
        blueScore++;
        showWinnerDialog('Blue Team', context, redScore, blueScore);
      } else {
        showWinnerDialog('Draw', context, redScore, blueScore);
      }
    }
  }

  void nextQuestion() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
      timerKey = UniqueKey();
    });
  }

  void changeQuestion() {
    setState(() {
      _checkGameEnd();
      randomNumbers[questionsNumber] = random.nextInt(Kobry_data.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors
          .lightBackground,
      appBar: AppBar(
        title: Text(
          'كوبري',
          style: TextStyle(fontSize: 30,
              fontFamily: 'Teko',
              color: isDarkMode ? colors.mainText : colors.secondaryText),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors
            .lightAppbarBackground,
        automaticallyImplyLeading: false,
      ),
      drawer: TheDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(
              'سؤال رقم: ${questionsNumber + 1}',
              style: TextStyle(fontSize: 27,
                  fontFamily: 'Zain',
                  color: isDarkMode ? colors.mainText : colors.secondaryText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      scoreContainer(gameRedScore.toString(), colors.team1, 35,
                          isDarkMode),
                      IconButton(
                        icon: Icon(Icons.add, color: colors.team1, size: 35),
                        onPressed: () {
                          setState(() {
                            gameRedScore++;
                            questionsNumber++;
                            _checkGameEnd();
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      scoreContainer(gameBlueScore.toString(), colors.team2, 35,
                          isDarkMode),
                      IconButton(
                        icon: Icon(Icons.add, color: colors.team2, size: 35),
                        onPressed: () {
                          setState(() {
                            gameBlueScore++;
                            questionsNumber++;
                            _checkGameEnd();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    Kobry_data[randomNumbers[questionsNumber]]['player1'] as String,
                    style: TextStyle(fontSize: 30,
                        color: isDarkMode ? colors.mainText : colors
                            .secondaryText),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    Kobry_data[randomNumbers[questionsNumber]]['player2'] as String,
                    style: TextStyle(fontSize: 30,
                        color: isDarkMode ? colors.mainText : colors
                            .secondaryText),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                Kobry_data[randomNumbers[questionsNumber]]['rule'] as String,
                style: TextStyle(fontSize: 30,
                    color: isDarkMode ? colors.mainText : colors.secondaryText),
              ),
            ),
            CountdownTimer(key: timerKey,
                seconds: Kobry_data[randomNumbers[questionsNumber]]['time']),
            SizedBox(height: 20), // Add some space before the button
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: changeQuestion,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,
                      color: isDarkMode ? colors.mainText : colors
                          .secondaryText),
                  foregroundColor: isDarkMode ? colors.mainText : colors
                      .secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent : colors
                      .lightbutton,
                ),
                child: Text('تغيير الاسم'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}