import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/table.dart' as t;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CafeAdmin extends StatefulWidget {
  final Cafe cafe;
  const CafeAdmin({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeAdminState createState() => _CafeAdminState();
}

class _CafeAdminState extends State<CafeAdmin> {
  int dropdownValue = 1;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

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
    Cafe cafe = widget.cafe;
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
        title: const Text('Cafe Admin'),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      DropdownButton(
                        value: dropdownValue,
                        onChanged: (int? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: [1, 2, 3, 4, 5, 6]
                            .map((val) => DropdownMenuItem(
                                  child: Text(val.toString()),
                                  value: val,
                                ))
                            .toList(),
                      ),
                      ElevatedButton(
                        child: const Text('Add Table'),
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
                  ElevatedButton(
                    child: const Text('Sign Out'),
                    onPressed: () {
                      _signOut();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 6 / 7,
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
                children: cafe.tables.asMap().entries.map<Widget>((entry) {
                  int idx = entry.key;
                  t.Table table = entry.value;
                  return Stack(
                    children: [
                      Card(
                        color: Colors.lightGreen[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Table $idx"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.people),
                                Text(table.size.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Delete Table $idx?'),
                              content: const Text(
                                  'Deleting this table will delete all of the associated reservations as well!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    cafe.tables.removeAt(idx);
                                    Database.updateCafe(cafe: cafe);
                                    setState(() {
                                      cafe;
                                    });
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                          icon: const Icon(Icons.remove),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
