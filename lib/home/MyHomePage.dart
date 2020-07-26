import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String welcomeText = "";
  bool isLoggedIn = false;

  void navigateToLogin() async{
    isLoggedIn = await Navigator.pushNamed(context, '/login');
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
        title: Text('Need-Aid'),
        elevation: 5.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: isLoggedIn?false:true,
            child: RaisedButton(onPressed: (){
              setState(() {
                navigateToLogin();
              });
            },
            child: Text('Sign In'),
            ),
          ),
          Visibility(
            visible: isLoggedIn?false:true,
            child: RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/registration');
            },
              child: Text('Sign Up'),
            ),
          ),
          Visibility(
            visible: isLoggedIn?true:false,
            child: RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/donation');
            },
              child: Text('Create Donation Post'),
            ),
          ),
          Visibility(
            visible: isLoggedIn?true:false,
            child: RaisedButton(onPressed: (){
              Navigator.pushNamed(context, '/requirement');
            },
              child: Text('Create Requirement Post'),

            ),
          ),
          Visibility(
            visible: isLoggedIn?true:false,
            child: RaisedButton(onPressed: (){
              _auth.signOut();
              setState(() {
                isLoggedIn = false;
              });
            },
              child: Text('Logout'),

            ),
          ),
        ],
      ),
    );
  }
}

