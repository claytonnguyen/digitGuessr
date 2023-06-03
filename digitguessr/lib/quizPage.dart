import 'package:digitguessr/gameEndPlace.dart';
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
      body: gameState.gameOver ? gameEndPlace(result: gameState.calcPoints(gameState.gameQuestion), state: gameState) :
      Question(gameState: gameState),
    );
  }
}
