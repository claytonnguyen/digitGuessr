import 'package:digitguessr/gameState.dart';
import 'package:digitguessr/highscore.dart';
import 'package:digitguessr/leaderBoard.dart';
import 'package:digitguessr/leaderboardresult.dart';
import 'package:digitguessr/main.dart';
import 'package:digitguessr/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitguessr/leaderboardresult.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  List<dynamic> highScores = [];

  void goHome(){
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.setDefault();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }


  void playAgain(){
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.reset();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizPage(),
      ),
    );
  }

  void getScores() async {
    LeaderBoard leaderBoard = LeaderBoard();
    List<dynamic> scores;
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
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text('LeaderBoard', textScaleFactor: 2.5),
              ),
              highScores.isEmpty ? Text("LOADING SCORES...") :
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => LeaderBoardResult(position: index + 1, highScore: highScores[index]),
                  itemCount: highScores.length,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(onPressed: playAgain, child: Text('Play Again')),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(onPressed: goHome, child: Text('Go Back Home')),
              )
            ],
          )
      ),
    );;
  }
}
