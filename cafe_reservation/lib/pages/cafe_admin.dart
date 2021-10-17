import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/table.dart' as t;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CafeAdmin extends StatefulWidget {
  const CafeAdmin({Key? key}) : super(key: key);

  @override
  _CafeAdminState createState() => _CafeAdminState();
}

class _CafeAdminState extends State<CafeAdmin> {
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    String title = 'Cafe Admin';
    Map<String, bool> times = {
      '8': true,
      '9': true,
      '10': true,
      '11': true,
      '12': true,
      '13': true,
      '14': true,
      '15': true,
    };
    Map<String, Map<String, bool>> dates = {};
    var f = DateFormat('yyyy-MM-dd');
    var now = DateTime.now();
    for (int i = 0; i < 31; i++) {
      dates[f.format(now.add(Duration(days: i)))] = times;
    }
    Future<Cafe> cafe = Database.readCafe(docId: '6Gd6yngqVNG6OKyLcEN0');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<Cafe>(
        future: cafe,
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (!snap.hasData) {
            return CircularProgressIndicator();
          }
          Cafe cafe = snap.data;
          return Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: dropdownValue,
                        onChanged: (int? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: [1, 2, 3, 4, 5, 6]
                            .map((num) => DropdownMenuItem(
                                  child: Text(num.toString()),
                                  value: num,
                                ))
                            .toList(),
                      ),
                      ElevatedButton(
                        child: Text('Click Here'),
                        onPressed: () {
                          cafe.tables.add(t.Table(dropdownValue, dates));
                          Database.updateCafe(cafe: cafe);
                          setState(() {
                            cafe;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Text(
                    cafe
                        .checkAvailability(DateTime.now(), 4)
                        .toString(), //FOR TESTING
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: Text(cafe.tables.toString()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
