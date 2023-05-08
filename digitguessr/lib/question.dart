import 'package:digitguessr/gameState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final GameState gameState;
  bool guessTap = false;
  Question({super.key, required this.gameState});


  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool guessTap = false;
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

    guessTap = false;

    widget.gameState.nextQuestion();
  }
  void guessTapped(){
    print(widget.gameState.calcPoints(widget.gameState.gameQuestion));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Card(
          elevation: 1,
          color: Colors.black,
          child: SizedBox(
            width: 400,
            height: 100,
            child: Center(child: Text('${widget.gameState.gameQuestion.question}',
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

        Text('${widget.gameState.gameQuestion.formatAmount()}',
          style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontFamily: 'Open Sans',
              fontSize: 30),
        ),
        Visibility(
            visible: guessTap,
            child: Text('${widget.gameState.calcPoints(widget.gameState.gameQuestion)}, answer is ${widget.gameState.gameQuestion.answer}',
              style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Open Sans',
                  fontSize: 30),
            )
        ),
        Visibility(
            visible: !guessTap,
            child: Slider(
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
            )
        ),
        Visibility(
            visible: !guessTap,
            child:Row(
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
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: Card(
                color: Colors.amberAccent,
                child: Center(
                  child: InkWell(
                    onTap:(){
                      setState((){
                        guessTap = true;
                      });
                    },
                    child: const Text("Guess",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 30),
                    ),
                  ), //Text
                ), //Center
              ), //Card
            ),
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: Card(
                color: Colors.lightGreen,
                child: Center(
                  child: InkWell(
                    onTap: tapped,
                    child: const Text("Next",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          fontFamily: 'Open Sans',
                          fontSize: 30),
                    ),
                  ), //Text
                ), //Center
              ), //Card
            ),
          ],
        ),
      ],);
  }
}