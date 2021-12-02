import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/reservation.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:cafe_reservation/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Cafe c = Cafe('hello', '123 hi st', 'cafid');
  String userid = 'user1';
  test('User constructor', () {
    User u = User('user1', 'user@gmail', false);
    expect(u.uid, 'user1');
    expect(u.email, 'user@gmail');
    expect(u.isAdmin, false);
  });

  test('User blank constructor', () {
    User u = User.blank();
    expect(u.uid, '');
    expect(u.email, '');
    expect(u.isAdmin, false);
  });
}
