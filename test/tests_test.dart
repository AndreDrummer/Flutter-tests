import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:renato/counter.dart';
import 'package:renato/http_fetch.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:renato/interaction_user.dart';
import 'package:renato/widget.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('Counter', () {
    final counter = Counter();
    test('Value should start at 0', () {
      expect(counter.value, 0);
    });

    test('Counter value should be incremented', () {
      counter.increment();
      expect(counter.value, 1);
    });

    test('Value should be decremented', () {
      counter.decrement();
      expect(counter.value, 0);
    });
  });

  group('fetchAlbum', () {
    test('Returns a Album if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get('https://jsonplaceholder.typicode.com/albums/1')).thenAnswer((_) async => http.Response('{"Title": "Testando só tiozão"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/albums/1')).thenAnswer((_) async => http.Response('Not found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });

  group('testing widgets', () {
    final String title = 'Começou';
    final String message = 'Hello World';
    testWidgets('MyWidget has a title and message', (WidgetTester tester) async {
      await tester.pumpWidget(WidgetForTest(title: title, message: message));

      final titleFinder = find.text(title);
      final messageFinder = find.text(message);

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
    });

    testWidgets('should find a container with a USB by its key', (WidgetTester tester) async {
      final testKey = Key('containerWithUSB');

      await tester.pumpWidget(WidgetForTest(
        title: title,
        message: message,
      ));

      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets('should find a container with a USB as child of a Column widget', (WidgetTester tester) async {
      await tester.pumpWidget(WidgetForTest(
        title: title,
        message: message,
      ));

      expect(
        find.byWidgetPredicate((widget) {
          return widget is Container && widget.key == ValueKey('containerWithUSB');
        }, description: ''),
        findsOneWidget,
      );
    });
  });

  group('User Interaction', () {
    testWidgets('Add and remove a todo', (WidgetTester tester) async {
      await tester.pumpWidget(UserInteraction());

      await tester.enterText(find.byType(TextFormField), 'hi');
      await tester.tap(find.byType(FloatingActionButton));

      await tester.pump();

      expect(find.text('hi'), findsOneWidget);

      await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(find.text('hi'), findsNothing);
    });
  });
}
