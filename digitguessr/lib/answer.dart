import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final points;
  final gameOver;
  const Answer({super.key, required this.points, required this.gameOver });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gameOver ? Text('Game Over') : Text('Nice Job!'),
          Text('You got $points points!'),
        ],
      ),
    );
  }
}
