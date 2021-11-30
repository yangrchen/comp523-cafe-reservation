import 'package:cafe_reservation/database.dart';
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
  bool _isRegistering = false;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> _registerWithEmail(String email, String password) async {
    UserCredential userCred = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCred.user!;
    await Database.addUserWithID(user: user);
  }

  void _catchFirebaseAuthError(FirebaseAuthException e) {
    String errorToShow = '';
    switch (e.code) {
      case 'user-not-found':
        errorToShow = ('No user found for that email');
        break;
      case 'invalid-email':
        errorToShow = 'Email address is not valid';
        break;
      case 'wrong-password':
        errorToShow = 'Invalid password';
        break;
      case 'email-already-in-use':
        errorToShow = 'Email already in use';
        break;
      case 'weak-password':
        errorToShow = 'Password is not strong enough';
        break;
      default:
        errorToShow = e.code.toString();
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorToShow),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
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
                hintText: 'Email',
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
            Stack(
              children: <Widget>[
                TextFormField(
                  controller: passwordController,
                  obscureText: _passwordHidden,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    helperText: _isRegistering
                        ? 'Passwords should container a combination of letters and numbers and be at least 5 characters long.'
                        : '',
                    helperMaxLines: 2,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: IconButton(
                    onPressed: () => setState(() {
                      _passwordHidden = !_passwordHidden;
                    }),
                    icon: _passwordHidden
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ],
            ),
            if (_isRegistering) ...[
              const SizedBox(height: 25.0),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: _passwordHidden,
                decoration: const InputDecoration(
                  hintText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
            Expanded(
              child: Align(
                alignment: _isRegistering
                    ? const FractionalOffset(0.5, 0.935)
                    : const FractionalOffset(0.5, 0.95),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        _isRegistering
                            ? await _registerWithEmail(
                                userController.text, passwordController.text)
                            : await _signInWithEmail(
                                userController.text, passwordController.text);
                      } on FirebaseAuthException catch (e) {
                        _catchFirebaseAuthError(e);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 15.0),
                    child: Text(
                      _isRegistering ? 'Register' : 'Log In',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_isRegistering
                    ? "Already have an account?"
                    : "Don't have an account?"),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRegistering = !_isRegistering;
                    });
                  },
                  child: _isRegistering
                      ? const Text('Login',
                          style: TextStyle(fontWeight: FontWeight.bold))
                      : const Text('Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}
