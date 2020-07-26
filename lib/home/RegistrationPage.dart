import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  void storeFirebase(){

  }
  void registerUser() async{
    var authResult;
    print('calling register api with $email and $password');
    try{
      authResult = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        elevation: 5.0,
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              helperText: 'Enter your email',
              hintText: 'Email address',
              icon: Icon(Icons.email),
            ),
            controller: controller,
            onChanged: (value){
              setState(() {
                email = value;
              });
            },
          ),
          TextField(
            obscureText: true,
            controller: controller,
            decoration: InputDecoration(
              helperText: 'Enter your password',
              hintText: 'Password',
              icon: Icon(Icons.vpn_key),
            ),
            onChanged: (value){
              setState(() {
                password = value;
              });
            },
          ),
          RaisedButton(
            onPressed: (){
              registerUser();
              setState(() {
                controller.clear();
                storeFirebase();
              });
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}

