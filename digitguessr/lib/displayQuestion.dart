import 'package:digitguessr/gameState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayQuestion extends StatelessWidget {
  const DisplayQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return Column( children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('${gameState.gameQuestion.question}', textAlign: TextAlign.center, textScaleFactor: 2.5,),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('${gameState.gameQuestion.input.floor()}', textScaleFactor: 2,),
      ),
    ]);
  }
}
