import 'package:flutter/material.dart';

import 'gameState.dart';

class customAccuracy extends StatefulWidget {
  final GameState gameState;
  const customAccuracy({super.key, required this.gameState});

  @override
  State<customAccuracy> createState() => _customAccuracyState();
}

class _customAccuracyState extends State<customAccuracy> {

  void _increment() {
    if(widget.gameState.gameSettings.accuracy + 0.01 <= 1) {
      setState(() {
        widget.gameState.gameSettings.accuracy += 0.01;
      });
    }
  }

  void _decrement() {
    if(widget.gameState.gameSettings.accuracy - .01 >= 0) {
      setState(() {
        widget.gameState.gameSettings.accuracy  -= .01;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${(widget.gameState.gameSettings.accuracy * 100).round()}% Accuracy"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Slider(
            min: 0,
            max: 1,
            value: widget.gameState.gameSettings.accuracy,
            divisions: 100,
            label: '${widget.gameState.gameSettings.accuracy}',
            onChanged: (double value) {
              setState(() {
                widget.gameState.gameSettings.accuracy = value;
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
      ],);
  }
}
