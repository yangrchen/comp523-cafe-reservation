import 'dart:developer';

import 'package:cafe_reservation/models/user.dart';
import 'package:cafe_reservation/widgets/cafe_list.dart';
import 'package:cafe_reservation/widgets/cafe_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        children: <Widget>[
          const Icon(Icons.search),
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: CafeSearch());
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Cafe Reservation';
    List<Widget> homePageWidgets = <Widget>[
      _buildSearchBar(context),
      const Text(
        'Popular Cafes',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const CafeList(),
      const Text(
        'Cafes',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.only(left: 30, top: 30),
          itemBuilder: (BuildContext context, int idx) {
            return Container(child: homePageWidgets[idx]);
          },
          separatorBuilder: (BuildContext context, int idx) {
            return const SizedBox(height: 35);
          },
          itemCount: homePageWidgets.length),
    );
  }
}
