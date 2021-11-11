import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';

class CurrentReservationPage extends StatefulWidget {
  final Cafe? cafe;
  const CurrentReservationPage({Key? key, this.cafe}) : super(key: key);

  @override
  _CurrentReservationPageState createState() => _CurrentReservationPageState();
}

class _CurrentReservationPageState extends State<CurrentReservationPage> {
  @override
  Widget build(BuildContext context) {
    return CafeInfoTemplate(
      children: <Widget>[
        Text(
          widget.cafe?.name ?? 'No Reservation',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          widget.cafe?.address ?? 'No address found.',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 100),
        widget.cafe != null
            ? _buildReservationInfo(context, widget.cafe)
            : Container(),
      ],
    );
  }

  Widget _buildReservationInfo(BuildContext context, Cafe? cafe) {
    return Row(
      children: <Widget>[
        Icon(Icons.check),
        Icon(Icons.cancel),
      ],
    );
  }
}
