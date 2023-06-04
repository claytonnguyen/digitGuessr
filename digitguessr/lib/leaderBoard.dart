import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitguessr/highscore.dart';
import 'package:digitguessr/highscore.dart';

import 'RoundResult.dart';
import 'highscore.dart';

class LeaderBoard{
  static const _username = "username";
  static const _points = "points";
  static const _location = "location";

  String _collectionName = 'leaderboard';
  String _documentName = 'T0jW00lvbVIRjg6djqTH';

  FirebaseFirestore _firestore;

  LeaderBoard({ FirebaseFirestore? firestore }): _firestore = firestore ?? FirebaseFirestore.instance;

  Map<String, dynamic> _roundListToDocumentData(List<HighScore> highScore) => {
    'scores': highScore.map((score) => _roundToDocumentData(score)).toList()
  };

  Map<String, dynamic> _roundToDocumentData(HighScore highScore) => {
    _username : highScore.username,
    _points : highScore.score,
    _location : highScore.location
  };

  Future<bool> didPlace(int score) async {
    List<HighScore> highscores = await getHighScore();
    if(highscores.length < 10) {
      return true;
    }
    if(highscores.last.score < score){
      return true;
    } else{
      return false;
    }
  }

  Future<bool> placeTopTen(HighScore highscore) async {
    List<HighScore> highscores = await getHighScore();
    if(highscores.length < 10){
      highscores.add(highscore);
      await updateLeaderBoard(highscores);
      return true;
    }
    if(highscores.last.score < highscore.score){
      highscores.add(highscore);
      highscores.sort((a, b) => a.score > b.score ? -1 : 1);
      List<HighScore> topten;
      if(highscores.length >= 10){
        topten = highscores.sublist(0, 10);
      } else {
        topten = highscores.sublist(0, highscores.length);
      }
      await updateLeaderBoard(topten);
      return true;
    }
    return false;
  }

  Future<void> updateLeaderBoard(List<HighScore> highscores) async {
    final docRef = await _ordersCollection.doc(_documentName).set(_roundListToDocumentData(highscores));
  }



  CollectionReference<Map<String, dynamic>> get _ordersCollection => _firestore.collection(_collectionName);

  Future<List<HighScore>> getHighScore() async {
    final queryResults = await _ordersCollection.doc(_documentName)
        .get();
    return _documentDataToHighScoreList(queryResults.data()!);
  }

  List<HighScore> _documentDataToHighScoreList(Map<String, dynamic> data) {
    final leaderboard = data['scores'];
    List<HighScore> highscores;
    highscores = leaderboard.map<HighScore>((e) => _documentDataToHighScore(e)).toList();
    highscores.sort((a, b) => a.score > b.score ? -1 : 1);
    List<HighScore> topten;
    if(highscores.length >= 10){
      topten = highscores.sublist(0, 10);
    } else {
      topten = highscores.sublist(0, highscores.length);
    }
    return topten;
  }

  HighScore _documentDataToHighScore(Map<String, dynamic> score) {
    return HighScore(
        score: score[_points],
        username: score[_username],
        location: score[_location]
    );
  }
}