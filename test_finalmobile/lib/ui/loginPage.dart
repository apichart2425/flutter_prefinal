import 'package:flutter/material.dart';
import './home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreen();
  }
}

class LoginScreen extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final user_check = TextEditingController();
  final password_check = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 15, 30, 0),
              children: <Widget>[
                Image.asset(
                  "resource/PRIT8616.JPG",
                  height: 200,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "User ID",
                    icon: Icon(Icons.account_box),
                  ),
                  controller: user_check,
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "User ID",
                    icon: Icon(Icons.account_box),
                  ),
                  controller: password_check,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
                RaisedButton(
                  child: Text("LOGIN"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                FlatButton(
                  child: Container(
                    child:
                        Text("register new user", textAlign: TextAlign.right),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  padding: EdgeInsets.only(left: 150.0),
                ),
              ],
            ),
          )),
    );
  }
}
