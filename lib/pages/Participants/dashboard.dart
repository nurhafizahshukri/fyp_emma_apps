// import 'package:fiza/model/class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EMMA/Comman_widget/Custom_card.dart';
import 'package:EMMA/pages/Organiser/eventDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EMMA/pages/Participants/eventView.dart';

class Event {
  final String Creator_Uid,
      EventName,
      Event_Fee,
      Location,
      Open_Registeration,
      label,
      Id;
  final DateTime Date, End_Date, End_Time, Time;
  final String Description;

  Event(
      this.Creator_Uid,
      this.EventName,
      this.Event_Fee,
      this.Location,
      this.Open_Registeration,
      this.label,
      this.Date,
      this.End_Date,
      this.End_Time,
      this.Time,
      this.Description,
      this.Id);
}

class DashboardParticipant extends StatefulWidget {
  @override
  _DashboardParticipantState createState() => _DashboardParticipantState();
}

class _DashboardParticipantState extends State<DashboardParticipant> {
  final format1 = DateFormat("HH:mm");
  final List<Set<Color>> newColor = [
    {Color(0xff6DC8F3), Color(0xff73A1F9)},
    {Color(0xffFFB157), Color(0xffFFA057)},
    {Color(0xffFF5B95), Color(0xffF8556D)},
    {Color(0xffD76EF5), Color(0xff8F7AFE)},
    {Color(0xff42E695), Color(0xff3BB2B8)}
  ];
  final months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  int index = -1;

  @override
  Widget build(BuildContext context) {
    List<Event> otherEvent = [];
    List<Event> sugestedEvent = [];
    List<Event> allEvent = [];
    String username;
    String mobile;
    CollectionReference event = FirebaseFirestore.instance.collection('event');
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);

    DateTime now = DateTime.now();
    String interest;
    var formatter = new DateFormat('yyyy-MM-dd');
    DateTime formattedDate = formatter.parse(now.toString());
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
            stream: user.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              interest = snapshot.data["interest"];
              username= snapshot.data["name"];
                            mobile= snapshot.data["mobile"];

