import 'package:cafe_reservation/pages/home_page.dart';
import 'package:cafe_reservation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home page has search bar', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafe Reservation System',
        home: Scaffold(
          body: HomePage(),
        )));

    final searchFinder = find.text('Search');

    expect(searchFinder, findsOneWidget);
  });
  testWidgets('Home page has Cafe Lists', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafe Reservation System',
        home: Scaffold(
          body: HomePage(),
        )));

    final cafeListFinder = find.text('Popular Cafes');

    expect(cafeListFinder, findsOneWidget);
  });
}
