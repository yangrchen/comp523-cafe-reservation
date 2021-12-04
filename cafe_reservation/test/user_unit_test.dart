import 'package:cafe_reservation/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
