import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/components/appbar.dart';
import '../components/drawingpage.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/database.dart';
import '../database/games database/draw_data.dart';
import '../components/drawer.dart';
import '../theme.dart';

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
      uniqueNumbers.add(random.nextInt(max));
    }
    return uniqueNumbers.toList();
  }

  void _checkGameEnd() {
    if (questionsNumber == 8) {
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors
          .lightBackground,
      appBar: AppyBar(title: 'الرسم'),
      drawer: TheDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'سؤال رقم: ${questionsNumber + 1}',
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'Zain',
                color: isDarkMode ? colors.mainText : colors.secondaryText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      scoreContainer(
                          gameRedScore.toString(), colors.team1, 35, isDarkMode,
                          -5, 5),
                      IconButton(
                        icon: Icon(Icons.add, color: colors.team1, size: 35,),
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
                      scoreContainer(gameBlueScore.toString(), colors.team2, 35,
                          isDarkMode, 5, 5),
                      IconButton(
                        icon: Icon(Icons.add, color: colors.team2, size: 35,),
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
            SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      Draw_data[randomNumbers[questionsNumber]]['name'] as String,
                      style: TextStyle(
                        fontSize: 40,
                        color: isDarkMode ? colors.mainText : colors
                            .secondaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        Draw_data[randomNumbers[questionsNumber]]['photo'] as String,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: changeQuestion,
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2,
                        color: isDarkMode ? colors.mainText : colors
                            .secondaryText),
                    foregroundColor: isDarkMode ? colors.mainText : colors
                        .secondaryText,
                    backgroundColor: isDarkMode ? Colors.transparent : colors
                        .lightbutton,
                  ),
                  child: Text('تغيير الفريق', style: TextStyle(fontSize: 20),),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DrawingPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2,
                          color: isDarkMode ? colors.mainText : colors
                              .secondaryText),
                      foregroundColor: isDarkMode ? colors.mainText : colors
                          .secondaryText,
                      backgroundColor: isDarkMode ? Colors.transparent : colors
                          .lightbutton,
                    ),
                    child: Row(
                      children: [
                        Text('ارسم    ', style: TextStyle(fontSize: 20),),
                        Icon(Icons.draw_rounded),

                      ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

