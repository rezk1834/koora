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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'صباحو تحدي',
          style: TextStyle(fontSize: 40),
        ),
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8,0),
            child: Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Text(
                          red_score.toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                      ),
                      child: Center(
                        child: Text(
                          blue_score.toString(),
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
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
                  ElevatedButton(
                    onPressed: resetScore,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Reset the score',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
