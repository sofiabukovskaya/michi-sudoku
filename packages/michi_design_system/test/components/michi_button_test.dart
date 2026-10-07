import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:michi_design_system/michi_design_system.dart';

void main() {
  testWidgets('MichiButton invokes its action and respects disabled state', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MichiButton(label: 'Почати', onPressed: () => taps++),
        ),
      ),
    );
    await tester.tap(find.text('Почати'));
    expect(taps, 1);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MichiButton(label: 'Почати', onPressed: null),
        ),
      ),
    );
    await tester.tap(find.text('Почати'));
    expect(taps, 1);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MichiButton(
            label: 'Почати',
            onPressed: () => taps++,
            isLoading: true,
          ),
        ),
      ),
    );
    expect(find.text('Почати'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.text('Почати'));
    expect(taps, 1);
  });
}
