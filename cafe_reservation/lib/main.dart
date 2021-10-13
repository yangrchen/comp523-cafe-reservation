import 'dart:developer';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cafe_reservation/database.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Reservation System',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

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

class CafeList extends StatefulWidget {
  const CafeList({Key? key}) : super(key: key);

  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> {
  Widget _buildCafeList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
    if (snap.hasError) {
      return const Text('Something went wrong');
    }

    if (snap.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    final docs = snap.data!.docs;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      addRepaintBoundaries: false,
      itemCount: docs.length,
      itemBuilder: (BuildContext context, int idx) {
        return Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              width: 230,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    log('tapped:$idx');
                    // log(docs[idx].id); USE THIS TO NAVIGATGE TO NEXT PAGE
                  },
                ),
              ),
            ),
            Container(
              height: 90,
              width: 200,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromRGBO(223, 240, 245, 0.3),
              ),
              child: Text(
                docs[idx].get('name'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int idx) {
        return const SizedBox(width: 20);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: StreamBuilder<QuerySnapshot>(
        stream: Database.readCafes(),
        builder: _buildCafeList,
      ),
    );
  }
}
