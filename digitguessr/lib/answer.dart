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
          Padding(padding: const EdgeInsets.all(10.0), child: Text('Nice Job!', textScaleFactor: 2)),
          Padding(padding: const EdgeInsets.all(10.0), child: Text('You got ${result.points} more points', textScaleFactor: 1.5)),
          Padding(padding: const EdgeInsets.all(10.0), child: Text('Your Guess: ${result.input.round().toString()}', textScaleFactor: 1.5)),
          Padding(padding: const EdgeInsets.all(10.0), child: Text('The Answer: ${result.answer.round().toString()}', textScaleFactor: 1.5)),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(padding: const EdgeInsets.all(6.0), child: Text(result.low.toString(), textScaleFactor: 1.3)),
            Padding(padding: const EdgeInsets.all(10.0), child: Text(result.high.toString(), textScaleFactor: 1.3,))]),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(onPressed: () => nextQuestion(), child:
              Text("Next Question", textScaleFactor: 1.5)
            ),
          )
        ],
      ),
    );
  }
}
