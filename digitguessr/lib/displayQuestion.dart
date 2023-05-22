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
        child: Text('${gameState.timer ?? gameState.gameSettings.timer}', textAlign: TextAlign.center, textScaleFactor: 1.5),
      ),
      Card(
        elevation: 1,
        color: Colors.black,
        child: SizedBox(
          width: 400,
          height: 100,
          child: Center(child: Text('${gameState.gameQuestion.question}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.normal,
                fontFamily: 'Open Sans',
              )
          )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('${gameState.gameQuestion.input.floor()}', style:TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'Open Sans',
            fontSize: 30
        )),
      ),
    ]);
  }
}
