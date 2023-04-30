import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digitguessr/main.dart';

main() {
  testWidgets('Changes question text after ', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    var question = find.byType(Text);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text("Get Next Question"));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.byType(Text) != question, true);
  });
}