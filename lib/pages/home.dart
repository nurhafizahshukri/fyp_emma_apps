import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  
  const Home({
    Key key, 
    @required this.user
    }) : super(key: key);

  final UserCredential user;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home ${user.user.email}'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          else if (snapshot.hasData) {
            return checkRole(snapshot.data);
          }
          return LinearProgressIndicator();
        },
      )
    );
  }

  // ignore: missing_return
  Center checkRole(DocumentSnapshot snapshot){
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    if (snapshot.data()['role'] == 'organizer'){
      return organizerPage(snapshot);
    }
    if (snapshot.data()['role'] == 'public'){
      return userPage(snapshot);
    }
  }

  Center organizerPage(DocumentSnapshot snapshot){
    return Center(child: Text(snapshot.data()['role'] + 'PAGE'),);
  }
  Center userPage(DocumentSnapshot snapshot){
    return Center(child: Text(snapshot.data()['role'] + 'PAGE'),);
  }
}