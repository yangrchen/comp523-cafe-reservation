import 'dart:collection';

import 'package:flutter/material.dart';

class Utils {
  static Map<int, Color> color = {
    50: const Color.fromRGBO(153, 186, 221, .1),
    100: const Color.fromRGBO(153, 186, 221, .2),
    200: const Color.fromRGBO(153, 186, 221, .3),
    300: const Color.fromRGBO(153, 186, 221, .4),
    400: const Color.fromRGBO(153, 186, 221, .5),
    500: const Color.fromRGBO(153, 186, 221, .6),
    600: const Color.fromRGBO(153, 186, 221, .7),
    700: const Color.fromRGBO(153, 186, 221, .8),
    800: const Color.fromRGBO(153, 186, 221, .9),
    900: const Color.fromRGBO(153, 186, 221, 1),
  };
  static MaterialColor carolinaBlue = MaterialColor(0xFF99badd, color);
}

class Defaultdict<K, V> extends MapBase<K, V> {
  final Map<K, V> _map = {};
  final V Function() _ifAbsent;

  Defaultdict(this._ifAbsent);

  @override
  V operator [](Object? key) => _map.putIfAbsent(key as K, _ifAbsent);

  @override
  void operator []=(K key, V value) => _map[key] = value;

  @override
  void clear() => _map.clear();

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V? remove(Object? key) => _map.remove(key);
}
