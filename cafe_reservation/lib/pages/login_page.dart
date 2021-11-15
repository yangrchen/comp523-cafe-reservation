import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordHidden = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _signInWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that email');
      } else {
        log(e.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100),
            TextFormField(
              controller: userController,
              decoration: const InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 38.0),
            TextFormField(
              controller: passwordController,
              obscureText: _passwordHidden,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            IconButton(
              onPressed: () => setState(() {
                _passwordHidden = !_passwordHidden;
              }),
              icon: _passwordHidden
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  await _signInWithEmail(
                      userController.text, passwordController.text);
                }
              },
              child: const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
