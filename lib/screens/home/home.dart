import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_firebase/models/brew.dart';
import 'package:hello_firebase/screens/home/brew_list.dart';
import 'package:hello_firebase/screens/home/settings_form.dart';
import 'package:hello_firebase/services/auth.dart';
import 'package:hello_firebase/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Preferences'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async => await _auth.signOut()),
            IconButton(icon: Icon(Icons.settings), onPressed: () => _showSettingPanel())
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
          ),
          child: BrewList(),
        ),
      ),
    );
  }
}
