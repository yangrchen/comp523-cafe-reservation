import 'dart:developer';

class Table {
  late int size;
  late Map<String, Map<String, bool>> dates;
  late int id;
  Table(this.id, this.size, this.dates);

  Table.fromMap(Map<String, dynamic> map) {
    size = map['size'] ?? 0;
    id = map['id'] ?? -1;
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
      'id': id,
    };
  }

  @override
  toString() {
    return 'Table ' +
        id.toString() +
        ' of size ' +
        size.toString() +
        ' with ' +
        dates.length.toString() +
        ' dates.';
  }
}
/*
Table
size
dates Map<datetime, Map<timeslot, boolean>>
*/
