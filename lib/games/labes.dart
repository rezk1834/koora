import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/components/timer.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/saba7o database/labes_sa7bak_data.dart';
import '../drawer.dart';
import '../theme.dart';

class Labes extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Labes({required this.redScore, required this.blueScore});

  @override
  State<Labes> createState() => _LabesState();
}

class _LabesState extends State<Labes> {
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
    randomNumbers = generateUniqueRandomNumbers(8, labes_data.length);
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
      questionsNumber--; // Adjusting to show the final question
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

  void _nextQuestion() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
      timerKey = UniqueKey(); // Reset timer
    });
  }

  void _changeQuestion() {
    setState(() {
      _checkGameEnd();
      if (questionsNumber < randomNumbers.length) {
        randomNumbers[questionsNumber] = random.nextInt(labes_data.length);
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
          'لبس صاحبك',
          style: TextStyle(fontSize: 30, fontFamily: 'Teko', color: isDarkMode ? colors.mainText : colors.secondaryText),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      drawer: TheDrawer(),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  'رقم السؤال: ${questionsNumber + 1}',
                  style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: isDarkMode ? colors.mainText : colors.secondaryText),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          scoreContainer(gameRedScore.toString(), colors.team1, 35, isDarkMode),
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
                          scoreContainer(gameBlueScore.toString(), colors.team2, 35, isDarkMode),
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
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      labes_data[randomNumbers[questionsNumber]]['question'] as String,
                      style: TextStyle(fontSize: 25, color: isDarkMode ? colors.mainText : colors.secondaryText),
                    ),
                  ),
                ),
                SizedBox(
                  height: 150, // Fixed height for the answer container
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          labes_data[randomNumbers[questionsNumber]]['answer'] as String,
                          style: TextStyle(fontSize: 18, color: isDarkMode ? colors.mainText : colors.secondaryText),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 30,
              right: 30,
              bottom: 90,
              child: CountdownTimer(key: timerKey, seconds: 30)),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _changeQuestion,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text('تغيير السؤال', style: TextStyle(fontSize: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
