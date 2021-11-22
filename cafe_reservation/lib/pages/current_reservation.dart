import 'dart:developer';

import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/reservation.dart';
import 'package:cafe_reservation/models/user.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        _buildReservationInfo(context)
      ],
    );
  }

  Widget _buildReservationInfo(BuildContext context) {
    User user = Provider.of<User>(context);
    Database.readReservation(userid: user.uid);
    log('2');
    return FutureBuilder<Reservation>(
        future: Database.readReservation(userid: user.uid),
        builder: (BuildContext context, AsyncSnapshot<Reservation> snap) {
          if (snap.hasError) {
            return const Text('Something went wrong');
          }

          if (snap.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          Reservation currentRes = snap.data!;
          return Text(currentRes.toString());
        });
  }
}
