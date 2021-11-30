import 'package:uuid/uuid.dart';

class Table {
  late String tid;
  late int size;
  late Map<String, Map<String, bool>> dates;
  Table(this.size, this.dates) {
    const uuid = Uuid();
    tid = uuid.v4();
  }

  Table.fromMap(Map<String, dynamic> map) {
    size = map['size'];
    tid = map['tid'] ?? '';
    var d = Map<String, dynamic>.from(map['dates']);
    dates = {};
    d.forEach((key, value) {
      dates[key] = Map<String, bool>.from(value);
    });
  }
  toMap() {
    return {
      'size': size,
      'dates': dates,
      'tid': tid,
    };
  }

  @override
  toString() {
    return 'Table of size ' +
        size.toString() +
        ' with ' +
        dates.length.toString() +
        ' dates.';
  }
}
