// import 'dart:ui';

class EventInfo {
  final String eventName, location, eventID, description;
  final DateTime eventDate;
  final double fee;


  EventInfo({this.eventName, this.location, this.eventID, this.description, this.eventDate, this.fee});

  factory EventInfo.fromJson(Map<String, dynamic> json){
    return EventInfo(
      eventName: json['date'],
      location: json['location'],
      eventID: json['eventID'],
      description: json['description'],
      eventDate: json['eventDate'],
      fee: json['fee'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'eventName': eventName,
      'location': location,
      'eventID': eventID,
      'description': description,
      'eventDate': eventDate,
      'fee': fee,
    };
  }
}