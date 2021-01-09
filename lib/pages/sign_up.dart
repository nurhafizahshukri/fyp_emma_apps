import 'package:EMMA/pages/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up')
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
              onPressed: signUn,
              child: Text('Sign up'),
            ),
          ],
        ),),
    );
}

Future <void> signUn() async {
  final formState = _formKey.currentState;
  if(formState.validate()){
    formState.save();
    try{
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      user.user.sendEmailVerification();
      Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }catch(e) {
      print(e.message);
    }
  }
}
}