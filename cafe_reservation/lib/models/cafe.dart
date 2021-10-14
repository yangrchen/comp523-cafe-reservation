import 'package:cloud_firestore/cloud_firestore.dart';

import 'table.dart';

class Cafe {
  late String name;
  late String address;
  late String id;
  // late List<Table> tables;

  Cafe(this.name, this.address, this.id);
  Cafe.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    address = data['address'];
    // tables = data['tables'].map((table) => Table.fromMap(table));
    id = doc.id;
  }
}
