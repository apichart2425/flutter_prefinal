import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/state.dart';

SharedPreferences sharedPreferences;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String data = '';
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> readcontent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      this.data = contents;
      return this.data;
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    readcontent();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      readcontent();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          children: <Widget>[
            ListTile(
              title: Text('Hello ${StateUserLogin.name}'),
              subtitle: Text(
                  'this is my quote "${StateUserLogin.quote != null ? StateUserLogin.quote == '' ? 'No data quote' : data == '' ? StateUserLogin.quote : data : 'No data quote'}"'),
            ),
            RaisedButton(
              child: Text("PROFILE SETUP"),
              onPressed: () {
                Navigator.of(context).pushNamed('/profile');
              },
            ),
            RaisedButton(
              child: Text("MY FRIENDS"),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/friend');
                // Navigator.of(context).pushNamed('/friend');
              },
            ),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () {
                test() async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('username', '');
                  sharedPreferences.setString('password', '');
                }

                test();
                StateUserLogin.userid = null;
                StateUserLogin.name = null;
                StateUserLogin.age = null;
                StateUserLogin.password = null;
                StateUserLogin.quote = null;
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
