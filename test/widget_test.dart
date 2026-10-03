import 'package:flutter_test/flutter_test.dart';
import 'package:asynchronous_dart/main.dart';

void main() {
  testWidgets('App loads successfully',
          (WidgetTester tester) async {

        await tester.pumpWidget(
          const AsyncLearningApp(),
        );

        expect(
          find.text('Async Programming in Dart'),
          findsOneWidget,
        );

        expect(
          find.text('Future Example'),
          findsOneWidget,
        );

        expect(
          find.text('Async / Await Example'),
          findsOneWidget,
        );

        expect(
          find.text('Try Catch Example'),
          findsOneWidget,
        );

        expect(
          find.text('Stream Example'),
          findsOneWidget,
        );
      });
}