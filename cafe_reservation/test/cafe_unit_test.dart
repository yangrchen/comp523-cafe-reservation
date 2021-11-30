import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:flutter_test/flutter_test.dart';

void main() {
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
  test('Cafe constructor', () {
    Cafe c = Cafe('hello', '123 hi st', 'cafid');
    expect(c.name, 'hello');
    expect(c.address, '123 hi st');
    expect(c.id, 'cafid');
  });
  test('Cafe Check Availability', () {
    Cafe c = Cafe('hello', '123 hi st', 'cafid');
    c.tables = tables;
    DateTime d = DateTime(2021, 11, 18);
    Map<String, List<T.Table>> avails = c.checkAvailability(d, 3);
    expect(avails, {
      '1': [t3],
      '2': [t3],
      '3': [t2, t3]
    });
    Map<String, List<T.Table>> avail2 = c.checkAvailability(d, 5);
    expect(avail2, {});
    Map<String, List<T.Table>> avail3 = c.checkAvailability(d, 2);
    expect(avail3, {
      '1': [t1, t3],
      '2': [t3],
      '3': [t1, t2, t3]
    });
    DateTime d2 = DateTime(2021, 11, 19);
    Map<String, List<T.Table>> avail4 = c.checkAvailability(d2, 3);
    expect(avail4, {});
  });
}
