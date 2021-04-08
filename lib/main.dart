// import 'package:EMMA/pages/sign_in.dart';
import 'package:EMMA/pages/Organiser/eventDetails.dart';
// import 'package:EMMA/pages/Organiser/mainpage.dart';
// import 'package:EMMA/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMMA',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EventDetails(),
    );
  }
}


