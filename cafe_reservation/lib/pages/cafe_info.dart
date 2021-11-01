import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CafeInfo extends StatefulWidget {
  final Cafe cafe;
  const CafeInfo({Key? key, required this.cafe}) : super(key: key);

  @override
  _CafeInfoState createState() => _CafeInfoState();
}

class _CafeInfoState extends State<CafeInfo> {
  bool _isButtonEnabled = false;
  DateTime selectedDate = DateTime.now();
  List<int> numPeopleOptions = List<int>.generate(6, (i) => i + 1);
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
                    '${selectedDate.toLocal()}'.split(' ')[0],
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
        _buildTimeGrid(),
        const SizedBox(
          height: 15,
        ),
        _buildReserveButton(),
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
                return selectedPeople;
              }
              break;
          }
        }()),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: isExpanded,
        items: items.map<DropdownMenuItem<dynamic>>((dynamic val) {
          return DropdownMenuItem<dynamic>(
            value: val,
            child: Text(val.toString()),
          );
        }).toList(),
        onChanged: (dynamic selectedVal) {
          switch (type) {
            case 'numPeople':
              {
                setState(() {
                  selectedPeople = selectedVal;
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

  Widget _buildTimeGrid() {
    return Container(
      alignment: AlignmentDirectional.center,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 17,
        childAspectRatio: 2.0,
        children:
            List.generate(10, (index) => _buildTimeButton(index.toString())),
      ),
    );
  }

  Widget _buildTimeButton(String time) {
    return ElevatedButton(
      onPressed: () {},
      child: SizedBox(
        width: 80,
        child: Text(time),
      ),
    );
  }

  Widget _buildReserveButton() {
    return ElevatedButton(
      onPressed: () {},
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
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
