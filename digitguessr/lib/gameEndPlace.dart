import 'package:digitguessr/highscore.dart';
import 'package:digitguessr/leaderBoard.dart';
import 'package:digitguessr/leaderBoardPage.dart';
import 'package:flutter/material.dart';

import 'RoundResult.dart';
import 'gameState.dart';

class gameEndPlace extends StatefulWidget {
  final RoundResult result;
  final GameState state;
  const gameEndPlace({super.key, required this.result, required this.state});

  @override
  State<gameEndPlace> createState() => _gameEndPlaceState();
}

class _gameEndPlaceState extends State<gameEndPlace> {
  LeaderBoard leaderBoard = LeaderBoard();

  bool placed = false;
  final _usernameController = TextEditingController(text: null);

  _submit() async {
      if(placed == true) {
        HighScore highScore = HighScore(username: _usernameController.text, score: widget.state.points);
        await leaderBoard.placeTopTen(highScore);
      }
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LeaderBoardPage(),
        ),
      );
  }

  Future<void> checkPlacement() async {
    final didPlace = await leaderBoard.didPlace(widget.state.points);
    setState(() {
      placed = didPlace;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPlacement();

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
            placed ? TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              controller: _usernameController,
            ) : Text(''),
            ElevatedButton(
                onPressed: _submit,
                child: !placed ? Text("Go to Leaderboard") : Text("Put me on the LeaderBoard")
            ),
            widget.result.gameOver ? Text('Game Over') : Text('Nice Job!'),
            Text('You got ${widget.state.points} points!'),
            Text('Your Guess: ${widget.result.input.round().toString()}'),
            Text('The Answer: ${widget.result.answer.round().toString()}'),
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
            )
          ],
        ),
      ),
    );
  }
}
