  
//IMPORT FROM API
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//IMPORT FROM FILE
import 'package:EMMA/pages/LandingPage/Landing_Page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LandingPage(),
    );
  }
}
