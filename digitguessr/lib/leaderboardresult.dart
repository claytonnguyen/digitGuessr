import 'package:flutter/material.dart';

import 'highscore.dart';

class LeaderBoardResult extends StatefulWidget {
  late HighScore highScore;
  late int position;
  LeaderBoardResult({super.key, required this.position, required this.highScore});

  @override
  State<LeaderBoardResult> createState() => _LeaderBoardResultState();
}

class _LeaderBoardResultState extends State<LeaderBoardResult> {
  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(widget.position.toString() + " " + widget.highScore.username + ":   " + widget.highScore.score.toString()),
      )
    );
  }
}
