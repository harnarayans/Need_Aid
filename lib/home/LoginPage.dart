import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  void loginUser() async{
    var authResult;
    print('Loggin in with $email and $password');
      authResult = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              try{
                loginUser();
              }catch(e){
                Navigator.pop(context,false);
              }
              Navigator.pop(context,true);
            },
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

