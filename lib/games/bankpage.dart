import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/components/timer.dart';
import '../database/database.dart';
import '../database/saba7o database/bank_data.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('بنك', style: TextStyle(fontSize: 30,fontFamily: 'Teko'),),
        centerTitle: true,
      ),
      body: questionsNumber<12? Stack(
        children: [

          Column(
            children: [
              SizedBox(height: 5,),
              CountdownTimer(key: timerKey, seconds: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Text(
                  'Question No.${questionsNumber + 1}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    Bank_data[randomNumbers[questionsNumber]]['question'] as String,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    Bank_data[randomNumbers[questionsNumber]]['answer'].toString(),
                    style: TextStyle(fontSize: 40, color: Colors.green),
                  ),
                ),
              ),
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
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      child: Text('Correct', style: TextStyle(fontSize: 20)),
                    ),
                    ElevatedButton(
                      onPressed: wrong,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: Text('Wrong', style: TextStyle(fontSize: 20)),
                    ),
                    ElevatedButton(
                      onPressed: banking,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: Text('Bank', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Current points: $score", style: TextStyle(fontSize: 25)),
                Text("Bank points: $bank", style: TextStyle(fontSize: 25)),
              ],
            ),
          ),
        ],
      ) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Current points: $score", style: TextStyle(fontSize: 25)),
            Text("Bank points: $bank", style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: banking,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueGrey,
              ),
              child: Text('Bank', style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, bank);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: widget.color,
              ),
              child: Text('Return', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),

    );
  }
}
