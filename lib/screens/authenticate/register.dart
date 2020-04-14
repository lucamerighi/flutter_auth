import 'package:flutter/material.dart';
import 'package:hello_firebase/screens/shared/constants.dart';
import 'package:hello_firebase/screens/shared/loading.dart';
import 'package:hello_firebase/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                title: Text(
                  'Sign up',
                ),
                actions: <Widget>[
                  FlatButton.icon(
                    onPressed: () => widget.toggleView(),
                    icon: Icon(Icons.person),
                    label: Text('Sign in'),
                  )
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: TextInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value.length < 6 ? 'Password must be at least 6 long' : null,
                      onChanged: (value) {
                        setState(() => password = value);
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.red[400],
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = 'please supply a valid email';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    Text(error)
                  ],
                ),
              ),
            ),
          );
  }
}
