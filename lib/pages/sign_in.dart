import 'package:EMMA/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In')
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget> [
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              )
            ),
            TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return 'Your password is weak';
                }
              },
              onSaved: (input) => _password = input,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password'
              )
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            ),
          ],
        ),),
    );
  }

Future <void> signIn() async {
  final formState = _formKey.currentState;
  if(formState.validate()){
    formState.save();
    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(user: user)));
    }catch(e) {
      print(e.message);
    }
  }
}

}

