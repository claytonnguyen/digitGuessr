import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:digitguessr/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('custom game play', () {
    testWidgets('custom game with timer changed',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Custom Game'), findsOneWidget);
          final customGameButton = find.text('Custom Game');

          await tester.tap(customGameButton);
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.add), findsNWidgets(2));
          expect(find.byIcon(Icons.remove), findsNWidgets(2));

          // Testing Increasing Values
          final addButton  = find.byIcon(Icons.add);
          for(int i = 0; i < 5; i++){
            await tester.tap(addButton.last);
            await tester.pumpAndSettle();
          }

          expect(find.text('Play Custom Game'), findsOneWidget);
          final playCustomButton = find.text('Play Custom Game');

          await tester.tap(playCustomButton);
          await tester.pumpAndSettle();

          expect(find.textContaining('35'), findsOneWidget);
        });
  });
}