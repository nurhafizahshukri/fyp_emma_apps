import 'package:EMMA/Comman_widget/Flat_button.dart';
import 'package:EMMA/Comman_widget/Submit_button.dart';
import 'package:EMMA/pages/signup/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:EMMA/services/authservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
  
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
                    bottomLeft: Radius.circular(95),
                    bottomRight: Radius.circular(0))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Expanded(
                  //     child: Container(
                  //   height: double.infinity,
                  //   width: 100,
                  // )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset(
                        "assets/images/logo_white.png",
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Hello",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                  color: Colors.black),
            ),
          ),
          Container(
            child: Text(
              "Sign in to your account",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Form(
            key: _formKey,
            child: FocusScope(
              node: _node,
              child: Container(
                // color: Colors.black,
                margin: EdgeInsets.fromLTRB(40, 25, 40, 0),
                // height: 450,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onEditingComplete: _node.nextFocus,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,

                          // ignore: missing_return
                          validator: (input) {
                            // if (input.isEmpty || !input.contains('@')) {
                            //   return 'Invalid email!';
                            // }
                            if (input.isEmpty) {
                                return 'Please type an email';
                                } else if (input.isNotEmpty) {
                                bool mobileValid =
                                RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(input);
                                return mobileValid ? null : "Invalid email";
                                }
                                return null;
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              hintText: 'email@address.com',
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(right: 7.0, left: 17.0),
                                  child: Container(
                                      height: 25,
                                      width: 25,
                                      child: new Image.asset(
                                        "assets/images/email_icon.png",
                                        height: 25.0,
                                        width: 25.0,
                                      ))),
                              labelText: 'Email Address',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onEditingComplete: _node.nextFocus,
                          autofocus: false,
                          // ignore: missing_return
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Your password is weak';
                            }
                          },
                          onSaved: (input) => _password = input,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.only(right: 7.0, left: 17.0),
                                  child: Container(
                                      height: 25,
                                      width: 25,
                                      child: new Image.asset(
                                        "assets/images/password_icon.png",
                                        height: 25.0,
                                        width: 25.0,
                                      ))),
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
                        text: 'Sign in'.toUpperCase(),
                        onPressed: signIn),
                    SizedBox(height: 15),
                    ButtonTheme(
                        minWidth: 338.0,
                        height: 40.0,
                        child: Flatbutton(
                          icon: Icon(Icons.verified_user, color:  Colors.red,),
                          colortext: Colors.red,
                          text: "Create a new account",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                    ));
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print("$_email");
      AuthService().signIn(_email, _password, context);
    }
  }
}
