import 'package:flutter/material.dart';
import 'package:football/games/password.dart';
import 'package:football/games/rondo.dart';
import 'package:football/games/whisper.dart';
import 'package:football/theme.dart';
import '../games/btola.dart';
import '../games/Career.dart';
import '../games/TheBell.dart';
import '../games/TheImpossible.dart';
import '../games/TheMazad.dart';
import '../games/WDYK.dart';
import '../games/acting.dart';
import '../games/draw.dart';
import '../games/ehdeb.dart';
import '../games/ekdeb.dart';
import '../games/guess_the_player.dart';
import '../games/kobry.dart';
import '../games/arosty.dart';
import '../games/labes.dart';
import '../games/men_fe_elsora.dart';
import '../games/risk.dart';
import '../games/bank.dart';
import '../games/seconds.dart';
import '../theme.dart';

class Square extends StatefulWidget {
  final String child;
  final String pic;
  final String gamePlay;
  final int red_score;
  final int blue_score;
  final String rounds;
  final String path;
  final String rules;
  final bool mood;
  final Function(int, int) updateScores;

  Square({
    super.key,
    required this.child,
    required this.pic,
    required this.gamePlay,
    required this.red_score,
    required this.blue_score,
    required this.rounds,
    required this.path,
    required this.rules,
    required this.updateScores,
    required this.mood,
  });

  @override
  State<Square> createState() => _SquareState();
}

class _SquareState extends State<Square> {
  Future<void> _navigateToPage(BuildContext context) async {
    final newScores = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (widget.path) {
            case '/ehbed':
              return Ehbed(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/ekdeb':
              return Ekdeb(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/rondo':
              return Rondo(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/acting':
              return Acting(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/men_fe_elsora':
              return Men_fe_elsora(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/whisper':
              return Whisper(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/password':
              return Password(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/guess_the_player':
              return GuessThePlayer(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/risk':
              return Risk(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/bank':
              return Bank(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/arosty':
              return Arosty(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/seconds':
              return Seconds(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/draw':
              return Draw(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/Labes':
              return Labes(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/wdyk':
              return WDYK(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/mazad':
              return Mazad(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/bell':
              return TheBell(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/impossible':
              return TheImpossible(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/career':
              return Career(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/kobry':
              return Kobry(redScore: widget.red_score, blueScore: widget.blue_score);
            case '/btola':
              return Btola(redScore: widget.red_score, blueScore: widget.blue_score);
            default:
              return Container(); // Placeholder for invalid path
          }
        },
      ),
    );

    if (newScores != null && newScores is List<int> && newScores.length == 2) {
      widget.updateScores(newScores[0], newScores[1]);
    }
  }

  void showRules() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: colors.darkBackground,
            title:
            Text(
              widget.child.toString(),
              style: TextStyle(
                color: colors.mainText,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Text(
                widget.rules,
                style: TextStyle(
                  color: colors.mainText,
                  fontSize: 20,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'اغلاق',
                  style: TextStyle(
                    color: colors.mainText,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.mood ? colors.darkBackground : colors.lightBackground,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                onTap: () async {
                  await _navigateToPage(context);
                },
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(widget.pic),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.6),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                widget.child,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.9),
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                textDirection: TextDirection.rtl, // Right-to-left text direction
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                " ${widget.rounds} جولات  | ${widget.gamePlay}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.0,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.9),
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                textDirection: TextDirection.rtl, // Right-to-left text direction
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.info, color: Colors.white, size: 20),
              onPressed: showRules,
            ),
          ),
        ],
      ),
    );
  }
}
