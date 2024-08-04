import 'dart:math';
import 'package:flutter/material.dart';

import '../components/scoreContainer.dart';
import '../database/database.dart';
import '../database/saba7o database/risk_data.dart';

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
          content: Text(answer+'\n'+choices),
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
  void _endround() {
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('ريسك', style: TextStyle(fontSize: 30,fontFamily: 'Teko'),),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 20,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                scoreContainer(gameRedScore.toString(), Colors.red,14),
                scoreContainer(gameBlueScore.toString(), Colors.blue,14),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [5, 10, 20, 40].map((value) {
                return ElevatedButton(
                  onPressed: () =>
                      setState(() {
                        gameRedScore += value;
                      }),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: Text("+$value"),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [5, 10, 20, 40].map((value) {
                return ElevatedButton(
                  onPressed: () =>
                      setState(() {
                        gameBlueScore += value;
                      }),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("+$value"),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (columnIndex) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[400],
                          borderRadius: BorderRadius.circular(12)
                        ),
                        width: 60,
                        height: 75,
                        child: Center(child: Text(
                          randomRiskData[columnIndex]["title"]!,
                          style: TextStyle(
                              fontSize: 16, color: Colors.white),)),
                      ),
                    ),
                    ...[5, 10, 20, 40]
                        .asMap()
                        .entries
                        .map((entry) {
                      int rowIndex = entry.key;
                      int value = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
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
                                borderRadius: BorderRadius.circular(12)
                            ),

                            width: 60,
                            height: 50,
                            child: Center(child: Text("$value")),
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xfffdca40),
              ),
              onPressed: _endround,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text("End Round"),
              ))
        ],
      ),
    );
  }
}