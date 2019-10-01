import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Flutter Api Search App', () {
    final searchButton = find.byValueKey('searchButton');

    //TODO: Click search button, check icon change

    //TODO: Check for search bar

    final searchBar = find.byValueKey('searchBar');

    //TODO: Type 'iphone' into search bar

    //TODO: Check for listView

    final listView = find.byValueKey('listView');

    //TODO: Check for firstListTile

    final firstlistTile = find.byValueKey('listTile#1');

    //TODO: Click listTile

    //TODO: Check for correct items on page

    final itemTitleText = find.byValueKey('itemTitleText');
    final itemValueText = find.byValueKey('itemValueText');
    final itemCurrencyText = find.byValueKey('itemCurrencyText');
    final itemConditionText = find.byValueKey('itemConditionText');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('user can search', () async {
      await driver.tap(searchButton);

      await driver.tap(searchBar);

      await driver.enterText('iphone');

      expect(await driver.getText(firstlistTile), 'New Apple iPhone 6S - 16GB 64GB GSM \"Factory Unlocked\" Smartphone All Colors');
    });
  });
}