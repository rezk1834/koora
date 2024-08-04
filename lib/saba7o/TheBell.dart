import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/scoreContainer.dart';
import '../theme.dart';
import '../database/saba7o database/TheBell_data.dart';

class TheBell extends StatefulWidget {
  final int redScore;
  final int blueScore;

  TheBell({required this.redScore, required this.blueScore});

  @override
  State<TheBell> createState() => _TheBellState();
}

class _TheBellState extends State<TheBell> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  ValueNotifier<bool> showAnswerNotifier = ValueNotifier<bool>(false);
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(5, TheBell_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }

  void draw() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
    });
  }

  void changeQuestion() {
    setState(() {
      _checkGameEnd();
      showAnswerNotifier.value = false;
      randomNumbers[questionsNumber] = random.nextInt(TheBell_data.length);
    });
  }

  void toggleAnswer() {
    showAnswerNotifier.value = !showAnswerNotifier.value;
  }

  void _showWinnerDialog(String winningTeam) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Stack(
          children: [
            ModalBarrier(
              color: Colors.black.withOpacity(0.5),
              dismissible: false,
            ),
            AlertDialog(
              backgroundColor: winningTeam == 'Draw'
                  ? colors.tertiaryText
                  : (winningTeam == 'Blue Team' ? colors.team2 : colors.team1),
              content: Text(
                winningTeam == 'Draw' ? '$winningTeam!' : '$winningTeam wins!',
                style: TextStyle(color: isDarkMode ? colors.mainText : Colors.black, fontSize: 25),
              ),
            ),
          ],
        );
      },
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context); // Close the alert dialog
      Navigator.pop(context, [redScore, blueScore]); // Navigate back
    });
  }

  void _checkGameEnd() {
    showAnswerNotifier.value = false;
    if (questionsNumber == 5) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'الجرس',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Teko',
            color: isDarkMode ? colors.mainText : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          scoreContainer(gameRedScore.toString(), colors.team1, 20),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team1),
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
                      Text(
                        'Question No.${questionsNumber + 1}',
                        style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: isDarkMode ? colors.mainText : Colors.black),
                      ),
                      Column(
                        children: [
                          scoreContainer(gameBlueScore.toString(), colors.team2, 20),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team2),
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
                      TheBell_data[randomNumbers[questionsNumber]]['question']
                      as String,
                      style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : Colors.black),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: showAnswerNotifier,
                  builder: (context, showAnswer, child) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: showAnswer
                          ? Text(
                        TheBell_data[randomNumbers[questionsNumber]]
                        ['answer']
                            .toString(),
                        style: TextStyle(
                            fontSize: 40,
                            color: isDarkMode ? colors.mainText : Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                          : Text(""),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 30,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: draw,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isDarkMode ? colors.mainText : Colors.black,
                          backgroundColor: colors.answerButton,
                        ),
                        child: Text('No Answer'),
                      ),
                      ElevatedButton(
                        onPressed: changeQuestion,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: isDarkMode ? colors.mainText : Colors.black,
                          backgroundColor: colors.questionButton,
                        ),
                        child: Text('Change the question'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: toggleAnswer,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: isDarkMode ? colors.mainText : Colors.black,
                      backgroundColor: colors.button3,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: showAnswerNotifier,
                      builder: (context, showAnswer, child) {
                        return Text(showAnswer ? 'Hide Answer' : 'Show Answer');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
