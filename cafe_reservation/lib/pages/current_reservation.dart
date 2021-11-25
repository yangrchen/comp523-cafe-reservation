import 'dart:developer';

import 'package:cafe_reservation/database.dart';
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
    final textStyle = {
      'light': FontWeight.w200,
    };
    User user = Provider.of<User>(context);
    final _reservationMemo =
        useMemoized(() => Database.readReservation(userid: user.uid));
    final _reservation = useFuture(_reservationMemo);
    return CafeInfoTemplate(
      children: <Widget>[
        Text(
          _reservation.data?.cafe.name ?? 'No Reservation',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          _reservation.data?.cafe.address ?? 'No address found.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: textStyle['light'],
          ),
        ),
        if (_reservation.hasData) ...[
          const SizedBox(height: 5.0),
          Text(
            '${_reservation.data!.startTime}:00 - ${_reservation.data!.endTime}:00',
            style: TextStyle(fontWeight: textStyle['light']),
          ),
          const SizedBox(height: 5.0),
          Text(
            _reservation.data!.size == 1
                ? '${_reservation.data!.size} Seat'
                : '${_reservation.data!.size} Seats',
            style: TextStyle(fontWeight: textStyle['light']),
          ),
        ],
        const SizedBox(height: 120.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: IconButton(
                onPressed: () {
                  log('testing');
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                iconSize: 50.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF5EC7F8),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
            ),
            const SizedBox(width: 120.0),
            Container(
                child: IconButton(
                  onPressed: () {
                    Database.deleteReservation(userid: user.uid);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF5EC7F8),
                  ),
                  iconSize: 50.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF5EC7F8),
                    width: 2.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                )),
          ],
        )
      ],
    );
  }
}
