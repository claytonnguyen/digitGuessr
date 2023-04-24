import 'dart:math';
import 'dart:io';
import 'package:digitguessr/gameSettings.dart';

class GameState{
  var gameSetting = GameSettings();
  double _points = 0;

  // find and return the number of points this person gets
  // increment the total points as well
  getPoints(GameQuestion gameQuestion){
    double points = 0;
    if(gameQuestion.timePercentage == 0){
      return 0;
    } else {
      final range = gameQuestion.highEndRange - gameQuestion.lowEndRange;
      final inputFromAnswer = (gameQuestion.answer - gameQuestion.input).abs();
      final accuracy = inputFromAnswer / range;
      points = accuracy * 100;
      _points += points;
    }
    return points;
  }

  calcRange(answer, high){
    var scalar = Random().nextDouble() + .1;
    var coefficient = Random().nextInt(9) + 1;
    if(high){
      answer + coefficient * scalar;
    } else {
      answer - coefficient * scalar;
    }
  }

  Future<GameQuestion> nextQuestion() async {
    String line = await getQuestion();
    List<String> lineList = line.split(" ");
    var answer = int.tryParse(lineList[0]);
    List<String> questionInList = lineList.getRange(1, lineList.length).toList();
    String question = "";
    questionInList.map((e) => question += e);
    final hi = calcRange(answer, true);
    final lo = calcRange(answer, false);
    return GameQuestion(question, answer!, hi, lo);
  }

  Future<String> returnQuestion(List<String> lines) async {
    var index = Random().nextInt(lines.length);
    return lines[index];
  }

  Future<String> getQuestion() async {
    String question = "";
    var file = File("questions.txt");
    question = await file.readAsLines().then(returnQuestion);
    return question;
  }

}

// Time percentage allows us to use the time as a calculator to calculate the points
class GameQuestion{
  final String question;
  final int answer;
  double input;
  final double lowEndRange;
  final double highEndRange;
  final double timePercentage = 1;

  GameQuestion(this.question, this.answer, this.lowEndRange, this.highEndRange) : input = (highEndRange - lowEndRange) / 2;

}