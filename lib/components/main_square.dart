import 'package:flutter/material.dart';

class main_square extends StatelessWidget {
  final String child;
  final String pic;
  final String path;

  main_square({super.key, required this.child, required this.pic, required this.path});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, path);
        },
        child: Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage(pic),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                bottom: 10,
                child: Text(
                  child,
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
