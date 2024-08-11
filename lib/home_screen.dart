import 'package:flutter/material.dart';

import 'components/main_square.dart';
import 'database/database.dart';
import 'components/drawer.dart';

class home_screen extends StatelessWidget {
   home_screen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اختار التحدي', style: TextStyle(fontSize: 40),),
        centerTitle: true,
      ),
      drawer: TheDrawer(),
      body: ListView.builder(
          itemCount: main_categories.length,
          itemBuilder: (context,index ){
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: MainSquare(
                child: main_categories[index]['title']!,
                pic: main_categories[index]['image']!,
                gamePlay: main_categories[index]['type']!,
                path: main_categories[index]['path']!,
              ),
            );
          }),
    );
  }
}
