

import 'dart:convert';
import 'dart:io';
import 'package:digitguessr/gameSettings.dart';

class GameState{
  var gameSetting = GameSettings();
  var _points = 0;

  // find and return the number of points this person gets
  // increment the total points as well
  getPoints(GameQuestion, double input){
    // find points based on time to input and accuracy
  }

  nextQuestion() async {
    String line = await getQuestion();
    List<String> lineList = line.split(" ");
    String answer = lineList[0];
    List<String> questionInList = lineList.getRange(1, lineList.length).toList();
    String question = "";
    questionInList.map((e) => question += e);
    return GameQuestion(question, answer);
  }

  Future<String> getQuestion() async {
    String question = "";
    var file = File("questions.txt");
    Stream<String> lines = file.openRead()
        .transform(utf8.decoder)       // Decode bytes to UTF-8.
        .transform(const LineSplitter());
    try {
      await for (var line in lines) {
        print('$line: ${line.length} characters');
      }
      print('File is now closed.');
    } catch (e) {
      print('Error: $e');
    }
    return question;
  }

}

class GameQuestion{
  final String question;
  final String _answer;

  GameQuestion(this.question, this._answer);
}