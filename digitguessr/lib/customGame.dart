import 'package:digitguessr/gameEndCustom.dart';
import 'package:digitguessr/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'gameState.dart';

class CustomGame extends StatefulWidget {
  const CustomGame({super.key});

  @override
  State<CustomGame> createState() => _CustomGameState();
}

class _CustomGameState extends State<CustomGame> {

  @override
  Widget build(BuildContext context) {
    final GameState gameState = context.watch<GameState>();
    return Scaffold(
      body: gameState.gameOver ? gameEndCustom(result: gameState.calcPoints(gameState.gameQuestion), state: gameState) :
      Question(gameState: gameState),
    );
  }
}
