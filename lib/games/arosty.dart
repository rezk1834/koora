import 'dart:math';
import 'package:flutter/material.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/saba7o database/arosty_data.dart';
import '../theme.dart';

class Arosty extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Arosty({required this.redScore, required this.blueScore});

  @override
  State<Arosty> createState() => _ArostyState();
}

class _ArostyState extends State<Arosty> {
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
    randomNumbers = generateUniqueRandomNumbers(8, Arosty_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }



  void checkGameEnd() {
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

  void draw() {
    setState(() {
      questionsNumber++;
      checkGameEnd();
    });
  }

  void changeQuestion() {
    setState(() {
      checkGameEnd();
      randomNumbers[questionsNumber] = random.nextInt(Arosty_data.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<int> randomNumbers = generateUniqueRandomNumbers(8, Arosty_data.length);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'روندو',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Teko',
            color: isDarkMode ? colors.mainText : colors.secondaryText,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
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
                        scoreContainer(gameRedScore.toString(), colors.team1, 35,isDarkMode),
                        IconButton(
                          icon: Icon(Icons.add, color: colors.team1,size: 35,),
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
                    Column(
                      children: [
                        scoreContainer(gameBlueScore.toString(), colors.team2, 35,isDarkMode),
                        IconButton(
                          icon: Icon(Icons.add, color: colors.team2,size: 35,),
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
                    Arosty_data[randomNumbers[questionsNumber]]['name'] as String,
                    style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),
                  ),
                ),
              ),

              SizedBox(height: 5,),
              ElevatedButton(
                onPressed: changeQuestion,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text('Change Name'),
              ),

            ],
          )
      ),
    );
  }
}
