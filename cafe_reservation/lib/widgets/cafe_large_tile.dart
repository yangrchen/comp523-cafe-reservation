import 'package:flutter/material.dart';
class CafeLargeTile extends StatelessWidget {
  const CafeLargeTile({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  Widget build(BuildContext context) {
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
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
}