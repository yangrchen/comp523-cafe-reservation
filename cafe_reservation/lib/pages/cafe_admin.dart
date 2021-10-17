import 'dart:developer';

import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CafeAdmin extends StatefulWidget {
  const CafeAdmin({Key? key}) : super(key: key);

  @override
  _CafeAdminState createState() => _CafeAdminState();
}

class _CafeAdminState extends State<CafeAdmin> {
  int dropdownValue = 1;
  String? currentTables;
  List<Widget> _createTimeButtons(Map<String, List<T.Table>> times) {
    List<Widget> r = [];
    times.forEach((key, value) {
      r.add(ElevatedButton(
          onPressed: () {
            setState(() {
              currentTables = value.toString();
            });
          },
          child: Text(key)));
    });

    return r;
  }

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
          Map<String, List<T.Table>> times =
              cafe.checkAvailability(DateTime.now(), 1);
          return Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                          cafe.tables.add(T.Table(
                              cafe.tables.length, dropdownValue, dates));
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
                  child: Wrap(
                    spacing: 10, children: _createTimeButtons(times),

                    // Text(
                    //   //FOR TESTING
                    //   cafe.checkAvailability(DateTime.now(), 4).toString(),
                    // ),
                  ),
                ),
                if (currentTables != null)
                  Container(
                      margin: EdgeInsets.all(25),
                      child: Text(currentTables.toString())),
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
