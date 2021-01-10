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
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 250),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red[700],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35),bottomRight: Radius.circular(35))
            ),
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("HELLO",style: TextStyle(fontSize: 30,color: Colors.white),),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: FocusScope(
          node: _node,
          child: Container(
            // color: Colors.black,
            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
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
                    child: RaisedButton(
                      onPressed: signIn,
                      color: Colors.red[600],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.red[600])
                      ),
                      child: Text('Sign in'.toUpperCase(), style: TextStyle(fontSize: 20)),
                    ),
                ),
                SizedBox(height: 15),
                ButtonTheme(
                    minWidth: 338.0,
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
                      },
                      color: Colors.white,
                      textColor: Colors.red[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.red[600])
                      ),
                      child: Text('Sign up'.toUpperCase(), style: TextStyle(fontSize: 20)),
                    ),
                ),
              ],
            ),
          ),
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

