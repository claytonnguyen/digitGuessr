import 'dart:math';
import 'dart:io';
import 'package:flutter/widgets.dart';

final questions = [
"129 is the atomic number of Unbiennium, an element yet to be discovered.",
"205726 is the number of gambling slots in Nevada in 1999, which was one slot for every 10 people residing there.",
"60 is the highest obtainable level on World of Warcraft (not including expansions).",
"194 is the number of historic building in the Braden Castle Park Historic District in Bradenton, Florida.",
"5000 is the number of base pairs in the DNA of the simplest viruses.",
"196 is the rank of Vanuatu in population density.",
"150000000 is the number of items held in the British Library.",
"1e+150 is the estimation of the game-tree complexity of xiangqi.",
"12 is the number of people who have walked on Earth's moon.",
"15 is the approximate speed in miles per hour a penguin swims at.",
"1e+21 is the number of grains of sand on all the world's beaches put together.",
"101 is is the number of floors of Taipei 101, the tallest skyscraper in the world from 2004 to 2010.",
"800000000 is the number of active users on Facebook as of December 2011.",
"267 is the number of groups of order 64.",
"189 is the atomic number of an element temporarily called Unoctennium.",
"328 is the weight in pounds of an ovarian cyst removed from a woman in Galveston, Texas, in 1905, a world record.",
"5600 is the number of metres above sea level of the highest bridge in the world, located in the Himalayan mountains.",
];

class GameState extends ChangeNotifier {
  double _points = 0;
  late GameQuestion gameQuestion;
  bool keepPlaying = true;

  GameState(){
    nextQuestion();
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
    // String line = await getQuestion();
    // List<String> lineList = line.split(" ");
    // var answer = int.tryParse(lineList[0]);
    // List<String> questionInList = lineList.getRange(1, lineList.length).toList();
    // String question = "";
    // questionInList.map((e) => question += e);
    // final hi = calcRange(answer, true);
    // final lo = calcRange(answer, false);
    // gameQuestion = GameQuestion(question, answer!, hi, lo);

    // gameQuestion = GameQuestion("No", 2, 0, 10);
    // notifyListeners();
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
  final double answer;
  double input;
  final double lowEndRange;
  final double highEndRange;
  final double timePercentage = 1;

  GameQuestion(this.question, this.answer, this.lowEndRange, this.highEndRange) : input = (highEndRange - lowEndRange) / 2;

}