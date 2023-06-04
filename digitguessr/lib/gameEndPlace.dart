import 'package:digitguessr/highscore.dart';
import 'package:digitguessr/leaderBoard.dart';
import 'package:digitguessr/leaderBoardPage.dart';
import 'package:digitguessr/location.dart';
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

  String location = "";
  bool checked = false;
  bool placed = false;
  final _usernameController = TextEditingController(text: null);

  _submit() async {
      if(placed == true) {
        HighScore highScore = HighScore(username: _usernameController.text, score: widget.state.points, location: location);
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
    if(didPlace){
      location = await determinePosition();
      //print("location: ${location}");
    }
    setState(() {
      placed = didPlace;
      checked = true;
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
            placed ? TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              controller: _usernameController,
            ) : const Text(''),
            Padding( padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                  onPressed: _submit,
                  child: !checked ? const Text('CHECKING LEADERBOARD ELIGIBILITY...') : (!placed ? const Text("Go to Leaderboard", textScaleFactor: 1.5) : const Text("Put me on the LeaderBoard", textScaleFactor: 1.5))
              ),),
          ],
        ),
      ),
    );
  }
}
