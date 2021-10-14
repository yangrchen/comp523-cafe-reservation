import 'package:cafe_reservation/widgets/cafe_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const title = 'Test';
    List<Widget> homePageWidgets = <Widget>[
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
