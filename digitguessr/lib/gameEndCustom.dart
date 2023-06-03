import 'package:digitguessr/customAccuracy.dart';
import 'package:digitguessr/quizPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RoundResult.dart';
import 'gameState.dart';
import 'main.dart';

class gameEndCustom extends StatefulWidget {
  final RoundResult result;
  final GameState state;
  const gameEndCustom({super.key, required this.result, required this.state});

  @override
  State<gameEndCustom> createState() => _gameEndCustomState();
}

class _gameEndCustomState extends State<gameEndCustom> {
  void goHome(){
    widget.state.setDefault();
    widget.state.gameSettings.accuracy = 0.3;
    widget.state.gameSettings.timer = 30;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = (widget.result.input < widget.result.answer) ?
    RangeValues(widget.result.input, widget.result.answer) :
    RangeValues(widget.result.answer, widget.result.input);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(10.0), child: Text('Game Over', textScaleFactor: 2)),
            Padding(padding: const EdgeInsets.all(10.0), child: Text('You ended with ${widget.state.points} points!', textScaleFactor: 1.5)),
            Padding(padding: const EdgeInsets.all(10.0), child: Text('Your Guess: ${widget.result.input.round().toString()}', textScaleFactor: 1.5)),
            Padding(padding: const EdgeInsets.all(10.0), child: Text('The Answer: ${widget.result.answer.round().toString()}', textScaleFactor: 1.5)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(padding: const EdgeInsets.all(6.0), child: Text(widget.result.low.toString(), textScaleFactor: 1.3)),
              Padding(padding: const EdgeInsets.all(10.0), child: Text(widget.result.high.toString(), textScaleFactor: 1.3,))]),
            RangeSlider(
              values: _currentRangeValues,
              min: widget.result.low,
              max: widget.result.high,
              divisions: 100,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (_) {},
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(onPressed: goHome, child: Text('Go Back Home')),
            )
          ],
        ),
      ),
    );
  }
}
