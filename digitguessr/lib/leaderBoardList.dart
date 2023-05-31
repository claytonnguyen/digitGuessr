import 'package:digitguessr/highscore.dart';
import 'package:flutter/material.dart';

import 'leaderBoard.dart';

class LeaderBoardList extends StatefulWidget {
  const LeaderBoardList({Key? key}) : super(key: key);

  @override
  State<LeaderBoardList> createState() => _LeaderBoardListState();
}

class _LeaderBoardListState extends State<LeaderBoardList> {
  List<HighScore> highScores = [];

  void getScores() async {
    LeaderBoard leaderBoard = LeaderBoard();
    List<HighScore> scores;
    scores = await leaderBoard.getHighScore();
    setState(() {
      highScores = scores;
    });
  }

  @override
  void initState() {
    super.initState();
    getScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Card(
          child: Text(highScores[index].username)
        ),
        itemCount: highScores.length,
      ),
    );
  }
}
