import 'package:cloud_firestore/cloud_firestore.dart';

import 'cafe.dart';

class Reservation {
  late String userid; //CHANGE TO REFERENCE TO USER OBJECT LATER
  late Cafe cafe;
  late List<int> tables;
  late int size;
  late String date;
  late String startTime;
  late String endTime;

  Reservation(this.userid, this.cafe, this.tables, this.size, this.date,
      this.startTime, this.endTime);

  Reservation.fromDoc(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    userid = data['userid'];
    cafe = data['cafe'];
    tables = data['tables'];
    size = data['size'];
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
  }
}
