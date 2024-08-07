import 'package:flutter/material.dart';
import 'package:football/round%2016/roundScreen.dart';

class NameEntryScreen extends StatefulWidget {
  @override
  _NameEntryScreenState createState() => _NameEntryScreenState();
}

class _NameEntryScreenState extends State<NameEntryScreen> {
  final _names = List<String>.generate(16, (_) => "");
  final _controllers = List<TextEditingController>.generate(16, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter 16 Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 16,
                itemBuilder: (context, index) {
                  return TextField(
                    controller: _controllers[index],
                    decoration: InputDecoration(labelText: 'Name ${index + 1}'),
                    onChanged: (value) {
                      _names[index] = value;
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_names.every((name) => name.isNotEmpty)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RoundScreen(names: _names)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter all 16 names')),
                  );
                }
              },
              child: Text('Start Tournament'),
            ),
          ],
        ),
      ),
    );
  }
}
