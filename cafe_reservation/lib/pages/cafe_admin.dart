import 'dart:developer';

import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/table.dart' as t;
import 'package:cafe_reservation/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CafeAdmin extends StatefulWidget {
  Cafe cafe;
  CafeAdmin({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeAdminState createState() => _CafeAdminState();
}

class _CafeAdminState extends State<CafeAdmin> {
  int dropdownValue = 1;

  List<Widget> generateButtons(cafe) {
    List<ElevatedButton> availList = [];
    cafe.checkAvailability(DateTime.now(), 4).forEach((key, value) {
      availList.add(
        ElevatedButton(
          child: Text(key),
          onPressed: () {},
        ),
      );
    });
    return availList;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    log(widget.cafe.name);
    Cafe cafe = widget.cafe;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(25),
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
                  child: const Text('Click Here'),
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
          GridView.count(
            shrinkWrap: true,
            childAspectRatio: (4 / 2),
            crossAxisSpacing: 30,

            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 3,
            mainAxisSpacing: 60,
            // Generate 100 widgets that display their index in the List.
            children: generateButtons(cafe),
          ),
          Container(
            margin: const EdgeInsets.all(25),
            child: Text(cafe.tables.toString()),
          ),
        ],
      ),
    );
  }
}
