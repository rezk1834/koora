import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/components/timer.dart';
import '../database/database.dart';
import '../database/games database/bank_data.dart';
import '../components/drawer.dart';
import '../theme.dart';

class BankPage extends StatefulWidget {
  final int redScore;
  final int blueScore;
  final Color color;
  final int bankingScore;

  BankPage({
    required this.redScore,
    required this.blueScore,
    required this.color,
    required this.bankingScore,
  });

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  late int score;
  late int bank;
  int questionsNumber = 0;
  Random random = Random();
  late Key timerKey;
  late List<int> randomNumbers;

  @override
  void initState() {
    super.initState();
    score = widget.bankingScore;
    bank = 0;
    score =0;
    timerKey = UniqueKey();
    randomNumbers = generateUniqueRandomNumbers(13, Bank_data.length);
  }

  List<int> generateUniqueRandomNumbers(int count, int max) {
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < count) {
      int number = random.nextInt(max);
      uniqueNumbers.add(number);
    }

    return uniqueNumbers.toList();
  }

  void correct() {
    setState(() {
      if (score == 0) score = 1;
      else score *= 2;
      questionsNumber++;
    });
  }

  void wrong() {
    setState(() {
      score = 0;
      questionsNumber++;
    });
  }

  void banking() {
    setState(() {
      bank += score;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
        automaticallyImplyLeading: false,
      ),
      drawer: TheDrawer(),
      body: questionsNumber<12? Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'السؤال رقم: ${questionsNumber + 1}',
                  style: TextStyle(fontSize: 27, fontFamily: 'Zain', color: isDarkMode ? colors.mainText : colors.secondaryText),
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
                    Bank_data[randomNumbers[questionsNumber]]['question'] as String,
                    style: TextStyle(fontSize: 27, color: isDarkMode ? colors.mainText : colors.secondaryText),
                  ),
                ),
              ),
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
                    Bank_data[randomNumbers[questionsNumber]]['answer'].toString(),
                    style: TextStyle(fontSize: 40, color: isDarkMode ? colors.mainText : colors.secondaryText),

                  ),
                ),
              ),
              CountdownTimer(key: timerKey, seconds: 120),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: correct,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2,color: Colors.green,),
                        foregroundColor: Colors.green,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                      ),
                      child: Text('اجابة صحيحة', style: TextStyle(fontSize: 20)),
                    ),
                    ElevatedButton(
                      onPressed: wrong,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2,color: Colors.red,),
                        foregroundColor: Colors.red,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                      ),
                      child: Text('اجابة خاطئة', style: TextStyle(fontSize: 20)),
                    ),
                    ElevatedButton(
                      onPressed: banking,
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                        foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                        backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                      ),
                      child: Text('بنك', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("النقاط الحالية:  $score", style: TextStyle(fontSize: 25,color: isDarkMode ? colors.mainText : colors.secondaryText,),),
                Text("نقاط البنك:  $bank", style: TextStyle(fontSize: 25,color: isDarkMode ? colors.mainText : colors.secondaryText,),),
              ],
            ),
          ),
        ],
      ) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("نقاط البنك في هذه الجولة:  $bank", style: TextStyle(
                fontSize: 35,
                color: isDarkMode ? colors.mainText : colors.secondaryText,
                fontWeight: FontWeight.bold),),
            Text(" النقاط الحالية:  $score", style: TextStyle(
                fontSize: 35,
                color: isDarkMode ? colors.mainText : colors.secondaryText,
                fontWeight: FontWeight.bold),),
            Container(
              color: Colors.transparent,
              width: 200,
              child: ElevatedButton(
                onPressed: banking,
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text('بنك', style: TextStyle(fontSize: 20)),
              ),
            ),
            Container(
              color: Colors.transparent,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, bank);
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                ),
                child: Text('العودة', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
