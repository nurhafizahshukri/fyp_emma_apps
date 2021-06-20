import 'package:flutter/material.dart';
import 'package:EMMA/Comman_widget/Flat_button.dart';
import 'package:EMMA/Comman_widget/Submit_button.dart';
import 'package:EMMA/Pages/Signin/signin.dart';
import 'package:EMMA/Pages/UserDetails/userdetailsform.dart';
import 'package:EMMA/services/authservice.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(95))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Container(    height: double.infinity,
              width: 100,)),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
              height: MediaQuery.of(context).size.width*0.4,
              width: MediaQuery.of(context).size.width*0.4,
              child: Image.asset(
                "assets/images/logo_white.png",
        
                
              ),
              
            ),
                          ),
            ]
            ),
          ),
        ),
      ),
      body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Welcome",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.black),
              ),
            ),
            Container(
              child: Text(
                "Create a new account",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Please type an email';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ))
                              ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6) {
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
                              ))),
                    ),
                    SizedBox(height: 20),
                    FormSubmitButton(
                        color: Colors.red,
                        colortext: Colors.white,
                        text: 'Sign Up'.toUpperCase(),
                        onPressed: signup),
                    SizedBox(height: 15),
                    ButtonTheme(
                        minWidth: 338.0,
                        height: 40.0,
                        child: Flatbutton(
                          icon: Icon(Icons.verified_user, color:  Colors.red,),
                          colortext: Colors.red,
                          text: "Already have an account",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                    ));
                          },
                        )),
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  Future<void> signup() async {
    final formState = _formKey.currentState;
    formState.save();
    if (formState.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserDetailsForm(email: _email, password: _password),
              fullscreenDialog: true));
    }
  }
}
