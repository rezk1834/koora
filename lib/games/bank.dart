import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football/components/appbar.dart';
import '../components/scoreContainer.dart';
import '../components/drawer.dart';
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

  void _endround({required bool isDarkMode}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? colors.darkBackground : colors.lightBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'انهي اللعبة',
            style: TextStyle(
              color: isDarkMode ? colors.mainText : colors.secondaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'اختار الفريق الفائز:',
            style: TextStyle(
              color: isDarkMode ? colors.mainText : colors.secondaryText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  redScore++;
                });
                Navigator.pop(context);
                Navigator.pop(context, [redScore, blueScore]);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'الفريق الأحمر',
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
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'الفريق الأزرق',
                style: TextStyle(color: colors.team2),
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
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'تعادل',
                style: TextStyle(
                  color: isDarkMode ? colors.mainText : colors.secondaryText,
                ),
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

          if (buttonClicked.every((clicked) => clicked)) {
            final theme = Theme.of(context);
            final isDarkMode = theme.brightness == Brightness.dark;
            _endround(isDarkMode: isDarkMode);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppyBar(title: 'بنك'),
      drawer: TheDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [colors.darkBackground.withOpacity(0.9), colors.darkBackground]
                : [colors.lightBackground, colors.lightBackground.withOpacity(0.9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      scoreContainer(redBankScore.toString(), colors.team1, 35, isDarkMode, -5, 5),
                      scoreContainer(blueBankScore.toString(), colors.team2, 35, isDarkMode, 5, 5),
                    ],
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 6; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
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
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                          backgroundColor: buttonClicked[i]
                              ? Colors.grey
                              : (i % 2 == 0)
                              ? colors.team1
                              : colors.team2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: !isDarkMode ? colors.mainText : colors.secondaryText,
                          elevation: 5,
                        ),
                        child: Text(
                          'الجولة ${i + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 2, color: isDarkMode ? colors.mainText : colors.secondaryText),
                  foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                  backgroundColor: isDarkMode ? Colors.transparent : colors.lightbutton,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black54,
                  elevation: 5,
                ),
                onPressed: () => _endround(isDarkMode: isDarkMode),
                child: Text(
                  "انهي اللعبة",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
