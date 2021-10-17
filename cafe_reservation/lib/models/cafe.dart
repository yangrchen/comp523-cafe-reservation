import 'package:cafe_reservation/models/reservation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../utils.dart';
import 'table.dart';

class Cafe {
  late String name;
  late String address;
  late String id;
  late List tables;

  Cafe(this.name, this.address, this.id);
  Cafe.fromDoc(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    address = data['address'];
    tables =
        data['tables']?.map((table) => Table.fromMap(table)).toList() ?? [];
    id = doc.id;
  }

  Map<String, List<Table>> checkAvailability(DateTime date, int partySize) {
    DateFormat f = DateFormat('yyyy-MM-dd');
    String dateString = f.format(date);

    Defaultdict<String, List<Table>> r =
        Defaultdict<String, List<Table>>(() => []);
    for (Table table in tables) {
      if (table.size < partySize) continue;

      Map<String, bool> times = table.dates[dateString]!;
      times.forEach((time, isAvailable) {
        if (isAvailable) r[time].add(table);
      });
    }

    return r;
  }

  Reservation createReservation(
      String date, String time, List<Table> tables, int size) {
    tables.sort((a, b) => a.size.compareTo(b.size));
    return Reservation('userid', this, tables.elementAt(0).id, size, date, time,
        (int.parse(time) + 1).toString());
  }
}
