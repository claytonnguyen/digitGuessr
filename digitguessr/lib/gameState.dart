import 'dart:math';
import 'dart:io';
import 'dart:async';
import 'package:digitguessr/RoundResult.dart';
import 'package:digitguessr/timing.dart';
import 'package:flutter/widgets.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:digitguessr/gameSettings.dart';

class GameState extends ChangeNotifier {
  GameSettings gameSettings = GameSettings();
  List<String> questions = [];
  double _points = 0;
  late GameQuestion gameQuestion;
  bool gameOver = false;
  int? timer;

  GameState(){
    getQuestions().then((value) => questions = value).then( (_) =>
      nextQuestion()
    );
  }

  void getTime(int time){
    timer = time;
    notifyListeners();
  }

  void youLose(){
    gameOver = true;
    notifyListeners();
  }

  void reset(){
    gameOver = false;
    _points = 0;
    timer = gameSettings.timer;
    nextQuestion();
    notifyListeners();
  }

  get points => _points.round();

  // find and return the number of points this person gets
  // increment the total points as well
  RoundResult calcPoints(GameQuestion gameQuestion){
    double points = 0;
    gameQuestion.stopTheClock();
    if(gameQuestion.timePercentage == 0){
      gameOver = true;
      notifyListeners();
      return RoundResult(true, 0);
    } else {
      final range = gameQuestion.highEndRange - gameQuestion.lowEndRange;
      final inputFromAnswer = (gameQuestion.answer - gameQuestion.input).abs();
      final accuracy = inputFromAnswer / range;
      points = 1 / accuracy;
      notifyListeners();
      if (accuracy > gameSettings.accuracy){
        gameOver = true;
        notifyListeners();
        return RoundResult(true, 0);
      } else {
        _points += points;
        notifyListeners();
        return RoundResult(false, points.round());
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
    gameQuestion = GameQuestion(question, answer, lo, hi, gameSettings, youLose, getTime);
    notifyListeners();
  }


  Future<List<String>> getQuestions() async {
    final stringOfQuestions = await rootBundle.loadString('assets/questions.txt');
    return stringOfQuestions.split('\n');
  }

}


// Time percentage allows us to use the time as a calculator to calculate the points
class GameQuestion {
  final String question;
  final double answer;
  late double input;
  final double lowEndRange;
  final double highEndRange;
  final double timePercentage = 1;
  late final Timing stopWatch;
  final GameSettings gameSettings;
  Function callback;
  Function getTimeLeft;

  GameQuestion(this.question, this.answer, this.lowEndRange, this.highEndRange,
      this.gameSettings, this.callback, this.getTimeLeft) {
    input = ((highEndRange - lowEndRange) / 2) + lowEndRange;
    stopWatch = Timing(seconds: gameSettings.timer,
        callback: callback, getTimeLeft: getTimeLeft);
  }

  stopTheClock(){
    stopWatch.stop();
  }

}