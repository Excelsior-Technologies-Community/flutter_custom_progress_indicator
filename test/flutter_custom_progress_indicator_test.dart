import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_custom_progress_indicator/flutter_custom_progress_indicator.dart';

void main() {
  group('CustomLinearProgressIndicator Tests', () {
    testWidgets('renders progress indicator and percentage text overlay',
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

    testWidgets('formats text correctly using custom valueFormatter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomLinearProgressIndicator(
              progress: 0.8,
              showPercentage: true,
              valueFormatter: (val) => 'Step ${(val * 10).round()} of 10',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Step 8 of 10'), findsOneWidget);
    });

    testWidgets('renders linear gradient fill without throwing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomLinearProgressIndicator(
              progress: 0.4,
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomLinearProgressIndicator), findsOneWidget);
    });
  });

  group('CustomCircularProgressIndicator Tests', () {
    testWidgets('renders circular indicator and percentage overlay',
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

    testWidgets('renders custom central child widget overlay',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCircularProgressIndicator(
              progress: 0.9,
              child: Icon(Icons.star, key: Key('custom_center_icon')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('custom_center_icon')), findsOneWidget);
    });

    testWidgets('renders sweep gradient circular indicator without error',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomCircularProgressIndicator(
              progress: 0.6,
              gradient: SweepGradient(
                colors: [Colors.yellow, Colors.red],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CustomCircularProgressIndicator), findsOneWidget);
    });
  });
}
