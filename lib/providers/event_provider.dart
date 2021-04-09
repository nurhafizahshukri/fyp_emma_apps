import 'package:EMMA/model/class.dart';
import 'package:EMMA/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class EventProvider with ChangeNotifier {
  final firestoreService = FirestoreService();

  String _eventName, _location, _eventID, _description;
  DateTime _eventDate;
  double _fee;
  var uuid = Uuid();

  //Getters
  DateTime get eventDate => _eventDate;
  String get eventName => _eventName;
  String get location => _location;
  String get eventID => _eventID;
  String get description => _description;
  double get fee => _fee;
  Stream<List<EventInfo>> get eventinfo => firestoreService.getEvent();

  //Setters
  set changeDate(DateTime eventDate){
    _eventDate = eventDate;
    notifyListeners();
  }
  set changeEventName(String eventName){
    _eventName = eventName;
    notifyListeners();
  }
  set changeEventLocation(String location){
    _location = location;
    notifyListeners();
  }
  set changeEventID(String eventID){
    _eventID = eventID;
    notifyListeners();
  }
  set changeDescription(String description){
    _description = description;
    notifyListeners();
  }
  set changeFee(double fee){
    _fee = fee;
    notifyListeners();
  }

  // Function
  //Functions
  loadAll(EventInfo event){
    // if (event != null){
      _eventDate = event.eventDate;
      _eventName =event.eventName;
      _location = event.location;
      _eventID = event.eventID;
      _description = event.description;
      _fee = event.fee;
    // } else {
    //   // _eventDate = ;
    //   _eventName = "";
    //   _location = "";
    //   _eventID = "";
    //   _description = "";
    //   _fee = 0;
    // }
  }

  saveEntry(){
    if (_eventID == null){
      //Add
      var newEvent = EventInfo(
        eventDate: _eventDate, 
        eventName: _eventName, 
        location: _location, 
        description: _description, 
        fee: _fee, 
        eventID: uuid.v1());
      print(newEvent.eventName);
      firestoreService.setEvent(newEvent);
    } else {
      //Edit
      var updatedEvent = EventInfo(
        eventDate: _eventDate, 
        eventName: _eventName, 
        location: _location, 
        description: _description, 
        fee: _fee, 
        eventID: _eventID
      );
      firestoreService.setEvent(updatedEvent);
    }
  }

  removeEvent(String eventID){
    firestoreService.removeEvent(eventID);
  }
}