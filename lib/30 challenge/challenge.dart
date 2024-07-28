
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/square.dart';
import '../components/scoreContainer.dart';
import '../database/database.dart';

class challenge extends StatefulWidget {
  const challenge({super.key});

  @override
  State<challenge> createState() => _challengeState();
}

class _challengeState extends State<challenge> {
  int red_score = 0;
  int blue_score = 0;

  void updateScores(int newRedScore, int newBlueScore) {
    setState(() {
      red_score = newRedScore;
      blue_score = newBlueScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحدي الثلاثين', style: TextStyle(fontSize: 40),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,top: 20,right: 8,bottom: 8),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: challenge_categories.length,
                itemBuilder: (context, index) {
                  return Square(
                    child: challenge_categories[index]['title']!,
                    pic: challenge_categories[index]['image']!,
                    red_score: red_score,
                    blue_score: blue_score,
                    path: challenge_categories[index]['path']!,
                    updateScores: updateScores,

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

