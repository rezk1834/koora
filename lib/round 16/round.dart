import 'package:flutter/material.dart';

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

class RoundScreen extends StatefulWidget {
  final List<String> names;

  RoundScreen({required this.names});

  @override
  _RoundScreenState createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  late List<String> _currentRound;
  late List<String> _nextRound;
  int _roundNumber = 16;

  @override
  void initState() {
    super.initState();
    _currentRound = List.from(widget.names)..shuffle();
    _nextRound = [];
  }

  void _playNextRound() {
    if (_currentRound.length == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WinnerScreen(winner: _currentRound.first)),
      );
    } else {
      setState(() {
        _currentRound = List.from(_nextRound);
        _nextRound.clear();
        _roundNumber = _currentRound.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round of $_roundNumber'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _currentRound.length; i += 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _nextRound.add(_currentRound[i]);
                          });
                          if (_nextRound.length == _currentRound.length ~/ 2) {
                            _playNextRound();
                          }
                        },
                        child: Text(_currentRound[i]),
                      ),
                    ),
                    SizedBox(width: 16),
                    if (i + 1 < _currentRound.length)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _nextRound.add(_currentRound[i + 1]);
                            });
                            if (_nextRound.length == _currentRound.length ~/ 2) {
                              _playNextRound();
                            }
                          },
                          child: Text(_currentRound[i + 1]),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class WinnerScreen extends StatelessWidget {
  final String winner;

  WinnerScreen({required this.winner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Winner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The winner is $winner!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => NameEntryScreen()),
                );
              },
              child: Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}