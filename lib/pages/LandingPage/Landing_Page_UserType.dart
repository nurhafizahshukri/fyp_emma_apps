import 'package:EMMA/pages/Organiser/mainpage.dart';
import 'package:EMMA/pages/Participants/Participants_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      User user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .snapshots(),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> snapshotuser) {
                  //signOut()
                  if (snapshotuser.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshotuser.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)); 
              }
                  return checkRole(snapshotuser.data);
                });
  }
  checkRole(DocumentSnapshot snapshot) {
    
    if (snapshot.get("role").toString() == "organizer")
      return MainpageOrganizer();
    else
      return MainpageParticipant();
  }
}