import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import '../about.dart';
import '../theme.dart';

void _navigateToAboutPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AboutPage()),
  );
}

class TheDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: isDarkMode ? colors.darkBackground : colors.lightBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Image(
                        image: AssetImage("assets/main/icon.png"),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.add_call,
                      size: 29,
                    ),
                    title: Text(
                      "الاتصال بنا",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    ),
                    onTap: () => _launchURL('https://www.linkedin.com/in/moustafarezk1834/'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.more,
                      size: 29,
                    ),
                    title: Text(
                      "المزيد من البرامج",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    ),
                    onTap: () => _launchURL(
                        'https://drive.google.com/drive/folders/1-HFaqY-nKXCBXxfAiH0X1iKOgd0LWhBA?usp=sharing'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.feedback_outlined,
                      size: 29,
                    ),
                    title: Text(
                      "اعطي رأيك",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    ),
                    onTap: () => _launchURL(
                        'https://docs.google.com/forms/d/e/1FAIpQLSe0uvpW60tVsfEFRu85CmRH27uRm_r5egASHMz-YgmkX7eQqA/viewform'),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.share,
                      size: 29,
                    ),
                    title: Text(
                      "دعوة الاصدقاء",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    ),
                    onTap: () => _inviteFriends(),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      size: 29,
                    ),
                    title: Text(
                      "عن البرنامج",
                      style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                    ),
                    onTap: () => _navigateToAboutPage(context),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 29,
                ),
                title: Text(
                  "خروج",
                  style: TextStyle(fontSize: 20, color: isDarkMode ? colors.mainText : colors.secondaryText,),
                ),
                onTap: () {
                  _showExitConfirmationDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? colors.darkBackground
              : colors.lightBackground,
          title: Text(
            "تأكيد الخروج",
            style: TextStyle(color: colors.mainText),
          ),
          content: Text(
            "هل انت متأكد من أنك تريد المغادرة؟",
            style: TextStyle(color: colors.mainText),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "لا",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(
                "نعم",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                SystemNavigator.pop(); // Exit the app
              },
            ),
          ],
        );
      },
    );
  }
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'فشل في المشاركة $url';
  }
}

void _inviteFriends() {
  final String inviteLink = 'https://www.yourapp.com/invite';
  Share.share('استخدم هذا اللينك: $inviteLink');
}
