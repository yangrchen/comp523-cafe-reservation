import 'package:flutter/material.dart';

class CafeAdmin extends StatefulWidget {
  const CafeAdmin({Key? key}) : super(key: key);

  @override
  _CafeAdminState createState() => _CafeAdminState();
}

class _CafeAdminState extends State<CafeAdmin> {
  @override
  Widget build(BuildContext context) {
    const title = 'Cafe Admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
    );
  }
}
