import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/database.dart';
import '../database/saba7o database/guess_the_player_data.dart';

class GuessThePlayer extends StatefulWidget {
  final int redScore;
  final int blueScore;

  GuessThePlayer({required this.redScore, required this.blueScore});

  @override
  State<GuessThePlayer> createState() => _GuessThePlayerState();
}

class _GuessThePlayerState extends State<GuessThePlayer> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  int clueNumber = 0;
  bool showName = false;
  Random random = Random();
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(3, guessThePlayer_data.length);
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
      if (questionsNumber < 2) {
        questionsNumber++;
        clueNumber = 0;
        showName = false;
      } else {
        _endGame();
      }
    });
  }

  void _endGame() {
    if (gameRedScore > gameBlueScore) {
      redScore++;
      _showWinnerDialog('Red Team');
    } else if (gameRedScore < gameBlueScore) {
      blueScore++;
      _showWinnerDialog('Blue Team');
    } else {
      redScore++;
      blueScore++;
      _showWinnerDialog('Draw');
    }
  }

  void _showWinnerDialog(String winningTeam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: winningTeam == 'Draw' ? Colors.grey : (winningTeam == 'Blue Team' ? Colors.blue : Colors.red),
          content: Text(
            '$winningTeam wins!',
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

  void changeQuestion() {
    setState(() {
      randomNumbers[questionsNumber] = random.nextInt(guessThePlayer_data.length);
      clueNumber = 0;
      showName = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> currentPlayerData = guessThePlayer_data[randomNumbers[questionsNumber]];

    return Scaffold(
      appBar: AppBar(
        title: Text('Guess The Player Page'),
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
                            if (gameRedScore == 2) {
                              _endGame();
                            } else {
                              questionsNumber++;
                              clueNumber = 0;
                              showName = false;
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
                            if (gameBlueScore == 2) {
                              _endGame();
                            } else {
                              questionsNumber++;
                              clueNumber = 0;
                              showName = false;
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: clueNumber + 1, // Show clues up to the current clueNumber
                        itemBuilder: (context, index) {
                          String clueKey = 'Clue ${index + 1}';
                          return ListTile(
                            title: Text(
                              currentPlayerData[clueKey] ?? 'No more clues',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ),
                    if (showName) // Show name if flag is true
                      Text(
                        currentPlayerData['name']?.toString() ?? 'Name not available',
                        style: TextStyle(fontSize: 30, color: Colors.green),
                      ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Show the next clue
                          if (clueNumber < 4) { // Adjust this based on the number of clues available
                            clueNumber++;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey[700],
                      ),
                      child: Text('Show Next Clue'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Toggle the visibility of the name
                          showName = !showName;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff14213d),
                      ),
                      child: Text(showName ? 'Hide Name' : 'Show Name'),
                    ),
                  ],
                ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
