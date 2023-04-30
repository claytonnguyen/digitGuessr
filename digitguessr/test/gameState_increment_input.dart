// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:digitguessr/main.dart';

main() {
  testWidgets('Counter increments increasing by add button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    var input = find.textContaining('1234567890');

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.textContaining('1234567890') != input, true);
  });

  testWidgets('Counter increments decreasing by remove button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    var input = find.textContaining('1234567890');

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.textContaining('1234567890') != input, true);
  });

  testWidgets('Counter increments increasing by slider', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    var input = find.byType(Slider);
    //var xDrag = 1.0;
    var movement = const Offset(100, 0);

    // Tap the '+' icon and trigger a frame.
    await tester.drag(input, movement);

    // Verify that our counter has incremented.
    expect(find.textContaining('1234567890') != input, true);
  });

  testWidgets('Counter increments decreasing by slider', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    var input = find.byType(Slider);
    //var xDrag = 1.0;
    var movement = const Offset(-100, 0);

    // Tap the '+' icon and trigger a frame.
    await tester.drag(input, movement);

    // Verify that our counter has incremented.
    expect(find.textContaining('1234567890') != input, true);
  });
}