              return StreamBuilder<QuerySnapshot>(
                  stream: event
                      .where('End_Date',
                          isGreaterThanOrEqualTo: formattedDate)
                      .orderBy("End_Date", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                        
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: Text("Loading"));
                    }
                    snapshot.data.docs.forEach((DocumentSnapshot document) {
                      //interest.contains(document.data()["label"])?
                      if (interest.contains(document.data()["label"])) {
                        sugestedEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registeration'],
                            document.data()['label'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['End_Time']).toDate(),
                            (document.data()['Time']).toDate(),
                            document.data()['Description'],
                            document.id));
                           
                      } else
                        otherEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registeration'],
                            document.data()['label'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['End_Time']).toDate(),
                            (document.data()['Time']).toDate(),
                            document.data()['Description'],
                            document.id));
                      // :otherEvent.add(Event(document.data()['Creator_Uid'], document.data()['EventName'], document.data()['Event_Fee'], document.data()['Location'], document.data()['Open_Registeration'],document.data()['label'], (document.data()['Date']).toDate(), (document.data()['End_Date']).toDate(),(document.data()['End_Time']).toDate(), (document.data()['Time']).toDate(), document.data()['Description'],document.id));
                    allEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registeration'],
                            document.data()['label'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['End_Time']).toDate(),
                            (document.data()['Time']).toDate(),
                            document.data()['Description'],
                            document.id));
                    }
                    
                    );
                      otherEvent.addAll(sugestedEvent);
                    
                    return sugestedEvent.length==0? 
                   ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(8),
                            itemCount: allEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = allEvent[index].Date;
                              DateTime myEndDateTime =
                                  allEvent[index].End_Date;
                              DateTime myTimeDate = allEvent[index].Time;
                              DateTime myEndTimeDate =
                                  allEvent[index].End_Time;
                              return Container(
                                  width: 350,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventView(
                                                      myDateTime,
                                                      myTimeDate,
                                                      myEndDateTime,
                                                      myEndTimeDate,
                                                      allEvent[index]
                                                          .EventName,
                                                      allEvent[index]
                                                          .Location,
                                                      allEvent[index]
                                                          .Event_Fee,
                                                      allEvent[index]
                                                          .Description,
                                                      allEvent[index]
                                                          .label,
                                                      allEvent[index]
                                                          .Open_Registeration,
                                                      allEvent[index].Id,
                                                      username,
                                                      mobile,
                                                      ),
                                              fullscreenDialog: true));
                                    },
                                    child: new Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Stack(children: <Widget>[
                                        Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      newColor[index % 4].first,
                                                      newColor[index % 4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: newColor[index % 4]
                                                          .last,
                                                      blurRadius: 12,
                                                      offset: Offset(0, 6))
                                                ])),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: CustomPaint(
                                            size: Size(100, 150),
                                            painter: CustomCardShapePainter(
                                                24,
                                                newColor[index % 4].first,
                                                newColor[index % 4].last),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 40,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          myDateTime.day
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          "${months[myDateTime.month - 1]}",
                                                          // myDateTime.month.toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      allEvent[index]
                                                          .EventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      allEvent[index]
                                                          .Location,
                                                      style: TextStyle(
                                                        color: Colors.grey[100],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        myDateTime.toString() ==
                                                                myEndDateTime
                                                                    .toString()
                                                            ? "${myDateTime.day}/${myDateTime.month}/${myDateTime.year}"
                                                            : "${myDateTime.day}/${myDateTime.month}/${myDateTime.year} - ${myEndDateTime.day}/${myEndDateTime.month}/${myEndDateTime.year}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      myDateTime.compareTo(
                                                                  formattedDate) >
                                                              0
                                                          ? 'Coming\nSoon'
                                                          : myDateTime.compareTo(
                                                                          formattedDate) <
                                                                      0 &&
                                                                  myEndDateTime
                                                                          .compareTo(
                                                                              formattedDate) <
                                                                      0
                                                              ? 'Ended'
                                                              : 'Ongoing',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Avenir',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                    )),
                                  ));
                            }) :Column(children: [
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 12.0, 9.0, 0),
                        child: Text(
                          'Suggested for you',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                          // textAlign: TextAlign.left,
                          ),
                      ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(8),
                            itemCount: sugestedEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = sugestedEvent[index].Date;
                              DateTime myEndDateTime =
                                  sugestedEvent[index].End_Date;
                              DateTime myTimeDate = sugestedEvent[index].Time;
                              DateTime myEndTimeDate =
                                  sugestedEvent[index].End_Time;
                              return Container(
                                  width: 350,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventView(
                                                      myDateTime,
                                                      myTimeDate,
                                                      myEndDateTime,
                                                      myEndTimeDate,
                                                      sugestedEvent[index]
                                                          .EventName,
                                                      sugestedEvent[index]
                                                          .Location,
                                                      sugestedEvent[index]
                                                          .Event_Fee,
                                                      sugestedEvent[index]
                                                          .Description,
                                                      sugestedEvent[index]
                                                          .label,
                                                      sugestedEvent[index]
                                                          .Open_Registeration,
                                                      sugestedEvent[index].Id,
                                                        username,
                                                      mobile,),
                                              fullscreenDialog: true));
                                    },
                                    child: new Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Stack(children: <Widget>[
                                        Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      newColor[index % 4].first,
                                                      newColor[index % 4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: newColor[index % 4]
                                                          .last,
                                                      blurRadius: 12,
                                                      offset: Offset(0, 6))
                                                ])),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: CustomPaint(
                                            size: Size(100, 150),
                                            painter: CustomCardShapePainter(
                                                24,
                                                newColor[index % 4].first,
                                                newColor[index % 4].last),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 40,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          myDateTime.day
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          "${months[myDateTime.month - 1]}",
                                                          // myDateTime.month.toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      sugestedEvent[index]
                                                          .EventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      sugestedEvent[index]
                                                          .Location,
                                                      style: TextStyle(
                                                        color: Colors.grey[100],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        myDateTime.toString() ==
                                                                myEndDateTime
                                                                    .toString()
                                                            ? "${myDateTime.day}/${myDateTime.month}/${myDateTime.year}"
                                                            : "${myDateTime.day}/${myDateTime.month}/${myDateTime.year} - ${myEndDateTime.day}/${myEndDateTime.month}/${myEndDateTime.year}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      myDateTime.compareTo(
                                                                  formattedDate) >
                                                              0
                                                          ? 'Coming\nSoon'
                                                          : myDateTime.compareTo(
                                                                          formattedDate) <
                                                                      0 &&
                                                                  myEndDateTime
                                                                          .compareTo(
                                                                              formattedDate) <
                                                                      0
                                                              ? 'Ended'
                                                              : 'Ongoing',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Avenir',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                    )),
                                  ));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(9.0, 9.0, 9.0, 5.0),
                        child: Text(
                          'All Events',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                          // textAlign: TextAlign.left,
                          ),
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.fromLTRB(9, 8, 0, 8),
                            itemCount: otherEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = otherEvent[index].Date;
                              DateTime myEndDateTime =
                                  otherEvent[index].End_Date;
                              DateTime myTimeDate = otherEvent[index].Time;
                              DateTime myEndTimeDate =
                                  otherEvent[index].End_Time;
                              return Container(
                                  width: 350,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EventView(
                                                      myDateTime,
                                                      myTimeDate,
                                                      myEndDateTime,
                                                      myEndTimeDate,
                                                      otherEvent[index]
                                                          .EventName,
                                                      otherEvent[index]
                                                          .Location,
                                                      otherEvent[index]
                                                          .Event_Fee,
                                                      otherEvent[index]
                                                          .Description,
                                                      otherEvent[index]
                                                          .label,
                                                      otherEvent[index]
                                                          .Open_Registeration,
                                                      otherEvent[index].Id,
                                                        username,
                                                      mobile,),
                                              fullscreenDialog: true));
                                    },
                                    child: new Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Stack(children: <Widget>[
                                        Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      newColor[index % 4].first,
                                                      newColor[index % 4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: newColor[index % 4]
                                                          .last,
                                                      blurRadius: 12,
                                                      offset: Offset(0, 6))
                                                ])),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          top: 0,
                                          child: CustomPaint(
                                            size: Size(100, 150),
                                            painter: CustomCardShapePainter(
                                                24,
                                                newColor[index % 4].first,
                                                newColor[index % 4].last),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 2,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 40,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          myDateTime.day
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        Text(
                                                          "${months[myDateTime.month - 1]}",
                                                          // myDateTime.month.toString(),
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      otherEvent[index]
                                                          .EventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      otherEvent[index]
                                                          .Location,
                                                      style: TextStyle(
                                                        color: Colors.grey[100],
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0),
                                                      child: Text(
                                                        myDateTime.toString() ==
                                                                myEndDateTime
                                                                    .toString()
                                                            ? "${myDateTime.day}/${myDateTime.month}/${myDateTime.year}"
                                                            : "${myDateTime.day}/${myDateTime.month}/${myDateTime.year} - ${myEndDateTime.day}/${myEndDateTime.month}/${myEndDateTime.year}",
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                      myDateTime.compareTo(
                                                                  formattedDate) >
                                                              0
                                                          ? 'Coming\nSoon'
                                                          : myDateTime.compareTo(
                                                                          formattedDate) <
                                                                      0 &&
                                                                  myEndDateTime
                                                                          .compareTo(
                                                                              formattedDate) <
                                                                      0
                                                              ? 'Ended'
                                                              : 'Ongoing',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Avenir',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ]),
                                    )),
                                  ));
                            }),
                      )
                    ]);
                  });
            }));
  }
}