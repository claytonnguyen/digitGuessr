import 'dart:async';

import 'package:digitguessr/RoundResult.dart';
import 'package:digitguessr/answer.dart';
import 'package:digitguessr/displayQuestion.dart';
import 'package:digitguessr/gameEndPlace.dart';
import 'package:digitguessr/gameState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digitguessr/timing.dart';
import 'package:go_router/go_router.dart';

import 'gameEndCustom.dart';


class Question extends StatefulWidget {
  final GameState gameState;
  const Question({super.key, required this.gameState});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  bool printingAnswer = false;
  //RoundResult result = RoundResult(gameOver: true, points: 0, input: 0, answer: 0);
  late RoundResult result;

  void _increment() {
    if(widget.gameState.gameQuestion.input + 1 < widget.gameState.gameQuestion.highEndRange) {
      setState(() {
        widget.gameState.gameQuestion.input++;
      });
    }
  }

  void _decrement() {
    if(widget.gameState.gameQuestion.input - 1 > widget.gameState.gameQuestion.lowEndRange) {
      setState(() {
        widget.gameState.gameQuestion.input--;
      });
    }
  }

  void tapped() {
      setState(() {
        result = widget.gameState.calcPoints(widget.gameState.gameQuestion);
        if (result.gameOver == true) {
          print("${widget.gameState.gameSettings.timer} and ${widget.gameState.gameSettings.accuracy}");
          if (widget.gameState.gameSettings.timer != 30 || widget.gameState.gameSettings.accuracy != 0.3){
            print("HELKJFLKJDSKFJSsdfsdfffffffffffffffff");
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => gameEndCustom(state: widget.gameState, result: result),
              ),
            );
          }else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    gameEndPlace(state: widget.gameState, result: result),
              ),
            );
          }
        }
        printingAnswer = true;
      });
  }

  void playMore(){
    setState(() {
      widget.gameState.nextQuestion();
      printingAnswer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return printingAnswer ? Answer(result: result, nextQuestion: playMore) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DisplayQuestion(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Slider(
              min: widget.gameState.gameQuestion.lowEndRange,
              max: widget.gameState.gameQuestion.highEndRange,
              value: widget.gameState.gameQuestion.input,
              divisions: 100,
              label: '${widget.gameState.gameQuestion.input.floor()}',
              onChanged: (double value) {
                setState(() {
                  widget.gameState.gameQuestion.input = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: _decrement,
                  // onTap: s,
                  child: const Icon(
                      Icons.remove
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: _increment,
                  // onTap: s,
                  child: const Icon(
                      Icons.add
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: tapped,
              child: const Text("Guess"),
            ),
          )
      ],),
    );
  }

}