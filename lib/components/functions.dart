import 'package:flutter/material.dart';
import 'package:football/theme.dart';

void showWinnerDialog(String winningTeam,BuildContext context,int redScore,int blueScore) {
  String teamW;
  if (winningTeam=='Red Team') teamW ='الفريق الاحمر';
  else teamW = 'الفريق الازرق';
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          ModalBarrier(
            color: Colors.black.withOpacity(0.5),
            dismissible: false,
          ),
          Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              backgroundColor: winningTeam == 'Draw'
                  ? Colors.grey[800]
                  : (winningTeam == 'Blue Team' ? colors.team2 : colors.team1),
              title: Text(
                '           النتيجة',

                style: TextStyle(
                  color: colors.mainText,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    winningTeam == 'Draw'
                        ? Icons.gavel
                        : (winningTeam == 'Blue Team' ? Icons.star : Icons.emoji_events),
                    size: 60,
                    color: colors.mainText,
                  ),
                  SizedBox(height: 20),
                  Text(
                    winningTeam == 'Draw' ? 'تعادل!' : ' الفائز هو $teamW',
                    style: TextStyle(color: colors.mainText, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the alert dialog
                    Navigator.pop(context, [redScore, blueScore]); // Navigate back
                  },
                  child: Text(
                    'العودة',
                    style: TextStyle(color: colors.mainText, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}


