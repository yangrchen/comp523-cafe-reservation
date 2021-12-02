import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/reservation.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:flutter_test/flutter_test.dart';

void main() {
  Cafe c = Cafe('hello', '123 hi st', 'cafid');
  String userid = 'user1';
  test('Reservation constructor', () {
    Reservation r =
        Reservation(userid, c, ['1', '2'], 3, '2021-11-18', '1', '2');
    expect(r.userid, 'user1');
    expect(r.cafe, c);
    expect(r.tables, ['1', '2']);
    expect(r.size, 3);
    expect(r.date, '2021-11-18');
    expect(r.startTime, '1');
    expect(r.endTime, '2');
  });

  test('Reservation to string', () {
    Reservation r =
        Reservation(userid, c, ['1', '2'], 3, '2021-11-18', '1', '2');
    expect(r.toString(),
        'Reservation for user ${userid} with a party of 3 at ${c.name} at 1');
  });
}
