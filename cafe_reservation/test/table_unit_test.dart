import 'package:cafe_reservation/models/table.dart' as T;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Table constructor', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var t = T.Table(5, dates);
    expect(t.size, 5);
    expect(t.dates, {
      'a': {'b': true}
    });
  });
  test('Table From Map', () {
    Map<String, dynamic> m = {
      'size': 5,
      'dates': {
        'a': {'b': true}
      }
    };
    var t = T.Table.fromMap(m);
    expect(t.size, 5);
    expect(t.dates, {
      'a': {'b': true}
    });
  });
  test('Table to Map', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var t = T.Table(5, dates);
    expect(t.toMap(), {
      'size': 5,
      'dates': {
        'a': {'b': true}
      }
    });
  });
  test('Table to String', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var t = T.Table(5, dates);
    expect(t.toString(), 'Table of size 5 with 1 dates.');
  });
}
