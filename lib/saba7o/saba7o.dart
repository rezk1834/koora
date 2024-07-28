import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/square.dart';
import '../components/scoreContainer.dart';
import '../database/database.dart';

class saba7o extends StatefulWidget {
  const saba7o({super.key});

  @override
  State<saba7o> createState() => _saba7oState();
}

class _saba7oState extends State<saba7o> {
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
        title: Text('صباحو تحدي', style: TextStyle(fontSize: 40),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,top: 20,right: 8,bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('  Score ', style: TextStyle(fontSize: 35),),
                  scoreContainer(red_score.toString(), Colors.red,30),
                  scoreContainer(blue_score.toString(), Colors.blue,30),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: saba7o_categories.length,
                itemBuilder: (context, index) {
                  return Square(
                    child: saba7o_categories[index]['title']!,
                    pic: saba7o_categories[index]['image']!,
                    red_score: red_score,
                    blue_score: blue_score,
                    path: saba7o_categories[index]['path']!,
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
