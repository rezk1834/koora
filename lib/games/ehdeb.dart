import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/functions.dart';
import '../database/saba7o database/Ehbed_data.dart';
import 'package:football/theme.dart';

class Ehbed extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Ehbed({required this.redScore, required this.blueScore});

  @override
  State<Ehbed> createState() => _EhbedState();
}

class _EhbedState extends State<Ehbed> {
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
    randomNumbers = generateUniqueRandomNumbers(5, Ehbed_data.length);
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
      randomNumbers[questionsNumber] = random.nextInt(Ehbed_data.length);
    });
  }

  void toggleAnswer() {
    showAnswerNotifier.value = !showAnswerNotifier.value;
  }



  void checkGameEnd() {
    showAnswerNotifier.value = false;
    if (questionsNumber == 5) {
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
    return Scaffold(
      backgroundColor: colors.darkBackground,
      appBar: AppBar(
        backgroundColor: colors.darkAppbarBackground,
        title: Text(
          'اهبد صح',
          style: TextStyle(fontSize: 30, fontFamily: 'Teko', color: colors.mainText),
        ),
        centerTitle: true,
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
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colors.team1,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                gameRedScore.toString(),
                                style: TextStyle(color: colors.mainText, fontSize: 25),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team1),
                            onPressed: () {
                              setState(() {
                                gameRedScore++;
                                questionsNumber++;
                                checkGameEnd();
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Question No.${questionsNumber + 1}',
                        style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: colors.mainText),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colors.team2,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                gameBlueScore.toString(),
                                style: TextStyle(color: colors.mainText, fontSize: 25),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: colors.team2),
                            onPressed: () {
                              setState(() {
                                gameBlueScore++;
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
                    color: colors.mainText.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      Ehbed_data[randomNumbers[questionsNumber]]['question']
                      as String,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: showAnswerNotifier,
                  builder: (context, showAnswer, child) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.mainText.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: showAnswer
                          ? Text(
                        Ehbed_data[randomNumbers[questionsNumber]]
                        ['answer']
                            .toString(),
                        style: TextStyle(fontSize: 40, color: colors.mainText),
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
                        onPressed: toggleAnswer,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: colors.mainText,
                          backgroundColor: colors.button3,
                        ),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: showAnswerNotifier,
                          builder: (context, showAnswer, child) {
                            return Text(showAnswer ? 'Hide Answer' : 'Show Answer');
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: changeQuestion,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: colors.mainText,
                          backgroundColor: colors.questionButton,
                        ),
                        child: Text('Change the question'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: draw,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colors.mainText,
                      backgroundColor: Colors.transparent,
                    ),
                    child: Text('No Answer'),
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
