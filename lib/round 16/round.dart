import 'package:flutter/material.dart';
import 'package:football/round%2016/roundScreen.dart';

import '../drawer.dart';
import '../theme.dart';

class NameEntryScreen extends StatefulWidget {
  @override
  _NameEntryScreenState createState() => _NameEntryScreenState();
}

class _NameEntryScreenState extends State<NameEntryScreen> {
  final _names = List<String>.generate(16, (_) => "");
  String title='';
  final _controllers = List<TextEditingController>.generate(16, (_) => TextEditingController());
  final controller =TextEditingController();

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('دور ال16',style: TextStyle(fontSize: 30, fontFamily: 'Teko', color: isDarkMode ? colors.mainText : colors.secondaryText),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: isDarkMode ? colors.darkAppbarBackground : colors.lightAppbarBackground,
      ),
      drawer: TheDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'عنوان المناقشة',
            ),
            onChanged: (value) {
              title = value;
            },
          ),
        ),
            Expanded(
              child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        labelText: 'اسم رقم: ${index + 1}',
                      ),
                      onChanged: (value) {
                        _names[index] = value;
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2,color: isDarkMode ? colors.mainText : colors.secondaryText,),
                foregroundColor: isDarkMode ? colors.mainText : colors.secondaryText,
                backgroundColor: isDarkMode ? Colors.transparent :colors.lightbutton,
              ),
              onPressed: () {
                if (_names.every((name) => name.isNotEmpty)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoundScreen(names: _names,title: title)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('ادخل الاسماء')),
                  );
                }
              },
              child: Text('ابدأ دور ال16'),
            ),
          ],
        ),
      ),
    );
  }
}
