import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/components/appbar.dart';

import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/games database/Career_data.dart';
import '../components/drawer.dart';
import '../theme.dart';

class Career extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Career({required this.redScore, required this.blueScore});

  @override
  State<Career> createState() => _CareerState();
}

class _CareerState extends State<Career> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  int questionsNumber = 0;
  Random random = Random();
  ValueNotifier<bool> showAnswerNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> showNameNotifier = ValueNotifier<bool>(false);
  late List<int> randomNumbers;
  late List<int> currentTeamIndices;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomNumbers = generateUniqueRandomNumbers(5, Career_data.length);
    currentTeamIndices = List<int>.filled(Career_data.length, 0);
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
      randomNumbers[questionsNumber] = random.nextInt(Career_data.length);
    });
  }

  void toggleAnswer() {
    showNameNotifier.value = !showNameNotifier.value;
  }

  void showNextTeam() {
    setState(() {
      int currentQuestion = randomNumbers[questionsNumber];
      if (currentTeamIndices[currentQuestion] <
          (Career_data[currentQuestion]['CareerPath']?.split(' - ').length ?? 0) - 1) {
        currentTeamIndices[currentQuestion]++;
      }
    });
  }



  void _checkGameEnd() {
    showNameNotifier.value = false;
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

  return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppyBar(title: 'مسيرة اللاعب'),
    drawer: TheDrawer(),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Center(
                child: Text(
                  'سؤال رقم: ${questionsNumber + 1}',
                  style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: isDarkMode ? colors.mainText : colors.secondaryText),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[

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
                ValueListenableBuilder<bool>(
                  valueListenable: showAnswerNotifier,
                  builder: (context, showAnswer, child) {
                    int currentQuestion = randomNumbers[questionsNumber];
                    List<String> careerPath = Career_data[currentQuestion]['CareerPath']?.split(' - ') ?? [];
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          for (int i = 0; i <= currentTeamIndices[currentQuestion]; i++)
                            Text(
                              careerPath.isNotEmpty ? careerPath[i] : 'No career path available',
                              style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),
                            ),
                          if (showAnswer) ...[
                            Text(
                              Career_data[currentQuestion]['answer']?.toString() ?? '',
                              style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child:  ValueListenableBuilder<bool>(
                    valueListenable: showNameNotifier,
                    builder: (context, showName, child) {
                      return showName
                          ? Text(
                        Career_data[randomNumbers[questionsNumber]]
                        ['name']
                            .toString(),
                        style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),

                      )
                          : Text("");
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 30,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: showNextTeam,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                        ),
                        child: Text('الفريق التالي',style: TextStyle(fontSize: 20),),
                      ),
                      ElevatedButton(
                        onPressed: toggleAnswer,
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                          foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                          backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                        ),
                        child: ValueListenableBuilder<bool>(
                          valueListenable: showNameNotifier,
                          builder: (context, showName, child) {
                            return Text(showName ? 'اخفاء الاسم' : 'اظهار الاسم' ,style: TextStyle(fontSize: 20),);
                          },
                        ),
                      ),
                    ],
                  ),
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
                        child: Text('تغيير اللاعب',style: TextStyle(fontSize: 20),),
                      ),

                    ],
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
