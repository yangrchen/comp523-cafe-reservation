class Table {
  late int size;
  late Map<String, Map<String, bool>> dates;
  Table(this.size, this.dates);

  Table.fromMap(Map<String, dynamic> map) {
    size = map['size'];
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
/*
Table
size
dates Map<datetime, Map<timeslot, boolean>>
*/
