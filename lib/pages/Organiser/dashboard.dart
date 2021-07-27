import 'package:EMMA/Comman_widget/Custom_card.dart';
import 'package:EMMA/pages/Organiser/eventDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final format1 = DateFormat("HH:mm");
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
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    DateTime formattedDate = formatter.parse(now.toString());
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: event
            .where('Creator_Uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
            // .orderBy("Date",descending:true)
            .snapshots(),
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
                DateTime regDate = (document.data()['Registration']).toDate();
                index += 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetails(
                                myDateTime,
                                myTimeDate,
                                myEndDateTime,
                                myEndTimeDate,
                                document.data()['EventName'],
                                document.data()['Location'],
                                document.data()['Event_Fee'],
                                document.data()['Description'],
                                document.data()['label'],
                                document.data()['Open_Registration'],
                                regDate,
                                document.data()['PIC_Name'],
                                document.data()['PIC_Contact'],
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
                                  colors: (document.data()['label'] == 'conferences') || (document.data()['label'] == 'seminar') || (document.data()['label'] == 'workshops')? [
                                    newColor[0].first,
                                    newColor[0].last
                                  ] : (document.data()['label'] == 'expo') || (document.data()['label'] == 'award') || (document.data()['label'] == 'festival')? [
                                    newColor[1].first,
                                    newColor[1].last
                                  ] : (document.data()['label'] == 'leadership') || (document.data()['label'] == 'volunteers') || (document.data()['label'] == 'self improvement')? [
                                    newColor[2].first,
                                    newColor[2].last
                                  ] : (document.data()['label'] == 'creative') || (document.data()['label'] == 'cooking') || (document.data()['label'] == 'art')? [
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
                                    color: (document.data()['label'] == 'conferences') || (document.data()['label'] == 'seminar') || (document.data()['label'] == 'workshops')?
                                    newColor[0].last
                                   : (document.data()['label'] == 'expo') || (document.data()['label'] == 'award') || (document.data()['label'] == 'festival')? 
                                    newColor[1].last
                                   : (document.data()['label'] == 'leadership') || (document.data()['label'] == 'volunteers') || (document.data()['label'] == 'self improvement')? 
                                    newColor[2].last
                                   : (document.data()['label'] == 'creative') || (document.data()['label'] == 'cooking') || (document.data()['label'] == 'art')? 
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
                          painter: CustomCardShapePainter(24,
                              (document.data()['label'] == 'conferences') || (document.data()['label'] == 'seminar') || (document.data()['label'] == 'workshops')?
                                    newColor[0].first
                                   : (document.data()['label'] == 'expo') || (document.data()['label'] == 'award') || (document.data()['label'] == 'festival')? 
                                    newColor[1].first
                                   : (document.data()['label'] == 'leadership') || (document.data()['label'] == 'volunteers') || (document.data()['label'] == 'self improvement')? 
                                    newColor[2].first
                                   : (document.data()['label'] == 'creative') || (document.data()['label'] == 'cooking') || (document.data()['label'] == 'art')? 
                                    newColor[3].first
                                   : newColor[4].first, 
                                   
                                   (document.data()['label'] == 'conferences') || (document.data()['label'] == 'seminar') || (document.data()['label'] == 'workshops')?
                                    newColor[0].last
                                   : (document.data()['label'] == 'expo') || (document.data()['label'] == 'award') || (document.data()['label'] == 'festival')? 
                                    newColor[1].last
                                   : (document.data()['label'] == 'leadership') || (document.data()['label'] == 'volunteers') || (document.data()['label'] == 'self improvement')? 
                                    newColor[2].last
                                   : (document.data()['label'] == 'creative') || (document.data()['label'] == 'cooking') || (document.data()['label'] == 'art')? 
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
                                        // myDateTime.month.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                                ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document.data()['EventName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    document.data()['Location'],
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      myDateTime.toString() == myEndDateTime.toString()
                                        ? "${myDateTime.day}/${myDateTime.month}/${myDateTime.year}"
                                        : "${myDateTime.day}/${myDateTime.month}/${myDateTime.year} - ${myEndDateTime.day}/${myEndDateTime.month}/${myEndDateTime.year}",
                                        style: TextStyle(
                                        color: Colors.grey[100],
                                        fontWeight: FontWeight.w500,
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
                                          document.data()['label'].toUpperCase(),
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
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                  myDateTime.compareTo(formattedDate)>0 ? 'Coming\nSoon': myDateTime.compareTo(formattedDate)<0 && myEndDateTime.compareTo(formattedDate)<0? 'Ended':'Ongoing',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                                ),
                                ],
                              ),)
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
