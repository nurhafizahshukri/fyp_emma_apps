import 'package:EMMA/model/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Get entries
  Stream<List<EventInfo>> getEvent(){
      return _db
        .collection('eventinfo')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => EventInfo.fromJson(doc.data()))
        .toList());
    }

  //Upsert
  Future<void> setEvent(EventInfo eventinfo){
      var options = SetOptions(merge:true);

      return _db
        .collection('eventinfo')
        .doc(eventinfo.eventID)
        .set(eventinfo.toMap(),options);
    }
  
  //Delete
  Future<void> removeEvent(String eventID){
      return _db
        .collection('eventinfo')
        .doc(eventID)
        .delete();
    }
}