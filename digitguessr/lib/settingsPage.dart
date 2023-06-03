import 'package:digitguessr/main.dart';
import 'package:digitguessr/question.dart';
import 'package:digitguessr/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'customAccuracy.dart';
import 'customGame.dart';
import 'customTime.dart';
import 'gameState.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void goHome(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  void play(){
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.nextQuestion();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CustomGame(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Custom Game', textScaleFactor: 2.5),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: customAccuracy(gameState: gameState),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: customTime(gameState: gameState),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: play, child: Text("Play Custom Game")),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: goHome, child: Text("Go Back")),
              )
            ],
          )
      ),
    );
  }
}
