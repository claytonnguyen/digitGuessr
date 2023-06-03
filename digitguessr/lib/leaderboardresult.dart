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
      color: Colors.white38,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.position.toString()}", textScaleFactor: 1.25),
            Column(
              children: [
                Text("${widget.highScore.username}"),
                Text(widget.highScore.location)
              ],
            ),
            Text("${widget.highScore.score}", textScaleFactor: 1.25)
        ]
        )
        )
    );
  }
}
