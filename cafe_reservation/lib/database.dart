import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Database {
  static String? userUid;

  static Stream<QuerySnapshot> readCafes() {
    CollectionReference notesItemCollection = _firestore.collection('cafes');

    return notesItemCollection.orderBy('name').snapshots();
  }

  static Future<void> updateCafe({
    required String name,
    required String address,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firestore.collection('cafes').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "address": address,
    };
    await documentReferencer
        .update(data)
        .whenComplete(() => log("Note item updated in the database"))
        .catchError((e) => log(e));
  }

  static Future<void> addItem({
    required String name,
    required String address,
  }) async {
    DocumentReference documentReferencer = _firestore.collection('cafes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "address": address,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => log("Note item added to the database"))
        .catchError((e) => log(e));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _firestore.collection('cafes').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => log('Note item deleted from the database'))
        .catchError((e) => log(e));
  }
  // static Future<void> addItem({
  //   required String title,
  //   required String description,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('items').doc();

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "description": description,
  //   };

  //   await documentReferencer
  //       .set(data)
  //       .whenComplete(() => print("Note item added to the database"))
  //       .catchError((e) => print(e));
  // }

  // static Future<void> updateItem({
  //   required String title,
  //   required String description,
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('items').doc(docId);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "title": title,
  //     "description": description,
  //   };

  //   await documentReferencer
  //       .update(data)
  //       .whenComplete(() => print("Note item updated in the database"))
  //       .catchError((e) => print(e));
  // }

  // static Future<void> deleteItem({
  //   required String docId,
  // }) async {
  //   DocumentReference documentReferencer =
  //       _mainCollection.doc(userUid).collection('items').doc(docId);

  //   await documentReferencer
  //       .delete()
  //       .whenComplete(() => print('Note item deleted from the database'))
  //       .catchError((e) => print(e));
  // }
}
