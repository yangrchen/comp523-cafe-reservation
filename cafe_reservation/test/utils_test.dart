import 'package:cafe_reservation/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Create App Color', () {
    MaterialColor c = Utils.createMaterialColor(const Color(0xFFA0C8ED));
    expect(c.runtimeType, MaterialColor);
  });
  test('Default Dict Implementation', () {
    Defaultdict<String, int> r = Defaultdict<String, int>(() => 0);
    r['a'] += 1;
    expect(r['a'], 1);
    r.clear();
    expect(r['a'], 0);
    r['b'] += 5;
    expect(r.keys, ['a', 'b']);
    r.remove('b');
    expect(r['b'], 0);
  });
}
