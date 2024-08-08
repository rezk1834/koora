import 'package:flutter/material.dart';
import 'package:football/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'about.dart';

// url_launcher: ^6.3.0
// share: ^2.0.4

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
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Image(
                  image: AssetImage("assets/main/icon.png"),
                ),
              ),
            ),

            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.add_call,
                    size: 29,
                   ),
                  title: Text(
                    "الاتصال بنا",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () =>
                      _launchURL('https://www.linkedin.com/in/moustafarezk1834/'),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.more,
                    size: 29,
                  ),
                  title: Text(
                    "المزيد من البرامج",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () =>
                      _launchURL(
                          'https://drive.google.com/drive/folders/1-HFaqY-nKXCBXxfAiH0X1iKOgd0LWhBA?usp=sharing'),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.feedback_outlined,
                    size: 29,
                  ),
                  title: Text(
                    "اعطي رأيك",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () =>
                      _launchURL(
                          'https://docs.google.com/forms/d/e/1FAIpQLSe0uvpW60tVsfEFRu85CmRH27uRm_r5egASHMz-YgmkX7eQqA/viewform'),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.share,
                    size: 29,
                  ),
                  title: Text(
                    "دعوة الاصدقاء",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () => _inviteFriends(),
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    size: 29,
                  ),
                  title: Text(
                    "عن البرنامج",
                    style: TextStyle( fontSize: 20),
                  ),
                  onTap: () => _navigateToAboutPage(context),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
  void _inviteFriends() {
    final String inviteLink = 'https://www.yourapp.com/invite';
    Share.share('Join me on this amazing app! Use this link: $inviteLink');
  }

