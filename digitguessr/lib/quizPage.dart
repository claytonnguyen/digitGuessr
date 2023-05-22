import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitguessr/gameState.dart';
import 'package:digitguessr/leaderBoardPage.dart';
import 'package:digitguessr/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

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
    final controller = TextEditingController();
    Future createUser({required String name}) async {
      final docUser = FirebaseFirestore.instance.collection('players').doc('');
      final json = {
        'name': name,
        'score': gameState.points,
      };
      await docUser.set(json);
    }
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
                child: TextField(controller: controller),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    final name = controller.text;
                    createUser(name: name);
                  },
                ),
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
