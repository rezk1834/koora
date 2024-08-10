import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/theme.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/games database/Players.dart';
import '../drawer.dart';

class Acting extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Acting({required this.redScore, required this.blueScore});

  @override
  State<Acting> createState() => _ActingState();
}

class _ActingState extends State<Acting> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(10, Players.length);
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
      randomNumbers[questionsNumber] = random.nextInt(Players.length);
    });
  }

  void _checkGameEnd() {
    if (questionsNumber == 10) {
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
    } else if (gameRedScore == 4 && gameBlueScore == 4) {
      showWinnerDialog('Draw', context, redScore, blueScore);
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
          'تمثيل',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Teko',
            color: isDarkMode ? colors.mainText : colors.secondaryText,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      drawer: TheDrawer(),
      body: Stack(
        children: [
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
                          scoreContainer(gameRedScore.toString(), colors.team1, 35,isDarkMode),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team1,size: 35,),
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
                          scoreContainer(gameBlueScore.toString(), colors.team2, 35,isDarkMode),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team2,size: 35,),
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
                      Players[randomNumbers[questionsNumber]]['name'] as String,
                      style: TextStyle(
                        fontSize: 40,
                        color: isDarkMode ? colors.mainText : colors.secondaryText,
                      ),
                    ),
                  ),
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
                  ElevatedButton(
                    onPressed: changeQuestion,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                      foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                      backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                    ),
                    child: Text('تغيير الاسم',style: TextStyle(fontSize: 20),),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: draw,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                      foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                      backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                    ),
                    child: Text('لا أجابة',style: TextStyle(fontSize: 20),),
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