import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitguessr/highscore.dart';

import 'RoundResult.dart';

class LeaderBoard{
  static const _username = "username";
  static const _points = "points";

  String _collectionName = 'leaderboard';
  String _documentName = 'T0jW00lvbVIRjg6djqTH';

  FirebaseFirestore _firestore;

  LeaderBoard({ FirebaseFirestore? firestore }): _firestore = firestore ?? FirebaseFirestore.instance;

  Map<String, dynamic> _roundListToDocumentData(HighScore highScore) => {
    'scores': _roundToDocumentData(highScore)
  };

  Map<String, dynamic> _roundToDocumentData(HighScore highScore) => {
    _username : highScore.username,
    _points : highScore.score
  };

  Future<void> placeOrder() async {
    var score = HighScore(username: 'happiness', score: 100);
    final docRef = await _ordersCollection.doc(_documentName).update(_roundListToDocumentData(score));
  }

  CollectionReference<Map<String, dynamic>> get _ordersCollection => _firestore.collection(_collectionName);

  Future<List<HighScore>> getHighScore() async {
    final queryResults = await _ordersCollection.doc(_documentName)
        .get();
    print('hi');
    print(queryResults.data());
    //return queryResults.docs.map((doc) => _documentDataToLatteList(doc.data())).toList();
    return _documentDataToHighScoreList(queryResults.data()!);
  }

  List<HighScore> _documentDataToHighScoreList(Map<String, dynamic> data) {
    print('hello');
    print(data['scores']);
    final leaderboard = data['scores'];
    print(leaderboard);

    print('no');
    print(leaderboard.first.keys);
    List<HighScore> highscores;
    //return leaderboard.entries.map((e) => _documentDataToHighScore(e as Map<String, dynamic>)).toList();
    highscores = leaderboard.map<HighScore>((e) => _documentDataToHighScore(e)).toList();
    return highscores;

  }

  HighScore _documentDataToHighScore(Map<String, dynamic> score) {
    print(score);
    return HighScore(
        score: score[_points],
        username: score[_username]
    );
  }
}