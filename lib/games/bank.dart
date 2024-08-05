import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/scoreContainer.dart';
import '../theme.dart';
import 'bankpage.dart';

class Bank extends StatefulWidget {
  final int redScore;
  final int blueScore;

  Bank({required this.redScore, required this.blueScore});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  late int redScore;
  late int blueScore;
  late int redBankScore;
  late int blueBankScore;
  List<bool> buttonClicked = List<bool>.filled(6, false);

  @override
  void initState() {
    super.initState();
    redBankScore = 0;
    blueBankScore = 0;
    redScore = widget.redScore;
    blueScore = widget.blueScore;
  }

  void _endround() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End Game'),
          content: Text('Select the winning team:'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  redScore++;
                });
                Navigator.pop(context);
                Navigator.pop(context, [redScore, blueScore]);
              },
              child: Text(
                'Team Red Wins',
                style: TextStyle(color: colors.team1),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  blueScore++;
                });
                Navigator.pop(context);
                Navigator.pop(context, [redScore, blueScore]);
              },
              child: Text(
                'Team Blue Wins',
                style: TextStyle(color: colors.team2),
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToBankPage(Color color, int bankingScore, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BankPage(
          redScore: redBankScore,
          blueScore: blueBankScore,
          color: color,
          bankingScore: bankingScore,
        ),
      ),
    ).then((result) {
      if (result != null && result is int) {
        setState(() {
          if (color == colors.team1) {
            redBankScore += result;
          } else if (color == colors.team2) {
            blueBankScore += result;
          }
          buttonClicked[index] = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
      appBar: AppBar(
        title: Text('بنك', style: TextStyle(fontSize: 30,fontFamily: 'Teko',color: isDarkMode ? colors.mainText : colors.secondaryText,
        ),),
        centerTitle: true,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      body: Stack(
        children: [
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  scoreContainer(redBankScore.toString(), colors.team1, 35,isDarkMode),
                  scoreContainer(blueBankScore.toString(), colors.team2, 35,isDarkMode),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                for (int i = 0; i < 6; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: buttonClicked[i]
                          ? null
                          : () {
                        Color color = (i % 2 == 0) ? colors.team1 : colors.team2;
                        int bankingScore = (color == colors.team1)
                            ? redBankScore
                            : blueBankScore;
                        navigateToBankPage(color, bankingScore, i);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (i % 2 == 0) ? colors.team1 : colors.team2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                        child: Text( 'Round ${i+1}' ,style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
              ),
              onPressed: _endround,
              child: Text("End Round"),
            ),
          ),
        ],
      ),
    );
  }
}
