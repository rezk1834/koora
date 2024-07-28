  import 'package:flutter/material.dart';
  import 'package:football/database/database.dart';
  import 'package:football/saba7o/password.dart';
  import 'package:football/saba7o/rondo.dart';
  import 'package:football/saba7o/whisper.dart';
  import '../saba7o/acting.dart';
  import '../saba7o/draw.dart';
import '../saba7o/ehdeb.dart';
  import '../saba7o/ekdeb.dart';
  import '../saba7o/guess_the_player.dart';
  import '../saba7o/labes_sa7bak.dart';
  import '../saba7o/mazad.dart';
  import '../saba7o/men_fe_elsora.dart';
  import '../saba7o/risk.dart';
  import '../saba7o/bank.dart';
  import '../saba7o/seconds.dart';

  class saba7o_square extends StatefulWidget {
    final String child;
    final String pic;
    final int red_score;
    final int blue_score;
    final String path;
    final Function(int, int) updateScores;

    saba7o_square({
      super.key,
      required this.child,
      required this.pic,
      required this.red_score,
      required this.blue_score,
      required this.path,
      required this.updateScores,
    });

    @override
    State<saba7o_square> createState() => _saba7o_squareState();
  }

  class _saba7o_squareState extends State<saba7o_square> {
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
              case '/labes_sa7bak':
                return labesSa7bak(redScore: widget.red_score, blueScore: widget.blue_score);
              case '/seconds':
                return Seconds(redScore: widget.red_score, blueScore: widget.blue_score);
              case '/draw':
                return Draw(redScore: widget.red_score, blueScore: widget.blue_score);
              case '/mazad':
                return Mazad(redScore: widget.red_score, blueScore: widget.blue_score);


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

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            await _navigateToPage(context);
          },
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: AssetImage(widget.pic),
                fit: BoxFit.fill,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Text(
                    widget.child,
                    style: TextStyle(fontSize: 45, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
