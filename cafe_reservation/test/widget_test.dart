// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/pages/cafe_info.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Cafe info widget visibility test; no times',
      (WidgetTester tester) async {
    Cafe testCafe = Cafe('Test Cafe', '3704 Address', 'idx');
    Map<String, Map<String, bool>> dates1 = {
      '2021-11-18': {'1': true, '2': false, '3': true}
    };
    var t1 = T.Table(2, dates1);
    Map<String, Map<String, bool>> dates2 = {
      '2021-11-18': {'1': false, '2': false, '3': true}
    };
    var t2 = T.Table(4, dates2);
    Map<String, Map<String, bool>> dates3 = {
      '2021-11-18': {'1': true, '2': true, '3': true}
    };
    var t3 = T.Table(3, dates3);
    List<T.Table> tables = [t1, t2, t3];
    testCafe.tables = tables;

    await tester.pumpWidget(MaterialApp(home: CafeInfo(cafe: testCafe)));
    final nameFinder = find.text('Test Cafe');
    final addressFinder = find.text('3704 Address');
    final peopleSelection = find.byType(DropdownButton);
    final timesFinder = find.byType(GridView);
    expect(nameFinder, findsOneWidget);
    expect(addressFinder, findsOneWidget);
    expect(peopleSelection, findsOneWidget);
    expect(timesFinder, findsNothing);
  });

  testWidgets('Cafe info widget visibility test; with times',
      (WidgetTester tester) async {
    String dateString = DateTime.now().toString().split(' ')[0];
    Cafe testCafe = Cafe('Test Cafe', '3704 Address', 'idx');
    Map<String, Map<String, bool>> dates1 = {
      dateString: {'1': true, '2': false, '3': true}
    };
    var t1 = T.Table(2, dates1);
    Map<String, Map<String, bool>> dates2 = {
      dateString: {'1': false, '2': false, '3': true}
    };
    var t2 = T.Table(4, dates2);
    Map<String, Map<String, bool>> dates3 = {
      dateString: {'1': true, '2': true, '3': true}
    };
    var t3 = T.Table(3, dates3);
    List<T.Table> tables = [t1, t2, t3];
    testCafe.tables = tables;

    await tester.pumpWidget(MaterialApp(home: CafeInfo(cafe: testCafe)));
    final nameFinder = find.text('Test Cafe');
    final addressFinder = find.text('3704 Address');
    final peopleSelection = find.byType(DropdownButton);
    final timesFinder = find.byType(GridView);
    expect(nameFinder, findsOneWidget);
    expect(addressFinder, findsOneWidget);
    expect(peopleSelection, findsOneWidget);
    expect(timesFinder, findsOneWidget);
  });

  testWidgets('Change dropdown value test', (WidgetTester tester) async {
    String dateString = DateTime.now().toString().split(' ')[0];
    Cafe testCafe = Cafe('Test Cafe', '3704 Address', 'idx');
    Map<String, Map<String, bool>> dates1 = {
      dateString: {'3': true, '4': false, '5': true}
    };
    var t1 = T.Table(2, dates1);
    Map<String, Map<String, bool>> dates2 = {
      dateString: {'3': false, '4': false, '5': true}
    };
    var t2 = T.Table(4, dates2);
    Map<String, Map<String, bool>> dates3 = {
      dateString: {'3': true, '4': true, '5': true}
    };
    var t3 = T.Table(3, dates3);
    List<T.Table> tables = [t1, t2, t3];
    testCafe.tables = tables;

    await tester.pumpWidget(MaterialApp(home: CafeInfo(cafe: testCafe)));
    var dropdown =
        (tester.widget(find.byType(DropdownButton)) as DropdownButton);
    expect(dropdown.value, equals(1));
    await tester.tap(find.byType(DropdownButton));
    await tester.pump();
    await tester.pump(Duration(seconds: 1));

    expect(find.byKey(Key('item-2')).last, findsOneWidget);
  });
}
