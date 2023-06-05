import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:digitguessr/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('custom game options', () {
    testWidgets('custom game opening with correct opening descriptors for sliders',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Custom Game'), findsOneWidget);

          final customGamebutton = find.text('Custom Game');

          await tester.tap(customGamebutton);
          await tester.pumpAndSettle();

          expect(find.textContaining('Accuracy'), findsOneWidget);
          expect(find.textContaining('seconds'), findsOneWidget);
        });

    testWidgets('custom game sliders with tapping icons',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Custom Game'), findsOneWidget);

          final customGamebutton = find.text('Custom Game');

          await tester.tap(customGamebutton);
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.add), findsNWidgets(2));
          expect(find.byIcon(Icons.remove), findsNWidgets(2));

          // Testing Increasing Values
          final addButton  = find.byIcon(Icons.add);
          await tester.tap(addButton.first);
          await tester.pumpAndSettle();
          await tester.tap(addButton.last);
          await tester.pumpAndSettle();

          //Testing decreasing values
          final subButton  = find.byIcon(Icons.remove);
          await tester.tap(subButton.first);
          await tester.pumpAndSettle();
          await tester.tap(subButton.last);
          await tester.pumpAndSettle();
        });

    testWidgets('custom game sliders with using sliders',
            (tester) async {
          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Custom Game'), findsOneWidget);

          final customGamebutton = find.text('Custom Game');

          await tester.tap(customGamebutton);
          await tester.pumpAndSettle();

          expect(find.byElementType(Slider), findsNWidgets(2));

          // Testing increasing movement
          var input = find.byType(Slider);
          var addMovement = const Offset(100, 0);
          await tester.drag(input.first, addMovement);
          await tester.drag(input.last, addMovement);

          // Testing decreasing movement
          var subMovement = const Offset(-100, 0);
          await tester.drag(input.first, subMovement);
          await tester.drag(input.last, subMovement);
        });
  });
}