import 'dart:developer';

import 'package:cafe_reservation/models/cafe.dart';
import 'package:cafe_reservation/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_reservation/pages/cafe_admin.dart';
import 'package:cafe_reservation/pages/current_reservation.dart';
import 'package:cafe_reservation/pages/home_page.dart';
import 'package:cafe_reservation/pages/login_page.dart';
import 'package:cafe_reservation/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_reservation/models/user.dart' as U;

import 'database.dart';

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
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CurrentReservationPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                    if (user == null) {
                      return Provider<U.User>(
                        create: (context) => U.User.blank(),
                        child: _buildMaterialApp(isAuthenticated: false),
                      );
                    } else {
                      return FutureBuilder(
                          future: Database.isUserAdmin(user: user),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasError) {
                              return Scaffold(
                                body: Center(
                                  child: Text("Error: ${snapshot.error}"),
                                ),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data as Map<String, dynamic>;
                              bool isAdmin = data['isAdmin'] == true;
                              return Provider<U.User>(
                                create: (context) => U.User(
                                  user.uid,
                                  user.email!,
                                  isAdmin,
                                ),
                                child: isAdmin
                                    ? _buildAdminMaterialApp(
                                        cafeID: data['cafe'])
                                    : _buildMaterialApp(isAuthenticated: true),
                              );
                            }
                            return const CircularProgressIndicator();
                          });
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
            : const LoginPage(),
        bottomNavigationBar: isAuthenticated
            ? BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book),
                    label: 'My Reservation',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              )
            : null,
      ),
    );
  }

  Widget _buildAdminMaterialApp({required String cafeID}) {
    return FutureBuilder(
        future: Database.readCafe(docId: cafeID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Cafe Admin Portal',
              theme: ThemeData(
                primarySwatch:
                    Utils.createMaterialColor(const Color(0xFFA0C8ED)),
                dividerColor: Colors.grey,
              ),
              home: CafeAdmin(
                cafe: snapshot.data as Cafe,
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
