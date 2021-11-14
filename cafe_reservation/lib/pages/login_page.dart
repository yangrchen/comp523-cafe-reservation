import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordHidden = false;

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
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
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
