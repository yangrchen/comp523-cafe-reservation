import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/widgets/cafe_large_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CafeList extends StatefulWidget {
  const CafeList({Key? key}) : super(key: key);

  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> {
  Widget _buildCafeList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
    if (snap.hasError) {
      return const Text('Something went wrong');
    }

    if (snap.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    final docs = snap.data!.docs;
    final cafes = docs.map((doc) => Cafe.fromDoc(doc)).toList();

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      addRepaintBoundaries: false,
      itemCount: cafes.length,
      itemBuilder: (BuildContext context, int idx) {
        return CafeLargeTile(cafe: cafes[idx]);
      },
      separatorBuilder: (BuildContext context, int idx) {
        return const SizedBox(width: 20);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: StreamBuilder<QuerySnapshot>(
        stream: Database.readCafes(),
        builder: _buildCafeList,
      ),
    );
  }
}
