import 'package:digitguessr/gameState.dart';
import 'package:digitguessr/leaderBoardPage.dart';
import 'package:digitguessr/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void goToLeaderBoard(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LeaderBoardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GameState gameState = context.watch<GameState>();
    return Scaffold(
      body: gameState.gameOver ? Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Sorry, you lost'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('You got ${gameState.points} points'),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: () => gameState.reset(), child: Text('Play again')),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: goToLeaderBoard, child: Text('Go to the Leaderboard')),
              )
            ]),
      ) :
      Question(gameState: gameState),
    );
  }
}
