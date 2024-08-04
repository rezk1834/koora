import 'package:flutter/material.dart';
import 'components/square.dart';
import 'components/scoreContainer.dart';
import 'database/database.dart';
import 'package:football/theme.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text(
          'تحدي معلومات كرة القدم',
          style: TextStyle(
            fontSize: 25,
            color: isDarkMode ? colors.mainText : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                      itemCount: game_categories.length,
                      itemBuilder: (context, index) {
                        return Square(
                          child: game_categories[index]['title']!,
                          pic: game_categories[index]['image']!,
                          red_score: red_score,
                          blue_score: blue_score,
                          path: game_categories[index]['path']!,
                          updateScores: updateScores,
                          rules: game_categories[index]['rules']!,
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
