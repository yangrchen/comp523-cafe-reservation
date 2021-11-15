import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../utils.dart';
import 'table.dart';

class User {
  late String uid;
  late String email;

  User.blank();

  User(this.uid, this.email);
  
}
