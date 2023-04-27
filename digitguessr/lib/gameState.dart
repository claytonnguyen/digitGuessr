import 'dart:math';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:digitguessr/gameSettings.dart';

class GameState extends ChangeNotifier {
  GameSettings gameSettings = GameSettings();
  List<String> questions = [];
  double _points = 0;
  GameQuestion gameQuestion = GameQuestion("Sample Question", 10, 0, 20);
  bool keepPlaying = true;

  GameState(){
    getQuestions().then((value) => questions = value).then( (_) =>
      nextQuestion()
    );
  }

  // find and return the number of points this person gets
  // increment the total points as well
  bool calcPoints(GameQuestion gameQuestion){
    double points = 0;
    if(gameQuestion.timePercentage == 0){
      return false;
    } else {
      final range = gameQuestion.highEndRange - gameQuestion.lowEndRange;
      final inputFromAnswer = (gameQuestion.answer - gameQuestion.input).abs();
      final accuracy = inputFromAnswer / range;
      points = accuracy * 100;
      _points += points;
      if (accuracy > gameSettings.accuracy){
        return false;
      } else {
        return true;
      }
    }
  }

  double calcRange(answer, high){
    var scalar = Random().nextDouble() + 2;
    var coefficient = Random().nextInt(99) + 1;
    if(high){
      return answer + (coefficient * scalar);
    } else {
      return answer - (coefficient * scalar);
    }
  }

  nextQuestion() {
    var index = Random().nextInt(questions.length);
    String line = questions[index];
    List<String> lineList = line.split(" ");
    double answer = double.tryParse(lineList[0]) ?? 0;
    List<String> questionInList = lineList.getRange(1, lineList.length).toList();
    String question = questionInList.join(" ");
    double hi = calcRange(answer, true);
    double lo = calcRange(answer, false);
    gameQuestion = GameQuestion(question, answer, lo, hi);
    notifyListeners();
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

  GameQuestion(this.question, this.answer, this.lowEndRange, this.highEndRange) : input = ((highEndRange - lowEndRange) / 2) + lowEndRange;

}