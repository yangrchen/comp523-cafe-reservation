import 'dart:developer';

import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/reservation.dart';
import 'package:cafe_reservation/models/user.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';
import 'package:cafe_reservation/models/table.dart' as T;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CafeInfo extends StatefulWidget {
  final Cafe cafe;
  const CafeInfo({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeInfoState createState() => _CafeInfoState();
}

class _CafeInfoState extends State<CafeInfo> {
  DateTime _selectedDate = DateTime.now();
  List<int> numPeopleOptions = List<int>.generate(6, (i) => i + 1);
  int _selectedPeople = 1;
  String _selectedTime = '0';
  T.Table? _selectedTable = null;
  Map<String, List<T.Table>> _availableTimes = {};
  @override
  Widget build(BuildContext context) {
    _availableTimes =
        widget.cafe.checkAvailability(_selectedDate, _selectedPeople);
    return CafeInfoTemplate(
      hasBackButton: true,
      children: <Widget>[
        Text(
          widget.cafe.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.cafe.address,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        _buildInput(
          'Number of People',
          child: _buildDropdownButton(
            numPeopleOptions,
          ),
          icon: const Icon(Icons.people),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildInput(
          'Date',
          icon: const Icon(Icons.calendar_today),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Text(
                    '${_selectedDate.toLocal()}'.split(' ')[0],
                  ),
                  onTap: () => _selectDate(context),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildTimeGrid(timemap: _availableTimes),
        const SizedBox(
          height: 15,
        ),
        _buildReserveButton(context, widget.cafe),
      ],
    );
  }

  Widget _buildInput(String title, {required Widget child, Icon? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 5,
        ),
        Stack(
          children: <Widget>[
            Container(
              child: icon,
              padding: const EdgeInsets.only(
                top: 12,
                left: 15,
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.only(left: 60, right: 15),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.0,
                    style: BorderStyle.solid,
                    color: Theme.of(context).dividerColor,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
              ),
              child: child,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdownButton(List<dynamic> items,
      {String type = 'numPeople', bool isExpanded = false}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<dynamic>(
        value: (() {
          switch (type) {
            case 'numPeople':
              {
                return _selectedPeople;
              }
              break;
          }
        }()),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: isExpanded,
        items: items.map<DropdownMenuItem<dynamic>>((dynamic val) {
          return DropdownMenuItem<dynamic>(
            value: val,
            child: Text(val.toString(), key: Key('item-$val')),
          );
        }).toList(),
        onChanged: (dynamic selectedVal) {
          switch (type) {
            case 'numPeople':
              {
                setState(() {
                  _selectedPeople = selectedVal;
                });
              }
              break;

            case '':
              {}
          }
        },
      ),
    );
  }

  Widget _buildTimeGrid({required Map<String, List<T.Table>> timemap}) {
    List<String> times = timemap.keys.toList();
    times.sort();
    return Container(
      alignment: AlignmentDirectional.center,
      child: timemap.isNotEmpty
          ? GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 17,
              childAspectRatio: 2.0,
              children: List.generate(
                timemap.length,
                (i) => _buildTimeButton(times[i], timemap[times[i]]!),
              ),
            )
          : const Text('No times available for selected options.'),
    );
  }

  Widget _buildTimeButton(String time, List<T.Table> tables) {
    tables.sort((a, b) => a.size.compareTo(b.size));
    return ElevatedButton(
      onPressed: () {
        log(tables.toString());
        setState(() {
          _selectedTable = tables[0];
          _selectedTime = time;
        });
      },
      style: time == _selectedTime
          ? ElevatedButton.styleFrom(primary: Colors.blue)
          : null,
      child: SizedBox(
        child: Center(
          child: Text(
            time,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildReserveButton(BuildContext context, Cafe cafe) {
    var user = Provider.of<User>(context);
    var f = DateFormat('yyyy-MM-dd');

    return ElevatedButton(
      onPressed: _selectedTime != '0' && _availableTimes.isNotEmpty
          ? () {
              Reservation newRes = Reservation(
                  user.uid,
                  cafe,
                  [_selectedTable!.tid],
                  _selectedPeople,
                  f.format(_selectedDate),
                  _selectedTime,
                  (int.parse(_selectedTime) + 1).toString());
              // log(_selectedTable.toString());
              // log(user.uid);
              log(newRes.toString());
              Database.addReservation(res: newRes);
            }
          : null,
      child: Container(
        alignment: AlignmentDirectional.center,
        child: const Text(
          'Reserve',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
