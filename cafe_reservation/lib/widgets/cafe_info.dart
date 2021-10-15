import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:flutter/material.dart';

class CafeInfo extends StatefulWidget {
  const CafeInfo({Key? key, required this.cafe}) : super(key: key);

  final Cafe cafe;
  @override
  _CafeInfoState createState() => _CafeInfoState();
}

class _CafeInfoState extends State<CafeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }
}
