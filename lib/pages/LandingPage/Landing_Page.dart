import 'package:EMMA/pages/LandingPage/Landing_Page_UserType.dart';
import 'package:EMMA/pages/Onboard/Onboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Home();            
          } else {
            return Onboard();
          }
        });
  }
  }