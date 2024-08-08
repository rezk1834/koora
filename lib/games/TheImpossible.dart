import 'dart:math';
import 'package:flutter/material.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../theme.dart';
import '../database/saba7o database/TheImpossible_data.dart';

class TheImpossible extends StatefulWidget {
  final int redScore;
  final int blueScore;

  TheImpossible({required this.redScore, required this.blueScore});

  @override
  State<TheImpossible> createState() => _TheImpossibleState();
}

class _TheImpossibleState extends State<TheImpossible> {
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
    randomNumbers = generateUniqueRandomNumbers(8, TheImpossible_data.length);
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
      randomNumbers[questionsNumber] = random.nextInt(TheImpossible_data.length);
    });
  }

  void toggleAnswer() {
    showAnswerNotifier.value = !showAnswerNotifier.value;
  }



  void checkGameEnd() {
    showAnswerNotifier.value = false;
    if (questionsNumber == 8) {
      questionsNumber--;
      if (gameRedScore > gameBlueScore) {
        redScore++;
        showWinnerDialog('Red Team',context,redScore,blueScore);
      } else if (gameRedScore < gameBlueScore) {
        blueScore++;
        showWinnerDialog('Blue Team',context,redScore,blueScore);
      } else {
        showWinnerDialog('Draw',context,redScore,blueScore);
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
          'المستحيل',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Teko',
            color: isDarkMode ? colors.mainText : colors.secondaryText,
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
                      Text(
                        'سؤال رقم: ${questionsNumber + 1}',
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
                                gameRedScore+=2;
                                questionsNumber++;
                                checkGameEnd();
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
                                gameBlueScore+=2;
                                questionsNumber++;
                                checkGameEnd();
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
                      TheImpossible_data[randomNumbers[questionsNumber]]['question']
                      as String,
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
                        TheImpossible_data[randomNumbers[questionsNumber]]
                        ['answer']
                            .toString(),
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
                        onPressed: draw,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                        ),
                        child: Text('لا اجابة',style: TextStyle(fontSize: 20),),
                      ),
                      ElevatedButton(
                        onPressed: changeQuestion,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                        ),
                        child: Text('تغيير السؤال',style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: toggleAnswer,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                      foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                      backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: showAnswerNotifier,
                      builder: (context, showAnswer, child) {
                        return Text(showAnswer ? 'إخفاؤ الاجابة' : 'إظهار الاجابة',style: TextStyle(fontSize: 20),);
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
