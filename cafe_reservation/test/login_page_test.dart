import 'package:cafe_reservation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Page has email and password fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cafe Reservation System',
        home: Scaffold(
          body: LoginPage(),
        )));

    final emailFinder = find.text('Email');
    final passFinder = find.text('Password');

    expect(emailFinder, findsOneWidget);
    expect(passFinder, findsOneWidget);
  });
}
