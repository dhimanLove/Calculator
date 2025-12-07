import 'package:flutter_test/flutter_test.dart';

import 'package:calculator/main.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial display is '0'.
    // Note: The '0' might appear multiple times (as the button '0' and the display '0').
    // So we use findsAtLeastNWidgets(1).
    expect(find.text('0'), findsAtLeastNWidgets(1));

    // Tap the '1' button.
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verify that '1' is displayed.
    expect(find.text('1'), findsAtLeastNWidgets(1));

    // Tap the '+' button.
    await tester.tap(find.text('+'));
    await tester.pump();

    // Tap the '2' button.
    await tester.tap(find.text('2'));
    await tester.pump();

    // Tap the '=' button.
    await tester.tap(find.text('='));
    await tester.pump();

    // Verify that the result '3' is displayed.
    expect(find.text('3'), findsAtLeastNWidgets(1));
  });
}
