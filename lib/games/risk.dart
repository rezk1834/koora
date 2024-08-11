import 'dart:math';
import 'package:flutter/material.dart';

import '../components/scoreContainer.dart';
import '../database/database.dart';
import '../database/games database/risk_data.dart';
import '../components/drawer.dart';
import '../theme.dart';

class Risk extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Risk({required this.redScore, required this.blueScore});

  @override
  State<Risk> createState() => _RiskState();
}

class _RiskState extends State<Risk> {
  late int redScore;
  late int blueScore;
  int gameBlueScore = 0;
  int gameRedScore = 0;
  Random random = Random();
  late List<Map<String, String>> randomRiskData;
  late List<List<Color>> containerColors;

  @override
  void initState() {
    super.initState();
    redScore = widget.redScore;
    blueScore = widget.blueScore;
    randomRiskData = _getRandomRiskData(4);
    containerColors = List.generate(4, (index) => List.generate(4, (index) => Colors.green[600]!));
  }

  List<Map<String, String>> _getRandomRiskData(int count) {
    List<Map<String, String>> shuffledData = List.from(Risk_data);
    shuffledData.shuffle(random);
    return shuffledData.take(count).toList();
  }

  void _showDialog(int columnIndex, int rowIndex, String question, String answer, String choices) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(question),
          content: Text('$answer\n$choices'),
          actions: [
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  containerColors[columnIndex][rowIndex] = Colors.red;
                });
                Navigator.of(context).pop();
              },
              child: Text('Red'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                setState(() {
                  containerColors[columnIndex][rowIndex] = Colors.blue;
                });
                Navigator.of(context).pop();
              },
              child: Text('Blue'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              onPressed: () {
                setState(() {
                  containerColors[columnIndex][rowIndex] = Colors.grey;
                });
                Navigator.of(context).pop();
              },
              child: Text('Grey'),
            ),
          ],
        );
      },
    );
  }

  void _endRound() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End Game'),
          content: Text('Select the winning team:'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  redScore++;
                });
                Navigator.pop(context, [redScore, blueScore]);
                Navigator.pop(context, [redScore, blueScore]);
              },
              child: Text(
                'Team Red Wins',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  blueScore++;
                });
                Navigator.pop(context, [redScore, blueScore]);
                Navigator.pop(context, [redScore, blueScore]);
              },
              child: Text(
                'Team Blue Wins',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'ريسك',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Teko',
            color: isDarkMode ? colors.mainText : colors.secondaryText,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      drawer: TheDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  scoreContainer(gameRedScore.toString(), colors.team1, 40, isDarkMode),
                  scoreContainer(gameBlueScore.toString(), colors.team2, 40, isDarkMode),
                ],
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, columnIndex) {
                  return Column(
                    children: [
                      // Title container
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.blueGrey[800] : Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity,
                        height: 70,
                        child: Center(
                          child: Text(
                            randomRiskData[columnIndex]["title"]!,
                            style: TextStyle(fontSize: 18, color: isDarkMode ? colors.mainText : colors.secondaryText),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Sub-options or point values grid
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4, // Number of point values
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, // 1 column
                            mainAxisSpacing: 10,
                            childAspectRatio: 3, // Adjust based on desired aspect ratio
                          ),
                          itemBuilder: (context, rowIndex) {
                            int value = [5, 10, 20, 40][rowIndex];
                            return GestureDetector(
                              onTap: () {
                                _showDialog(
                                  columnIndex,
                                  rowIndex,
                                  randomRiskData[columnIndex]["${value}q"]!,
                                  randomRiskData[columnIndex]["${value}a"]!,
                                  randomRiskData[columnIndex]["${value}c"]!,
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: containerColors[columnIndex][rowIndex],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: double.infinity,
                                height: double.infinity,
                                child: Center(
                                  child: Text(
                                    "$value",
                                    style: TextStyle(fontSize: 24, color: isDarkMode ? colors.mainText : colors.secondaryText),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [5, 10, 20, 40].map((value) {
                  return ElevatedButton(
                    onPressed: () => setState(() {
                      gameRedScore += value;
                    }),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "+$value",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [5, 10, 20, 40].map((value) {
                  return ElevatedButton(
                    onPressed: () => setState(() {
                      gameBlueScore += value;
                    }),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "+$value",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                ),
                onPressed: _endRound,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text("End Round", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
