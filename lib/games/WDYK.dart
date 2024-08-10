import 'dart:math';
import 'package:flutter/material.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../drawer.dart';
import '../theme.dart';
import '../database/games database/WDYK_data.dart';

class WDYK extends StatefulWidget {
  final int redScore;
  final int blueScore;

  WDYK({required this.redScore, required this.blueScore});

  @override
  State<WDYK> createState() => _WDYKState();
}

class _WDYKState extends State<WDYK> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  int redStrikes = 0;
  int blueStrikes = 0;
  Random random = Random();
  ValueNotifier<bool> showAnswerNotifier = ValueNotifier<bool>(false);
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(4, WDYK_data.length);
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
      checkGameEnd();
    });
  }

  void changeQuestion() {
    setState(() {
      checkGameEnd();
      showAnswerNotifier.value = false;
      randomNumbers[questionsNumber] = random.nextInt(WDYK_data.length);
    });
  }

  void toggleAnswer() {
    showAnswerNotifier.value = !showAnswerNotifier.value;
  }

  void strike(bool isRedTeam) {
    setState(() {
      if (isRedTeam) {
        redStrikes++;
      } else {
        blueStrikes++;
      }
      checkStrike();
    });
  }

  void checkStrike() {
    if (redStrikes == 3) {
      setState(() {
        redStrikes = 0;
        blueStrikes = 0;
        questionsNumber++;
        gameBlueScore++;
        checkGameEnd();
      });
    }
    if (blueStrikes == 3) {
      setState(() {
        redStrikes = 0;
        blueStrikes = 0;
        questionsNumber++;
        gameRedScore++;
        checkGameEnd();
      });
    }
  }

  void checkGameEnd() {
    showAnswerNotifier.value = false;
    if (questionsNumber == 4) {
      questionsNumber--; // to not exceed the length of questions
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'ماذا تعرف',
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
                  'Question No.${questionsNumber + 1}',
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
                          SizedBox(height: 5,),
                          Text(
                            'سترايك: $redStrikes',
                            style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              strike(true);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.team1,
                            ),
                            child: Text('سترايك', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          scoreContainer(gameBlueScore.toString(), colors.team2, 35, isDarkMode),
                          SizedBox(height: 5,),
                          Text(
                            'سترايك: $blueStrikes',
                            style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              strike(false);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.team2,
                            ),
                            child: Text('سترايك', style: TextStyle(color: Colors.white)),
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
                      WDYK_data[randomNumbers[questionsNumber]]['question'] as String,
                      style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),
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
                        WDYK_data[randomNumbers[questionsNumber]]['answer'].toString(),
                        style: TextStyle(
                            fontSize: 40,
                            color: isDarkMode ? colors.mainText : colors.secondaryText,
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
                        onPressed: changeQuestion,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                        ),
                        child: Text('تغيير السؤال',style: TextStyle(fontSize: 20),),
                      ),
                      ElevatedButton(
                        onPressed: toggleAnswer,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                        ),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: showAnswerNotifier,
                          builder: (context, showAnswer, child) {
                            return Text(showAnswer ? 'اخفاء الاجابة' : 'اظهار الاجابة',style: TextStyle(fontSize: 20),);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
