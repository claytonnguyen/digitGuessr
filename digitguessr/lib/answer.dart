import 'package:digitguessr/RoundResult.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final RoundResult result;
  final Function nextQuestion;
  const Answer({super.key, required this.result, required this.nextQuestion});

  @override
  Widget build(BuildContext context) {
    RangeValues _currentRangeValues = (result.input < result.answer) ?
        RangeValues(result.input, result.answer) :
        RangeValues(result.answer, result.input);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          result.gameOver ? Text('Game Over') : Text('Nice Job!'),
          Text('You got ${result.points} points!'),
          Text('Your Guess: ${result.input.round().toString()}'),
          Text('The Answer: ${result.answer.round().toString()}'),
          RangeSlider(
            values: _currentRangeValues,
            min: result.low,
            max: result.high,
            divisions: 100,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (_) {},
          ),
          ElevatedButton(onPressed: () => nextQuestion(), child:
            Text("Next Question")
          )
        ],
      ),
    );
  }
}
