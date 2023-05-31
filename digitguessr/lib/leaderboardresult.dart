import 'package:flutter/material.dart';

import 'highscore.dart';

class LeaderBoardResult extends StatefulWidget {
  late HighScore highScore;
  LeaderBoardResult({super.key, required this.highScore});

  @override
  State<LeaderBoardResult> createState() => _LeaderBoardResultState();
}

class _LeaderBoardResultState extends State<LeaderBoardResult> {
  @override
  Widget build(BuildContext context) {
    return Center(

      child: Text(widget.highScore.username + ":   " + widget.highScore.score.toString())
    );
  }
}
