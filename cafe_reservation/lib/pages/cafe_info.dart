import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';

class CafeInfo extends StatefulWidget {
  final Cafe cafe;
  const CafeInfo({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeInfoState createState() => _CafeInfoState();
}

class _CafeInfoState extends State<CafeInfo> {
  bool _isButtonEnabled = false;
  List<int> numPeopleOptions = List<int>.generate(5, (i) => i + 1);
  List<String> test = <String>['hello'];
  int selectedPeople = 1;
  @override
  Widget build(BuildContext context) {
    return CafeInfoTemplate(
      children: <Widget>[
        Text(
          widget.cafe.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Address',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        Row(
          children: [
            _buildDropdownButton(numPeopleOptions),
            _buildDropdownButton(test),
          ],
        ),
        Center(
          child: _buildReserveButton(),
        ),
      ],
    );
  }

  Widget _buildDropdownButton(List<dynamic> items) {
    return DropdownButton<dynamic>(
      icon: const Icon(Icons.arrow_drop_down),
      menuMaxHeight: 100.0,
      items: items.map<DropdownMenuItem<dynamic>>((dynamic val) {
        return DropdownMenuItem<dynamic>(
          value: val,
          child: Text(val.toString()),
        );
      }).toList(),
      onChanged: (dynamic selectedVal) => selectedPeople = selectedVal,
    );
  }

  Widget _buildReserveButton() {
    return ElevatedButton(
      onPressed: null,
      child: Text('Reserve'),
    );
  }
}
