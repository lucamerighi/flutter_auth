import 'package:flutter/material.dart';
import 'package:hello_firebase/screens/shared/colors.dart';
import 'package:hello_firebase/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: AppBar(
        title: Text('App title'),
        backgroundColor: appBarColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async => await _auth.signOut()),
        ],
      ),
    );
  }
}
