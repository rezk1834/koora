import 'dart:math';
import 'package:flutter/material.dart';
import 'package:football/components/appbar.dart';
import 'package:football/components/timer.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/games database/theMazad_data.dart';
import '../components/drawer.dart';
import '../theme.dart';
class Mazad extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Mazad({required this.redScore, required this.blueScore});

  @override
  State<Mazad> createState() => _MazadState();
}

class _MazadState extends State<Mazad> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  late Key timerKey;
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    timerKey = UniqueKey();
    randomNumbers = generateUniqueRandomNumbers(6, Mazad_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }



  void _checkGameEnd() {
    if (questionsNumber == 6) {
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

  void nextQuestion() {
    setState(() {
      questionsNumber++;
      _checkGameEnd();
      timerKey = UniqueKey();
    });
  }

  void changeQuestion() {
    setState(() {
      _checkGameEnd();
      randomNumbers[questionsNumber] = random.nextInt(Mazad_data.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppyBar(title: 'المزاد',),
      drawer: TheDrawer(),
      body: Padding(
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
                      scoreContainer(gameRedScore.toString(), colors.team1, 35,isDarkMode,-5,5),
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
                      scoreContainer(gameBlueScore.toString(), colors.team2, 35,isDarkMode,5,5),
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
                  Mazad_data[randomNumbers[questionsNumber]]['question'] as String,
                  style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),
                ),
              ),
            ),
            CountdownTimer(key: timerKey, seconds: 30),
            Positioned(
              left: 10,
              right: 10,
              bottom: 30,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: changeQuestion,
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                    backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                  ),
                  child: Text('تغيير السؤال' ,style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
