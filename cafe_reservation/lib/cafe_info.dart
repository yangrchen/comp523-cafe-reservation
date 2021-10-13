import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'database.dart';
import 'models/cafe.dart';

class CafeInfo extends StatefulWidget {
  const CafeInfo({Key? key, required this.cafe}) : super(key: key);

  final Cafe cafe;

  @override
  _CafeInfoState createState() => _CafeInfoState();
}

class _CafeInfoState extends State<CafeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cafe.name),
      ),
    );
  }
}
