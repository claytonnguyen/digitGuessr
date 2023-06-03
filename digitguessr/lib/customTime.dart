import 'package:flutter/material.dart';

import 'gameState.dart';

class customTime extends StatefulWidget {
  final GameState gameState;
  const customTime({super.key, required this.gameState});

  @override
  State<customTime> createState() => _customTimeState();
}

class _customTimeState extends State<customTime> {

  void _increment() {
    if(widget.gameState.gameSettings.timer + 1 <= 60) {
      setState(() {
        widget.gameState.gameSettings.timer += 1;
      });
    }
  }

  void _decrement() {
    if(widget.gameState.gameSettings.timer - 1 >= 3) {
      setState(() {
        widget.gameState.gameSettings.timer  -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${(widget.gameState.gameSettings.timer).round()} seconds to answer"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Slider(
            min: 3,
            max: 60,
            value: widget.gameState.gameSettings.timer.toDouble(),
            divisions: 100,
            label: '${widget.gameState.gameSettings.timer}',
            onChanged: (double value) {
              setState(() {
                widget.gameState.gameSettings.timer = value.toInt();
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
