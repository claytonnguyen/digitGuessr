import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:digitguessr/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('regular game options', () {
    testWidgets('Opens game correctly',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Play Game'), findsOneWidget);

          final customGameButton = find.text('Play Game');

          await tester.tap(customGameButton);
          await tester.pumpAndSettle();

          expect(find.textContaining('Time Left'), findsOneWidget);
          expect(find.textContaining('Total Points'), findsOneWidget);
        });

    testWidgets('Gets to ending result screen of question',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Play Game'), findsOneWidget);
          final customGameButton = find.text('Play Game');

          await tester.tap(customGameButton);
          await tester.pumpAndSettle();

          expect(find.textContaining('Guess'), findsOneWidget);
          final guessButton = find.text('Guess');

          expect(find.textContaining('Your Guess'), findsOneWidget);
          expect(find.textContaining('The Answer'), findsOneWidget);
        });

    testWidgets('Testing timer countdown',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Play Game'), findsOneWidget);
          final customGameButton = find.text('Play Game');

          await tester.tap(customGameButton);
          await tester.pumpAndSettle();

          expect(find.textContaining('30'), findsOneWidget);
          await tester.pump(const Duration(seconds: 5));

          expect(find.textContaining('25'), findsOneWidget);
        });
  });
}