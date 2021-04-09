import 'package:EMMA/pages/home.dart';
import 'package:EMMA/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          height: 350,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(95),bottomRight: Radius.circular(0))
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
                          ) ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget> [
          Container(
            child: Text(
            "Hello",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 80,
              color: Colors.black),),),
          Container(
            child: Text(
            "Sign in to your account",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black),),),
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
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onEditingComplete: _node.nextFocus,
                        // ignore: missing_return
                        validator: (input) {
                          if(input.isEmpty || !input.contains('@')){
                            return 'Invalid email!';
                          }
                        },
                        onSaved: (input) => _email = input,
                        decoration: InputDecoration(
                          prefixIcon: Padding(padding: EdgeInsets.only(right: 7.0, left: 17.0),child: new Image.asset(
                              "assets/images/email_icon.png",
                              height: 25.0,
                              width: 25.0,
                          )),
                          labelText: 'Email Address',
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
                        onEditingComplete: _node.nextFocus,
                        autofocus: false,
                        // ignore: missing_return
                        validator: (input) {
                          if(input.length < 6){
                            return 'Your password is weak';
                          }
                        },
                        onSaved: (input) => _password = input,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Padding(padding: EdgeInsets.only(right: 7.0, left: 17.0),child: new Image.asset(
                              "assets/images/password_icon.png",
                              height: 25.0,
                              width: 25.0,
                          )),
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
                        child: ElevatedButton(
                          onPressed: signIn,
                          // color: Colors.red[600],
                          // textColor: Colors.white,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   side: BorderSide(color: Colors.red[600])
                          // ),
                          child: Text('Sign in'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                    ),
                    SizedBox(height: 15),
                    ButtonTheme(
                        minWidth: 338.0,
                        height: 40.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
                          },
                          // color: Colors.white,
                          // textColor: Colors.red[600],
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(25.0),
                          //   side: BorderSide(color: Colors.red[600])
                          // ),
                          child: Text('Create a new account'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                    ),
                  ],
                ),
              ),
            ),),
        ],
      ),
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

