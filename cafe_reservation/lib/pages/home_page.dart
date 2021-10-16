import 'package:cafe_reservation/widgets/cafe_list.dart';
import 'package:cafe_reservation/widgets/cafe_search.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: 100,
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Icon(Icons.search),
          GestureDetector(
            onTap: () {
              // log('tapped');
            },
            child: Text('Search'),
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        centerTitle: true,
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