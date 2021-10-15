import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/widgets/cafe_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../database.dart';

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
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              width: 230,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CafeInfo(cafe: cafes[idx]),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 90,
              width: 200,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(223, 240, 245, 0.3),
              ),
              child: Text(
                cafes[idx].name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        );
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
