import 'package:flutter/material.dart';
import 'package:football/round%2016/round.dart';

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
            _AnimatedText(winner: winner),
            SizedBox(height: 20),
            _AnimatedButton(),
          ],
        ),
      ),
    );
  }
}

class _AnimatedText extends StatefulWidget {
  final String winner;

  _AnimatedText({required this.winner});

  @override
  __AnimatedTextState createState() => __AnimatedTextState();
}

class __AnimatedTextState extends State<_AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.5), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          'The winner is ${widget.winner}!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AnimatedButton extends StatefulWidget {
  @override
  __AnimatedButtonState createState() => __AnimatedButtonState();
}

class __AnimatedButtonState extends State<_AnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.green).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NameEntryScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _colorAnimation.value,
            ),
            child: Text('Play Again'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
