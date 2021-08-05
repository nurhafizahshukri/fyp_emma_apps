import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  //Determine if the user is authenticated.
  
  Future<void> addEvent(
      String eventName,
      DateTime date,
      DateTime endDate,
      String location,
      String eventfee,
      String description,
      String label,
      String reg,
      DateTime regDeadline,
      String picName,
      String contact) async {
    // Call the user's CollectionReference to add a new user_

    User user = FirebaseAuth.instance.currentUser;

    CollectionReference event = FirebaseFirestore.instance.collection('event');
    event
        .add({
          'EventName': eventName, 
          'Date': date,
          'End_Date': endDate,
          'Location': location,
          'Event_Fee': eventfee,
          'Description': description,
          'label': label,
          'Open_Registration': reg,
          'Registration': regDeadline,
          'PIC_Name': picName,
          'PIC_Contact': contact, 
          'Creator_Uid': user.uid,
        })
        .then((value) => {
              
              }
            )
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addParticipant(
      String name,
      String contact,
      String eventuid,
      ) async {
    // Call the user's CollectionReference to add a new user_
User user= FirebaseAuth.instance.currentUser;
    CollectionReference participant =
        FirebaseFirestore.instance.collection('event').doc(eventuid).collection("participant");
        participant.add({
        "userName":name,
        "userContact":contact,
        "user_uid":user.uid,
        "payment":false,
        });
  }
Future<void> updatePayment(
     
      String eventuid,
      String uid,
      ) async {
    // Call the user's CollectionReference to add a new user_
    CollectionReference participant =
        FirebaseFirestore.instance.collection('event').doc(eventuid).collection("participant");
        participant.doc(uid).update({
        'payment':true
        });
  }

  Future<void> updateEvent(
      String eventName,
      DateTime date,
      DateTime endDate,
      String location,
      String eventfee,
      String description,
      String label,
      String reg,
      DateTime regDeadline,
      String picName,
      String contact,
      String uid) {
    // Call the user's CollectionReference to add a new user_
    CollectionReference event = FirebaseFirestore.instance.collection('event');

    return event
        .doc(uid)
        .update({
          'EventName': eventName, 
          'Date': date, 
          'End_Date': endDate, 
          'Location': location,
          'Event_Fee': eventfee,
          'Description': description,
          'label': label,
          'Open_Registration': reg,
          'Registration': regDeadline,
          'PIC_Name': picName,
          'PIC_Contact': contact, 
        })
        .then((value) => print("Event Updated"))
        .catchError((error) => print("Failed to Update user: $error"));
  }
   Future<void> deleteEvent(
      String uid) {
    // Call the user's CollectionReference to add a new user_
    CollectionReference event = FirebaseFirestore.instance.collection('event');

    return event
        .doc(uid)
        .delete()
        .then((value) => print("Event deleted"))
        .catchError((error) => print("Failed to Update user: $error"));
  }

  Future<void> addInvitation(
      String name,
      List<String> email,
      String eventuid,
      ) async {
    // Call the user's CollectionReference to add a new user_
    User user= FirebaseAuth.instance.currentUser;
    CollectionReference invitee =
        FirebaseFirestore.instance.collection('event').doc(eventuid).collection("invitee");
        invitee.add({
        "userName":name,
        "email":email,
        "Creator_uid":user.uid,
        });
  }

  Future<void> updateProfile(
      String name,
      String gender,
      String age,
      String mobile,
      String interest,
      String uid) {
        
    // Call the user's CollectionReference to add a new user_
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .doc(uid)
        .update({
          'name': name, 
          'gender': gender, 
          'age': age, 
          'mobile': mobile, 
          'interest': interest, 
        })
        .then((value) => print("users Updated"))
        .catchError((error) => print("Failed to Update user: $error"));
  }

  Future<void> addReport(
    String paragraph,
    File _imageFile1,
    File _imageFile2,
    File _imageFile3,
    File _imageFile4,
    File _imageFile5,
    File _imageFile6,
    File _imageFile7,
    File _imageFile8,
    String eventuid
  ) async {
    String _logoImage1, _logoImage2, _logoImage3, _logoImage4, _logoImage5, eventImage1, eventImage2, eventImage3;
    FirebaseStorage storage = FirebaseStorage.instance;

    Reference ref1 = storage.ref().child("logo1" + DateTime.now().toString());
    Reference ref2 = storage.ref().child("logo2" + DateTime.now().toString());
    Reference ref3 = storage.ref().child("logo3" + DateTime.now().toString());
    Reference ref4 = storage.ref().child("logo4" + DateTime.now().toString());
    Reference ref5 = storage.ref().child("logo5" + DateTime.now().toString());
    Reference ref6 = storage.ref().child("event1" + DateTime.now().toString());
    Reference ref7 = storage.ref().child("event2" + DateTime.now().toString());
    Reference ref8 = storage.ref().child("event3" + DateTime.now().toString());

    UploadTask uploadTask1 = ref1.putFile(_imageFile1);
    await uploadTask1.then((res) async {
      _logoImage1 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask2 = ref2.putFile(_imageFile2);
    await uploadTask2.then((res) async {
      _logoImage2 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask3 = ref3.putFile(_imageFile3);
    await uploadTask3.then((res) async {
      _logoImage3 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask4 = ref4.putFile(_imageFile4);
    await uploadTask4.then((res) async {
      _logoImage4 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask5 = ref5.putFile(_imageFile5);
    await uploadTask5.then((res) async {
      _logoImage5 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask6 = ref6.putFile(_imageFile6);
    await uploadTask6.then((res) async {
      eventImage1 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask7 = ref7.putFile(_imageFile7);
    await uploadTask7.then((res) async {
      eventImage2 = await res.ref.getDownloadURL();
    });

    UploadTask uploadTask8 = ref8.putFile(_imageFile8);
    await uploadTask8.then((res) async {
      eventImage3 = await res.ref.getDownloadURL();
    });
    User user= FirebaseAuth.instance.currentUser;
    CollectionReference invitee =
        FirebaseFirestore.instance.collection('event').doc(eventuid).collection("report");
        invitee.add({
        "Content": paragraph,
        "LogoImage": [_logoImage1, _logoImage2, _logoImage3, _logoImage4, _logoImage5],
        "EventImage": [eventImage1, eventImage2, eventImage3],
        "Creator_uid":user.uid,
        });
  }
}
