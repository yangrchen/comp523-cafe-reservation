import 'package:cafe_reservation/models/table.dart' as t;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Table constructor', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var tab = t.Table(5, dates);
    expect(tab.size, 5);
    expect(tab.dates, {
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
    var tab = t.Table.fromMap(m);
    expect(tab.size, 5);
    expect(tab.dates, {
      'a': {'b': true}
    });
  });
  test('Table to Map', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var tab = t.Table(5, dates);
    var tid = tab.tid;
    expect(tab.toMap(), {
      'size': 5,
      'dates': {
        'a': {'b': true}
      },
      'tid': tid,
    });
  });
  test('Table to String', () {
    Map<String, Map<String, bool>> dates = {
      'a': {'b': true}
    };
    var tab = t.Table(5, dates);
    expect(tab.toString(), 'Table of size 5 with 1 dates.');
  });
}
