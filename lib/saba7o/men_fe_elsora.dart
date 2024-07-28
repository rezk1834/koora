import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';

class Men_fe_elsora extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Men_fe_elsora({required this.redScore, required this.blueScore});

  @override
  State<Men_fe_elsora> createState() => _Men_fe_elsoraState();
}

class _Men_fe_elsoraState extends State<Men_fe_elsora> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  late List<int> randomNumbers;
  ValueNotifier<bool> showNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(5, Men_fe_elsora_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }

  void _endGame(String winningTeam) {
    if (winningTeam == "Red") {
      redScore++;
    } else if (winningTeam == "Blue") {
      blueScore++;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: winningTeam == 'Blue' ? Colors.blue : Colors.red,
          content: Text(
            '$winningTeam Team wins!',
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

  void toggleAnswer() {
    showNotifier.value = !showNotifier.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Men_fe_elsora Page'),
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
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            gameRedScore++;
                            if (gameRedScore == 3) {
                              _endGame("Red");
                            } else {
                              questionsNumber++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Question No.${questionsNumber + 1}',
                    style: TextStyle(fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            gameBlueScore++;
                            if (gameBlueScore == 3) {
                              _endGame("Blue");
                            } else {
                              questionsNumber++;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        Men_fe_elsora_data[randomNumbers[questionsNumber]]['title'] as String,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        Men_fe_elsora_data[randomNumbers[questionsNumber]]['image'] as String,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      ValueListenableBuilder<bool>(
                        valueListenable: showNotifier,
                        builder: (context, show, child) {
                          return Column(
                            children: [
                              for (int i = 1; i <= 11; i++)
                                Text(
                                  show
                                      ? Men_fe_elsora_data[randomNumbers[questionsNumber]]
                                  ['player$i']
                                  as String
                                      : "",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ElevatedButton(
                                onPressed: toggleAnswer,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Color(0xfffdca40),
                                ),
                                child: Text(show ? 'Hide Answer' : 'Show Answer'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
