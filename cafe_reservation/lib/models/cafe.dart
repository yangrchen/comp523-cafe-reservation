import 'package:cloud_firestore/cloud_firestore.dart';

class Cafe {
  late String name;
  late String address;
  late String id;

  Cafe(this.name, this.address, this.id);
  Cafe.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    name = data['name'];
    address = data['address'];
    id = doc.id;
  }
}
