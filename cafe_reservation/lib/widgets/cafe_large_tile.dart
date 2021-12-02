import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/pages/cafe_info.dart';
import 'package:flutter/material.dart';

class CafeLargeTile extends StatelessWidget {
  const CafeLargeTile({Key? key, required this.cafe, required this.index})
      : super(key: key);

  final Cafe cafe;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Container(
          height: 350,
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
                    builder: (context) => CafeInfo(
                      cafe: cafe,
                      imageIdx: index,
                    ),
                  ),
                );
              },
              child: Stack(children: [
                Container(
                    height: 200,
                    width: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (index < 3)
                              ? AssetImage('assets/images/img$index.jpeg')
                              : const AssetImage('assets/images/img3.jpeg'),
                          fit: BoxFit.cover),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CafeInfo(
                              cafe: cafe,
                              imageIdx: index,
                            ),
                          ),
                        );
                      },
                    ))
              ]),
            ),
          ),
        ),
        Container(
          height: 90,
          width: 200,
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(223, 240, 245, 0.3),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CafeInfo(
                    cafe: cafe,
                    imageIdx: index,
                  ),
                ),
              );
            },
            child: Text(
              cafe.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
