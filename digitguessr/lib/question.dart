import 'package:digitguessr/gameState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final GameState gameState;
  const Question({super.key, required this.gameState});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

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

  void tapped(){
    print(widget.gameState.calcPoints(widget.gameState.gameQuestion));
    widget.gameState.nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.gameState.gameQuestion.question}'),
        Text('${widget.gameState.gameQuestion.input.floor()}'),
        Slider(
          min:widget.gameState.gameQuestion.lowEndRange,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: _decrement,
              // onTap: s,
              child: const Icon(
                  Icons.remove
              ),
            ),
            InkWell(
              onTap: _increment,
              // onTap: s,
              child: const Icon(
                  Icons.add
              ),
            ),
          ],
        ),
        InkWell(
          onTap: tapped,
          child: const Text("Get Next Question"),
        )
    ],);
  }
}