import 'package:digitguessr/gameState.dart';
import 'package:digitguessr/main.dart';
import 'package:digitguessr/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitguessr/leaderBoard.dart';
class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LeaderBoard(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: playAgain, child: Text('Play Again')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: goHome, child: Text('Go Back Home')),
              )
            ],
          )
      ),
    );;
  }
}
