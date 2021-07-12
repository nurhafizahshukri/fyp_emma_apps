import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //Determine if the user is authenticated.
  
  Future<void> addEvent(
      String eventName,
      DateTime date,
      DateTime time,
      DateTime endDate,
      DateTime endTime,
      String location,
      String eventfee,
      String description,
      String label,
      String reg) async {
    // Call the user's CollectionReference to add a new user_

    User user = FirebaseAuth.instance.currentUser;

    CollectionReference event = FirebaseFirestore.instance.collection('event');
    event
        .add({
          'EventName': eventName, 
          'Date': date,
          'Time': time, 
          'End_Date': endDate,
          'End_Time': endTime, 
          'Location': location,
          'Event_Fee': eventfee,
          'Description': description,
          'label': label,
          'Open_Registeration': reg,
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
      DateTime time,
      String location,
      String eventfee,
      String description,
      String label,
      String reg,
      String uid) {
    // Call the user's CollectionReference to add a new user_
    CollectionReference event = FirebaseFirestore.instance.collection('event');

    return event
        .doc(uid)
        .update({
          'EventName': eventName, // John Doe
          'Date': date, // Stokes and Sons
          'Time': time, // 42
          'Location': location,
          'Event_Fee': eventfee,
          'Description': description,
          'label': label,
          'Open_Registeration': reg
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
      String email,
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
}
