import 'package:flutter/material.dart';
import 'package:hello_firebase/screens/shared/constants.dart';
import 'package:hello_firebase/screens/shared/loading.dart';
import 'package:hello_firebase/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in'),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => widget.toggleView(),
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 6 ? 'Password must be at least 6 long' : null,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'Could not sign in with these credentials';
                              loading = false;
                            });
                          }
                        }
                      },
                      color: Colors.pink[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(error),
                  ],
                ),
              ),
            ),
          );
  }
}
