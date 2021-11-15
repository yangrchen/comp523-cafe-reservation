import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_reservation/pages/cafe_admin.dart';
import 'package:cafe_reservation/pages/home_page.dart';
import 'package:cafe_reservation/pages/login_page.dart';
import 'package:cafe_reservation/utils.dart';
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
  int _selectedIndex = 0;
  bool _authenticated = false;
  static const List<Widget> _widgetOptions = <Widget>[HomePage(), CafeAdmin()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeAuthentication(bool isAuthenticated) {
    setState(() {
      _authenticated = isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    User? user = snapshot.data as User?;
                    log("${user}");
                    if (user == null) {
                      return _buildMaterialApp(isAuthenticated: false);
                    } else {
                      return _buildMaterialApp(isAuthenticated: true);
                    }
                  }
                  return const CircularProgressIndicator();
                });
          }
          return const CircularProgressIndicator();
        });
  }

  Widget _buildMaterialApp({required bool isAuthenticated}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Reservation System',
      theme: ThemeData(
        primarySwatch: Utils.createMaterialColor(const Color(0xFFA0C8ED)),
        dividerColor: Colors.grey,
      ),
      home: Scaffold(
        body: isAuthenticated
            ? _widgetOptions.elementAt(_selectedIndex)
            : LoginPage(),
        bottomNavigationBar: isAuthenticated
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.business),
                    label: 'Cafe Admin',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }
}
