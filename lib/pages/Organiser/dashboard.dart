// import 'package:fiza/model/class.dart';
import 'package:EMMA/pages/Organiser/eventDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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

                DateTime myTimeDate = (document.data()['Time']).toDate();

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetails(
                                myDateTime,
                                myTimeDate,
                                document.data()['EventName'],
                                document.data()['Location'],
                                document.data()['Event_Fee'],
                                document.data()['Description'],
                                document.data()['lebel'],
                                document.data()['Open_Registeration'],
                                document.id),
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
                                    Color(0xffD76Ef5),
                                    Color(0xff3BB2BB)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff3BB2BB),
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
                                        myDateTime.month.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
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
            })
            );
  }
}
