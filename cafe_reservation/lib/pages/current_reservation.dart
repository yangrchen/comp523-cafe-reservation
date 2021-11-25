import 'dart:developer';

import 'package:cafe_reservation/database.dart';
import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/models/reservation.dart';
import 'package:cafe_reservation/models/user.dart';
import 'package:cafe_reservation/widgets/cafe_info_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class CurrentReservationPage extends HookWidget {
  const CurrentReservationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final _reservationMemo =
        useMemoized(() => Database.readReservation(userid: user.uid));
    final _reservation = useFuture(_reservationMemo);
    return CafeInfoTemplate(
      children: <Widget>[
        Text(
          _reservation.hasData
              ? _reservation.data!.cafe.name
              : 'No Reservation',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          _reservation.hasData
              ? _reservation.data!.cafe.address
              : 'No address found.',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 100),
        _buildReservationInfo(context,
            reservation: _reservation.data as Reservation),
      ],
    );
  }

  Widget _buildReservationInfo(BuildContext context,
      {required Reservation reservation}) {
    return Column(children: <Widget>[
      Text(reservation.toString()),
    ]);
  }
}
