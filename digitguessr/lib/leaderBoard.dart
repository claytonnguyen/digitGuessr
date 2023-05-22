import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitguessr/user.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});
  @override
  Widget build(BuildContext context) => StreamBuilder<List<User>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('snapshot error');
        }
        else if (snapshot.hasData) {
          final users = snapshot.data!;
          return ListView(
            children: users.map(buildUser).toList(),
          );
        } else{
          return Center(child:CircularProgressIndicator());
        }
      });

    Stream<List<User>> readUsers() => FirebaseFirestore.instance
        .collection('players')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
    Widget buildUser(User user)=> ListTile(
      title: Text(user.name),
      subtitle: Text(user.score)
    );
  }
