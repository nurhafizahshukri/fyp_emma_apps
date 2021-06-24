// import 'package:fiza/model/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EMMA/Pages/Organiser/eventDetails.dart';
import 'package:EMMA/Pages/Participants/eventView.dart';

class DashboardParticipant extends StatefulWidget {
  @override
  _DashboardParticipantState createState() => _DashboardParticipantState();
}

class _DashboardParticipantState extends State<DashboardParticipant> {
  final List<Set<Color>> newColor = [
    {Color(0xff6DC8F3), Color(0xff73A1F9)},
    {Color(0xffFFB157), Color(0xffFFA057)},
    {Color(0xffFF5B95), Color(0xffF8556D)},
    {Color(0xffD76EF5), Color(0xff8F7AFE)},
    {Color(0xff42E695), Color(0xff3BB2B8)}
  ];
  final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  int index =-1; 
  @override
  Widget build(BuildContext context) {
    CollectionReference event = FirebaseFirestore.instance.collection('event');

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: event.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading"));
              }
              return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                DateTime myDateTime = (document.data()['Date']).toDate();
                DateTime myEndDateTime = (document.data()['End_Date']).toDate();
                DateTime myTimeDate = (document.data()['Time']).toDate();
                DateTime myEndTimeDate = (document.data()['End_Time']).toDate();
                index += 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventView(
                                myDateTime,
                                myTimeDate,
                                myEndDateTime,
                                myEndTimeDate,
                                document.data()['EventName'],
                                document.data()['Location'],
                                document.data()['Event_Fee'],
                                document.data()['Description'],
                                document.data()['label'],
                                document.data()['Open_Registeration'],
                                document.id,
                                document.data()['participant']),
                            fullscreenDialog: true));
                  },
                  child: new Center(
                      child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Stack(children: <Widget>[
                      Container(
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: LinearGradient(
                                  colors: [
                                    newColor[index%4].first,
                                    newColor[index%4].last
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                    color: newColor[index%4].last,
                                    blurRadius: 12,
                                    offset: Offset(0, 6))
                              ])),
                      Positioned.fill(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        myDateTime.day.toString(),
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Text(
                                        "${months[myDateTime.month-1]}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                                // Image.asset(
                                //   'assets/images/logo_white.png',
                                //   height: 64,
                                //   width: 64)
                                ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document.data()['EventName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    ),
                                  ),
                                  Text(
                                    document.data()['Location'],
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                  )),
                );
              }).toList());
            }));
  }
}
