// import 'package:EMMA/pages/sign_in.dart';
// import 'package:EMMA/pages/Organiser/eventDetails.dart';
import 'package:EMMA/pages/Organiser/mainpage.dart';
import 'package:EMMA/providers/event_provider.dart';
// import 'package:EMMA/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        title: 'EMMA',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainpageOrganizer(),
      ),
    );
  }
}


