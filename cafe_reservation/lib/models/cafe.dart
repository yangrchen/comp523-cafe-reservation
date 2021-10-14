import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

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
}
