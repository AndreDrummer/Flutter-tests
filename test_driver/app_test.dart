import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Adding and remove a todo from the list: ', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings used for the Widgets that are involved in this tests..

    final String todoName = 'Cagar';

    final textFormField = find.byValueKey('enterText');
    final addButton = find.byValueKey('floating');
    final dissmissible = find.byValueKey('$todoName\0');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) driver.close();
    });

    test('verify if exist a Field to input text', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(textFormField, timeout: Duration(seconds: 1));
      });
    });

    test('verify if exist a button to perform action', () async {
      await driver.runUnsynchronized(() async {
        await driver.waitFor(addButton, timeout: Duration(seconds: 1));
      });
    });

    test('enter text to textFormField', () async {
      await driver.tap(textFormField);
      await driver.enterText(todoName);
      await driver.waitFor(find.text(todoName), timeout: Duration(seconds: 1));
    });

    test('press button to add todo to the list', () async {
      await driver.tap(addButton);
      await driver.waitFor(dissmissible);
    });

    test('verify if exist a TODO list was created', () async {
      await driver.waitFor(dissmissible, timeout: Duration(seconds: 1));
    });

    test('remove todo from the list', () async {
      await driver.scroll(dissmissible, -500, 0, Duration(milliseconds: 500));
    });

    test('verify if the todo item were removed', () async {
      await driver.waitForAbsent(find.text(todoName), timeout: Duration(seconds: 3));
    });
  });
}
