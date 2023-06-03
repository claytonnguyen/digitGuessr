import 'package:digitguessr/location.dart';
import 'package:digitguessr/question.dart';
import 'package:digitguessr/quizPage.dart';
import 'package:digitguessr/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:digitguessr/gameState.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   _initFirebase();
  runApp(const MyApp());
}

void _initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => new GameState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void playGame() async {
    final gameState = Provider.of<GameState>(context, listen: false);
    gameState.nextQuestion();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizPage(),
      ),
    );
  }

  void settingsPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(33.0),
              child: Text("DigitGuessr", textScaleFactor: 3),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: playGame, child: Text('Play Game')),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(onPressed: settingsPage, child: Text('Custom Game')),
            )
          ],
        ),
      ),
    );
  }
}