import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/saba7o database/guess_the_player_data.dart';
import '../theme.dart';

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
      questionsNumber++;
      clueNumber = 0;
      showName = false;
      _checkGameEnd();
    });
  }



  void _checkGameEnd() {
    if (questionsNumber == 3) {
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'من اللاعب',
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
        child: Column(
          children: <Widget>[
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
                            _checkGameEnd();
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Question No.${questionsNumber + 1}',
                    style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: isDarkMode ? colors.mainText : colors.secondaryText),
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
                            _checkGameEnd();
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
                  color: Colors.white.withOpacity(0.4),
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
                              style: TextStyle(
                                  fontSize: 20,
                                  color: isDarkMode ? colors.mainText : colors.secondaryText,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                    ),
                    if (showName) // Show name if flag is true
                      Text(
                        currentPlayerData['name']?.toString() ?? 'Name not available',
                        style: TextStyle(
                            fontSize: 30,
                            color: isDarkMode ? colors.mainText : colors.secondaryText,
                            fontWeight: FontWeight.bold),
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
                        side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                        foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
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
                        side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                        foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
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
                        side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                        foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                      ),
                      child: Text('No Answer'),
                    ),
                    ElevatedButton(
                      onPressed: changeQuestion,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                        foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
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
