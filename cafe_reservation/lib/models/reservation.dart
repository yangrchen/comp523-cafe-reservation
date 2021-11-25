import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cafe.dart';

class Reservation extends ChangeNotifier {
  late String userid; //CHANGE TO REFERENCE TO USER OBJECT LATER
  late Cafe cafe;
  late List<String> tables;
  late int size;
  late String date;
  late String startTime;
  late String endTime;

  Reservation(this.userid, this.cafe, this.tables, this.size, this.date,
      this.startTime, this.endTime);

  Reservation.fromDoc(DocumentSnapshot doc, this.cafe) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    userid = data['userid'];
    tables = data['tables'].cast<String>();
    size = data['size'];
    date = data['date'];
    startTime = data['startTime'];
    endTime = data['endTime'];
    notifyListeners();
  }

  static bool deleteReservation(String userid) {
    return false;
  }

  @override
  String toString() {
    return "Reservation for user $userid with a party of $size at ${cafe.name} at $startTime";
  }
}
