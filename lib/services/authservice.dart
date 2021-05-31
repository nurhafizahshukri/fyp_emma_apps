import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:EMMA/Pages/LandingPage/Landing_Page.dart';

import 'package:EMMA/Pages/homepage.dart';

import 'package:EMMA/error_handler.dart';


class AuthService {
  //Determine if the user is authenticated.


  //Sign out
  signOut(BuildContext context) {
    print("signout");
    FirebaseAuth.instance.signOut();
    return Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LandingPage(
                              ),
                          fullscreenDialog: true));
  
  }

  //Sign In
  signIn(String email, String password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((val) {
          return Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Home(
                              ),
                          fullscreenDialog: true));
    }).catchError((e) {
      ErrorHandler().errorDialog(context, e);
    });
  }

  //fb signin
  //Signup a new user

  
}
