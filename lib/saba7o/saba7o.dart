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

  void resetScore() {
    setState(() {
      red_score = 0;
      blue_score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تحدي معلومات كرة القدم',
          style: TextStyle(fontSize: 25,color: Color(0xffd8dbde),),

        ),
        backgroundColor: Color(0xff181e22),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Colors.pink,
      body: Container(
        color: Colors.transparent,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
          ),
          itemCount: game_categories.length,
          itemBuilder: (context, index) {
            return Square(
              child: game_categories[index]['title']!,
              pic: game_categories[index]['image']!,
              red_score: red_score,
              blue_score: blue_score,
              path: game_categories[index]['path']!,
              rules: game_categories[index]['rules']!,
              updateScores: updateScores,
            );
          },
        ),
      ),
    );
  }
}
