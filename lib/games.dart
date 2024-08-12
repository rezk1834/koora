import 'package:flutter/material.dart';
import 'package:football/components/drawer.dart';
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0,
        bottomOpacity: 5,
      ),
      drawer: TheDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: scoreContainer(red_score.toString(), colors.team1, 35,isDarkMode,-5,5)),
                SizedBox(width: 15,),
                Expanded(child: scoreContainer(blue_score.toString(), colors.team2, 35,isDarkMode,5,5)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: game_categories.length,
                      itemBuilder: (context, index) {
                        return Square(
                          child: game_categories[index]['title']!,
                          pic: game_categories[index]['image']!,
                          gamePlay: game_categories[index]['type']!,
                          red_score: red_score,
                          blue_score: blue_score,
                          rounds: game_categories[index]['rounds']!,
                          path: game_categories[index]['path']!,
                          updateScores: updateScores,
                          rules: game_categories[index]['rules']!,
                          mood: isDarkMode,
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetScore,
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                      foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                      backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
                    ),
                    child: Text(
                      'تصفير النقاط',
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
