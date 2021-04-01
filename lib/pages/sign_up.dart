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
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0),bottomRight: Radius.circular(95))
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Image.asset(
                            "assets/images/logo_white.png",
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.scaleDown,
                          )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
        Container(
            child: Text(
            "Welcome",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 70,
              color: Colors.black),),),
          Container(
            child: Text(
            "Create a new account",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black),),),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (input) {
                      if(input.isEmpty){
                        return 'Please type an email';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            )
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // ignore: missing_return
                    validator: (input) {
                      if(input.length < 6){
                        return 'Your password is weak';
                      }
                    },
                    onSaved: (input) => _password = input,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                          )
                    )
                  ),
                ),
                SizedBox(height: 20),
                    ButtonTheme(
                        minWidth: 338.0,
                        height: 40.0,
                        child: RaisedButton(
                          onPressed: signUp,
                          color: Colors.red[600],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red[600])
                          ),
                          child: Text('Sign up'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                    ),
                SizedBox(height: 15),
                    ButtonTheme(
                        minWidth: 338.0,
                        height: 40.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
                          },
                          color: Colors.white,
                          textColor: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red[600])
                          ),
                          child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                    ),
              ],
            ),
          ),),
        ]
      ),
    );
}

Future <void> signUp() async {
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