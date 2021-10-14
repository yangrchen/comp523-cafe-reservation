class Table {
  late int size;
  late Map<String, Map<String, bool>> dates;
  Table(this.size, this.dates);

  Table.fromMap(Map<String, dynamic> map) {
    size = map['sizes'];
    dates = map['dates'];
  }
}
/*
Table
size
dates Map<datetime, Map<timeslot, boolean>>
*/