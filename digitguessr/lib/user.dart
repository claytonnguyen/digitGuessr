import 'package:firebase_core/firebase_core.dart';
class User {
  final String name;
  final score;

  User({
    required this.name,
    required this.score,
});
  Map<String, dynamic> toJson()=>{
    'name': name,
    'score': score
  };
  static User fromJson(Map<String,dynamic>json) => User(
  name: json['name'],
  score: json['score']
  );

}