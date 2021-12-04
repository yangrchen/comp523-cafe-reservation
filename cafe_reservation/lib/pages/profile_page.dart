import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_reservation/models/user.dart' as u;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    u.User user = Provider.of<u.User>(context);
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(user.email.toString(),
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () async {
              await _signOut();
            },
            child: const Text('Sign out'),
          )
        ],
      ),
    );
  }
}
