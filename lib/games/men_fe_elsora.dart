import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/functions.dart';
import '../components/scoreContainer.dart';
import '../database/database.dart';
import '../theme.dart';
import '../database/saba7o database/men_fel_sora_data.dart';

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

  void draw() {
    setState(() {
      questionsNumber++;
      showNotifier.value = false;
      _checkGameEnd();
    });
  }

  void toggleAnswer() {
    showNotifier.value = !showNotifier.value;
  }



  void _checkGameEnd() {
    showNotifier.value = false;
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
      appBar: AppBar(
        title: Text(
          'مين في الصورة',
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
                  Text(
                    'صورة رقم: ${questionsNumber + 1}',
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
                            _checkGameEnd();
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
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      Text(
                        Men_fe_elsora_data[randomNumbers[questionsNumber]]['title'] as String,
                        style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText),
                      ),
                      SizedBox(height: 20),
                      InteractiveViewer(
                        maxScale: 12,
                        child: Image.network(
                          Men_fe_elsora_data[randomNumbers[questionsNumber]]['image'] as String,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Text('فشل في تحميل الصورة برجاء الاتصال بالنت واعادة المحاولة');
                          },
                        ),
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
                                  style: TextStyle(fontSize: 15, color: isDarkMode ? colors.mainText : colors.secondaryText),
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
                                    child: Text('تعادل',style: TextStyle(fontSize: 20),),
                                  ),
                                  ElevatedButton(
                                    onPressed: toggleAnswer,
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                                      foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                                      backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                                    ),
                                    child: Text(show ? 'اخفاء الاسماء' : 'إظهار الاسماء',style: TextStyle(fontSize: 20),),
                                  ),
                                ],
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
