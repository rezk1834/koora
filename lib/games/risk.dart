import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:football/components/appbar.dart';
import '../components/scoreContainer.dart';
import '../database/games database/risk_data.dart';
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
    containerColors = List.generate(4, (index) => List.generate(4, (index) => Colors.blueGrey[600]!));
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
              child: Text('احمر'),
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
              child: Text('ازرق'),
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
              child: Text('لا اجابة'),
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
      appBar: AppyBar(title: 'ريسك'),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: scoreContainer(
                    gameRedScore.toString(),
                    colors.team1,
                    35,
                    isDarkMode,
                    -5,
                    5,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: scoreContainer(
                    gameBlueScore.toString(),
                    colors.team2,
                    35,
                    isDarkMode,
                    5,
                    5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (columnIndex) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.blueGrey[800] : Colors.blueGrey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                          height: 90,
                          child: Center(
                            child: Text(
                              randomRiskData[columnIndex]["title"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? colors.mainText : colors.secondaryText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...[5, 10, 20, 40].asMap().entries.map((entry) {
                        int rowIndex = entry.key;
                        int value = entry.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                          child: GestureDetector(
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "$value",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: isDarkMode ? colors.mainText : colors.secondaryText,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              }),
            ),
          ),

        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Red Team FAB
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpeedDial(
              backgroundColor: Colors.red,
              icon: Icons.add,
              activeIcon: Icons.close,
              spacing: 10,
              spaceBetweenChildren: 8,
              children: [5, 10, 20, 40].map((value) {
                return SpeedDialChild(
                  child: Text('+$value', style: TextStyle(fontSize: 18)),
                  backgroundColor: Colors.redAccent,
                  onTap: () {
                    setState(() {
                      gameRedScore += value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Flexible(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  width: 2,
                  color: isDarkMode ? colors.mainText : colors.secondaryText,
                ),
                foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
              ),
              onPressed: _endRound,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text("انهي الجولة",style: TextStyle(fontSize: 15),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpeedDial(
              backgroundColor: Colors.blue,
              icon: Icons.add,
              activeIcon: Icons.close,
              spacing: 10,
              spaceBetweenChildren: 8,
              children: [5, 10, 20, 40].map((value) {
                return SpeedDialChild(
                  child: Text('+$value', style: TextStyle(fontSize: 18)),
                  backgroundColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      gameBlueScore += value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
