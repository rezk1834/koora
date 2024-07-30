import 'dart:math';
import 'package:flutter/material.dart';
import '../components/drawingpage.dart';
import '../database/database.dart';
import '../database/saba7o database/draw_data.dart';

class Draw extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Draw({required this.redScore, required this.blueScore});

  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
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
    randomNumbers = generateUniqueRandomNumbers(8, Draw_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }

  void _showWinnerDialog(String winningTeam) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            ModalBarrier(
              color: Colors.black.withOpacity(0.5),
              dismissible: false,
            ),
            AlertDialog(
              backgroundColor: winningTeam == 'Draw'
                  ? Colors.grey
                  : (winningTeam == 'Blue Team' ? Colors.blue : Colors.red),
              content: Text(
                winningTeam == 'Draw' ? '$winningTeam!' : '$winningTeam wins!',
                style: TextStyle(color: Colors.white, fontSize: 25),
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
    if (questionsNumber == 8) {
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

  void draw() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
    });
  }

  void changeQuestion() {
    setState(() {
      _checkGameEnd();
      randomNumbers[questionsNumber] = random.nextInt(Draw_data.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('الرسم', style: TextStyle(fontSize: 30,fontFamily: 'Teko'),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Column(
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
                                questionsNumber++;
                                _checkGameEnd();
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
                SizedBox(height: 10),
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
                      Draw_data[randomNumbers[questionsNumber]]['name'] as String,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
                Container(
                  child: ClipRRect(
                    child: Image(
                      image: AssetImage(Draw_data[randomNumbers[questionsNumber]]['photo'] as String),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 50,
              left: 10,
              right: 150,
              child: ElevatedButton(
                onPressed: changeQuestion,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text('Change the question'),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 20,
              left: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DrawingPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
                child: Icon(Icons.draw_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
