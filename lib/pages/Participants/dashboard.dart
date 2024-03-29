// import 'package:fiza/model/class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:EMMA/Comman_widget/Custom_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EMMA/pages/Participants/eventView.dart';

class Event {
  final String creatorUid,
      eventName,
      eventFee,
      location,
      openRegistration,
      label,
      picName,
      picContact,
      id;
  final DateTime date, endDate, regDate;
  final String description;

  Event(
      this.creatorUid,
      this.eventName,
      this.eventFee,
      this.location,
      this.openRegistration,
      this.label,
      this.picName,
      this.picContact,
      this.date,
      this.endDate,
      this.regDate,
      this.description,
      this.id);
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
    List<Event> suggestedEvent = [];
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
    var formatter2 = new DateFormat('dd-MM-yyyy');
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
                        suggestedEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registration'],
                            document.data()['label'],
                            document.data()['PIC_Name'],
                            document.data()['PIC_Contact'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['Registration']).toDate(),
                            document.data()['Description'],
                            document.id));
                           
                      } else
                        otherEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registration'],
                            document.data()['label'],
                            document.data()['PIC_Name'],
                            document.data()['PIC_Contact'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['Registration']).toDate(),
                            document.data()['Description'],
                            document.id));
                    allEvent.add(Event(
                            document.data()['Creator_Uid'],
                            document.data()['EventName'],
                            document.data()['Event_Fee'],
                            document.data()['Location'],
                            document.data()['Open_Registration'],
                            document.data()['label'],
                            document.data()['PIC_Name'],
                            document.data()['PIC_Contact'],
                            (document.data()['Date']).toDate(),
                            (document.data()['End_Date']).toDate(),
                            (document.data()['Registration']).toDate(),
                            document.data()['Description'],
                            document.id));
                    }
                    
                    );
                      otherEvent.addAll(suggestedEvent);
                    
                    return suggestedEvent.length==0? 
                   ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(8),
                            itemCount: allEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = allEvent[index].date;
                              DateTime myEndDateTime = allEvent[index].endDate;
                              DateTime regDateTime = allEvent[index].regDate;
                              DateTime formattedEventDate = formatter.parse(myDateTime.toString());
                              DateTime formattedEventEndDate = formatter.parse(myEndDateTime.toString());
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
                                                      myEndDateTime,
                                                      regDateTime,
                                                      allEvent[index]
                                                          .eventName,
                                                      allEvent[index]
                                                          .location,
                                                      allEvent[index]
                                                          .eventFee,
                                                      allEvent[index]
                                                          .description,
                                                      allEvent[index]
                                                          .label,
                                                      allEvent[index]
                                                          .openRegistration,
                                                      allEvent[index]
                                                          .picName,
                                                      allEvent[index]
                                                          .picContact,
                                                      allEvent[index].id,
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
                                                    colors: (allEvent[index].label == 'conferences') || (allEvent[index].label == 'seminar') || (allEvent[index].label == 'workshops')? [
                                                      newColor[0].first,
                                                      newColor[0].last
                                                    ] : (allEvent[index].label == 'expo') || (allEvent[index].label == 'award') || (allEvent[index].label == 'festival')? [
                                                      newColor[1].first,
                                                      newColor[1].last
                                                    ] : (allEvent[index].label == 'leadership') || (allEvent[index].label == 'volunteers') || (allEvent[index].label == 'self improvement')? [
                                                      newColor[2].first,
                                                      newColor[2].last
                                                    ] : (allEvent[index].label == 'creative') || (allEvent[index].label == 'cooking') || (allEvent[index].label == 'art')? [
                                                      newColor[3].first,
                                                      newColor[3].last
                                                    ] : [
                                                      newColor[4].first,
                                                      newColor[4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: (allEvent[index].label == 'conferences') || (allEvent[index].label == 'seminar') || (allEvent[index].label == 'workshops')?
                                                       newColor[0].last
                                                      : (allEvent[index].label == 'expo') || (allEvent[index].label == 'award') || (allEvent[index].label == 'festival')? 
                                                       newColor[1].last
                                                      : (allEvent[index].label == 'leadership') || (allEvent[index].label == 'volunteers') || (allEvent[index].label == 'self improvement')? 
                                                       newColor[2].last
                                                      : (allEvent[index].label == 'creative') || (allEvent[index].label == 'cooking') || (allEvent[index].label == 'art')? 
                                                       newColor[3].last
                                                      : newColor[4].last,
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
                                                (allEvent[index].label == 'conferences') || (allEvent[index].label == 'seminar') || (allEvent[index].label == 'workshops')?
                                                 newColor[0].first
                                                : (allEvent[index].label == 'expo') || (allEvent[index].label == 'award') || (allEvent[index].label == 'festival')? 
                                                 newColor[1].first
                                                : (allEvent[index].label == 'leadership') || (allEvent[index].label == 'volunteers') || (allEvent[index].label == 'self improvement')? 
                                                 newColor[2].first
                                                : (allEvent[index].label == 'creative') || (allEvent[index].label == 'cooking') || (allEvent[index].label == 'art')? 
                                                 newColor[3].first
                                                : newColor[4].first, 
                                                
                                                (allEvent[index].label == 'conferences') || (allEvent[index].label == 'seminar') || (allEvent[index].label == 'workshops')?
                                                 newColor[0].last
                                                : (allEvent[index].label == 'expo') || (allEvent[index].label == 'award') || (allEvent[index].label == 'festival')? 
                                                 newColor[1].last
                                                : (allEvent[index].label == 'leadership') || (allEvent[index].label == 'volunteers') || (allEvent[index].label == 'self improvement')? 
                                                 newColor[2].last
                                                : (allEvent[index].label == 'creative') || (allEvent[index].label == 'cooking') || (allEvent[index].label == 'art')? 
                                                 newColor[3].last
                                                : newColor[4].last,),
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
                                                          .eventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      allEvent[index]
                                                          .location,
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
                                                        (myDateTime.day.toString() == myEndDateTime.day.toString()) && (myDateTime.month.toString() == myEndDateTime.month.toString())
                                                          ? formatter2.format(myDateTime)
                                                          : formatter2.format(myDateTime) + "-" + formatter2.format(myEndDateTime),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                        ),
                                                        child: Text( 
                                                            allEvent[index].label.toUpperCase(),
                                                            style: TextStyle(
                                                            color: Colors.grey[100],
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 11,
                                                          ),
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
                                                      formattedEventDate.compareTo(
                                                                  formattedDate) >
                                                              0
                                                          ? 'Coming\nSoon'
                                                          : formattedEventDate.compareTo(
                                                                          formattedDate) <
                                                                      0 &&
                                                                  formattedEventEndDate
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
                            itemCount: suggestedEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = suggestedEvent[index].date;
                              DateTime myEndDateTime = suggestedEvent[index].endDate;
                              DateTime regDateTime = suggestedEvent[index].regDate;
                              DateTime formattedEventDate = formatter.parse(myDateTime.toString());
                              DateTime formattedEventEndDate = formatter.parse(myEndDateTime.toString());
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
                                                      myEndDateTime,
                                                      regDateTime,
                                                      suggestedEvent[index]
                                                          .eventName,
                                                      suggestedEvent[index]
                                                          .location,
                                                      suggestedEvent[index]
                                                          .eventFee,
                                                      suggestedEvent[index]
                                                          .description,
                                                      suggestedEvent[index]
                                                          .label,
                                                      suggestedEvent[index]
                                                          .openRegistration,
                                                      suggestedEvent[index]
                                                          .picName,
                                                      suggestedEvent[index]
                                                          .picContact,
                                                      suggestedEvent[index].id,
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
                                                    colors: (suggestedEvent[index].label == 'conferences') || (suggestedEvent[index].label == 'seminar') || (suggestedEvent[index].label == 'workshops')? [
                                                      newColor[0].first,
                                                      newColor[0].last
                                                    ] : (suggestedEvent[index].label == 'expo') || (suggestedEvent[index].label == 'award') || (suggestedEvent[index].label == 'festival')? [
                                                      newColor[1].first,
                                                      newColor[1].last
                                                    ] : (suggestedEvent[index].label == 'leadership') || (suggestedEvent[index].label == 'volunteers') || (suggestedEvent[index].label == 'self improvement')? [
                                                      newColor[2].first,
                                                      newColor[2].last
                                                    ] : (suggestedEvent[index].label == 'creative') || (suggestedEvent[index].label == 'cooking') || (suggestedEvent[index].label == 'art')? [
                                                      newColor[3].first,
                                                      newColor[3].last
                                                    ] : [
                                                      newColor[4].first,
                                                      newColor[4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: (suggestedEvent[index].label == 'conferences') || (suggestedEvent[index].label == 'seminar') || (suggestedEvent[index].label == 'workshops')?
                                                       newColor[0].last
                                                      : (suggestedEvent[index].label == 'expo') || (suggestedEvent[index].label == 'award') || (suggestedEvent[index].label == 'festival')? 
                                                       newColor[1].last
                                                      : (suggestedEvent[index].label == 'leadership') || (suggestedEvent[index].label == 'volunteers') || (suggestedEvent[index].label == 'self improvement')? 
                                                       newColor[2].last
                                                      : (suggestedEvent[index].label == 'creative') || (suggestedEvent[index].label == 'cooking') || (suggestedEvent[index].label == 'art')? 
                                                       newColor[3].last
                                                      : newColor[4].last,
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
                                                (suggestedEvent[index].label == 'conferences') || (suggestedEvent[index].label == 'seminar') || (suggestedEvent[index].label == 'workshops')?
                                                 newColor[0].first
                                                : (suggestedEvent[index].label == 'expo') || (suggestedEvent[index].label == 'award') || (suggestedEvent[index].label == 'festival')? 
                                                 newColor[1].first
                                                : (suggestedEvent[index].label == 'leadership') || (suggestedEvent[index].label == 'volunteers') || (suggestedEvent[index].label == 'self improvement')? 
                                                 newColor[2].first
                                                : (suggestedEvent[index].label == 'creative') || (suggestedEvent[index].label == 'cooking') || (suggestedEvent[index].label == 'art')? 
                                                 newColor[3].first
                                                : newColor[4].first, 
                                                
                                                (suggestedEvent[index].label == 'conferences') || (suggestedEvent[index].label == 'seminar') || (suggestedEvent[index].label == 'workshops')?
                                                 newColor[0].last
                                                : (suggestedEvent[index].label == 'expo') || (suggestedEvent[index].label == 'award') || (suggestedEvent[index].label == 'festival')? 
                                                 newColor[1].last
                                                : (suggestedEvent[index].label == 'leadership') || (suggestedEvent[index].label == 'volunteers') || (suggestedEvent[index].label == 'self improvement')? 
                                                 newColor[2].last
                                                : (suggestedEvent[index].label == 'creative') || (suggestedEvent[index].label == 'cooking') || (suggestedEvent[index].label == 'art')? 
                                                 newColor[3].last
                                                : newColor[4].last,),
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
                                                      suggestedEvent[index]
                                                          .eventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      suggestedEvent[index]
                                                          .location,
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
                                                        (myDateTime.day.toString() == myEndDateTime.day.toString()) && (myDateTime.month.toString() == myEndDateTime.month.toString())
                                                          ? formatter2.format(myDateTime)
                                                          : formatter2.format(myDateTime) + "-" + formatter2.format(myEndDateTime),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                        ),
                                                        child: Text( 
                                                            suggestedEvent[index]
                                                          .label.toUpperCase(),
                                                            style: TextStyle(
                                                            color: Colors.grey[100],
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 11,
                                                          ),
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
                                                      formattedEventDate.compareTo(formattedDate) > 0
                                                          ? 'Coming\nSoon'
                                                          : formattedEventDate.compareTo(formattedDate) < 0 &&
                                                                  formattedEventEndDate.compareTo(formattedDate) <0
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
                          ),
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.fromLTRB(9, 8, 0, 8),
                            itemCount: otherEvent.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime myDateTime = otherEvent[index].date;
                              DateTime myEndDateTime = otherEvent[index].endDate;
                              DateTime regDateTime = otherEvent[index].regDate;
                              DateTime formattedEventDate = formatter.parse(myDateTime.toString());
                              DateTime formattedEventEndDate = formatter.parse(myEndDateTime.toString());
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
                                                      myEndDateTime,
                                                      regDateTime,
                                                      otherEvent[index]
                                                          .eventName,
                                                      otherEvent[index]
                                                          .location,
                                                      otherEvent[index]
                                                          .eventFee,
                                                      otherEvent[index]
                                                          .description,
                                                      otherEvent[index]
                                                          .label,
                                                      otherEvent[index]
                                                          .openRegistration,
                                                      otherEvent[index]
                                                          .picName,
                                                      otherEvent[index]
                                                          .picContact,
                                                      otherEvent[index].id,
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
                                                    colors: (otherEvent[index].label == 'conferences') || (otherEvent[index].label == 'seminar') || (otherEvent[index].label == 'workshops')? [
                                                      newColor[0].first,
                                                      newColor[0].last
                                                    ] : (otherEvent[index].label == 'expo') || (otherEvent[index].label == 'award') || (otherEvent[index].label == 'festival')? [
                                                      newColor[1].first,
                                                      newColor[1].last
                                                    ] : (otherEvent[index].label == 'leadership') || (otherEvent[index].label == 'volunteers') || (otherEvent[index].label == 'self improvement')? [
                                                      newColor[2].first,
                                                      newColor[2].last
                                                    ] : (otherEvent[index].label == 'creative') || (otherEvent[index].label == 'cooking') || (otherEvent[index].label == 'art')? [
                                                      newColor[3].first,
                                                      newColor[3].last
                                                    ] : [
                                                      newColor[4].first,
                                                      newColor[4].last
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: (otherEvent[index].label == 'conferences') || (otherEvent[index].label == 'seminar') || (otherEvent[index].label == 'workshops')?
                                                       newColor[0].last
                                                      : (otherEvent[index].label == 'expo') || (otherEvent[index].label == 'award') || (otherEvent[index].label == 'festival')? 
                                                       newColor[1].last
                                                      : (otherEvent[index].label == 'leadership') || (otherEvent[index].label == 'volunteers') || (otherEvent[index].label == 'self improvement')? 
                                                       newColor[2].last
                                                      : (otherEvent[index].label == 'creative') || (otherEvent[index].label == 'cooking') || (otherEvent[index].label == 'art')? 
                                                       newColor[3].last
                                                      : newColor[4].last,
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
                                                (otherEvent[index].label == 'conferences') || (otherEvent[index].label == 'seminar') || (otherEvent[index].label == 'workshops')?
                                                 newColor[0].first
                                                : (otherEvent[index].label == 'expo') || (otherEvent[index].label == 'award') || (otherEvent[index].label == 'festival')? 
                                                 newColor[1].first
                                                : (otherEvent[index].label == 'leadership') || (otherEvent[index].label == 'volunteers') || (otherEvent[index].label == 'self improvement')? 
                                                 newColor[2].first
                                                : (otherEvent[index].label == 'creative') || (otherEvent[index].label == 'cooking') || (otherEvent[index].label == 'art')? 
                                                 newColor[3].first
                                                : newColor[4].first, 
                                                
                                                (otherEvent[index].label == 'conferences') || (otherEvent[index].label == 'seminar') || (otherEvent[index].label == 'workshops')?
                                                 newColor[0].last
                                                : (otherEvent[index].label == 'expo') || (otherEvent[index].label == 'award') || (otherEvent[index].label == 'festival')? 
                                                 newColor[1].last
                                                : (otherEvent[index].label == 'leadership') || (otherEvent[index].label == 'volunteers') || (otherEvent[index].label == 'self improvement')? 
                                                 newColor[2].last
                                                : (otherEvent[index].label == 'creative') || (otherEvent[index].label == 'cooking') || (otherEvent[index].label == 'art')? 
                                                 newColor[3].last
                                                : newColor[4].last,),
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
                                                          .eventName,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      otherEvent[index]
                                                          .location,
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
                                                        (myDateTime.day.toString() == myEndDateTime.day.toString()) && (myDateTime.month.toString() == myEndDateTime.month.toString())
                                                          ? formatter2.format(myDateTime)
                                                          : formatter2.format(myDateTime) + "-" + formatter2.format(myEndDateTime),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[100],
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 5.0),
                                                      child: Container(
                                                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                        ),
                                                        child: Text( 
                                                            otherEvent[index]
                                                          .label.toUpperCase(),
                                                            style: TextStyle(
                                                            color: Colors.grey[100],
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 11,
                                                          ),
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
                                                      formattedEventDate.compareTo(formattedDate) > 0
                                                          ? 'Coming\nSoon'
                                                          : formattedEventDate.compareTo(formattedDate) < 0 &&
                                                                  formattedEventEndDate.compareTo(formattedDate) <0
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