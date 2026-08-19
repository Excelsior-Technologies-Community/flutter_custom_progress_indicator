import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_progress_indicator/flutter_custom_progress_indicator.dart';

void main() {
  testWidgets('CustomLinearProgressIndicator renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomLinearProgressIndicator(
            progress: 0.5,
            showPercentage: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CustomLinearProgressIndicator), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);
  });

  testWidgets('CustomCircularProgressIndicator renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CustomCircularProgressIndicator(
            progress: 0.75,
            showPercentage: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
    expect(find.text('75%'), findsOneWidget);
  });
}

