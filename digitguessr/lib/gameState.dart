import 'dart:math';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class GameState extends ChangeNotifier {
  List<String> questions = [];
  double _points = 0;
  late GameQuestion gameQuestion;
  bool keepPlaying = true;

  GameState(){
    getQuestions().then((value) => questions = value);
  }

  // find and return the number of points this person gets
  // increment the total points as well
  calcPoints(GameQuestion gameQuestion){
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
    notifyListeners();
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

  nextQuestion() {

    // List<String> lineList = line.split(" ");
    // var answer = int.tryParse(lineList[0]);
    // List<String> questionInList = lineList.getRange(1, lineList.length).toList();
    // String question = "";
    // questionInList.map((e) => question += e);
    // final hi = calcRange(answer, true);
    // final lo = calcRange(answer, false);
    // gameQuestion = GameQuestion(question, answer!, hi, lo);
    print('this is the list count${questions.length}');
    var index = Random().nextInt(questions.length);
    gameQuestion = GameQuestion(questions[index], 2, 0, 10);
    // notifyListeners();
  }

  Future<String> returnQuestion(List<String> lines) async {
    var index = Random().nextInt(lines.length);
    return lines[index];
  }

  Future<List<String>> getQuestions() async {
    final stringOfQuestions = await rootBundle.loadString('assets/questions.txt');
    return stringOfQuestions.split('\n');
  }

}

// Time percentage allows us to use the time as a calculator to calculate the points
class GameQuestion{
  final String question;
  final double answer;
  double input;
  final double lowEndRange;
  final double highEndRange;
  final double timePercentage = 1;

  GameQuestion(this.question, this.answer, this.lowEndRange, this.highEndRange) : input = (highEndRange - lowEndRange) / 2;

}