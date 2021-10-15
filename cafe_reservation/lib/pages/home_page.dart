import 'package:cafe_reservation/widgets/cafe_list.dart';
import 'package:cafe_reservation/widgets/cafe_search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _searchBar(BuildContext context) {
    return Container(
      width: 100,
      child: Row(
        children: <Widget>[
          Icon(Icons.search),
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: CafeSearch());
            },
            child: Text(
              'Search',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Test';
    List<Widget> homePageWidgets = <Widget>[
      _searchBar(context),
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CafeSearch());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.separated(
          padding: EdgeInsets.only(left: 30, top: 30),
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
