import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
import '../database/saba7o database/Ekdeb_data.dart';

class Ekdeb extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Ekdeb({required this.redScore, required this.blueScore});

  @override
  State<Ekdeb> createState() => _EkdebState();
}

class _EkdebState extends State<Ekdeb> {
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
    randomNumbers = generateUniqueRandomNumbers(5, Ekdeb_data.length);
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
      randomNumbers[questionsNumber] = random.nextInt(Ekdeb_data.length);
    });
  }

  void toggleAnswer() {
    showAnswerNotifier.value = !showAnswerNotifier.value;
  }

  void _showWinnerDialog(String winningTeam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: winningTeam == 'draw' ? Colors.grey : (winningTeam == 'Blue Team' ? Colors.blue : Colors.red),
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
    List<int> randomNumbers = generateUniqueRandomNumbers(5, Ekdeb_data.length);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
            'اكدب صح', style: TextStyle(fontSize: 30, fontFamily: 'Teko')),
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
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                gameRedScore.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.red),
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
                        style: TextStyle(fontSize: 27, fontFamily: 'Zain'),
                      ),
                      Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                gameBlueScore.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add, color: Colors.blue),
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
                      Ekdeb_data[randomNumbers[questionsNumber]]['question']
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
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: showAnswer
                          ? Text(
                        Ekdeb_data[randomNumbers[questionsNumber]]
                        ['answer']
                            .toString(),
                        style: TextStyle(
                            fontSize: 40, color: Colors.green),
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
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: draw,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueGrey,
                        ),
                        child: Text('No Answer'),
                      ),
                      ElevatedButton(
                        onPressed: changeQuestion,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        child: Text('Change the question'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: toggleAnswer,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xfffdca40),
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: showAnswerNotifier,
                      builder: (context, showAnswer, child) {
                        return Text(
                            showAnswer ? 'Hide Answer' : 'Show Answer');
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