import 'package:EMMA/pages/Organiser/sendInvitation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:EMMA/Comman_widget/Flat_button.dart';
import 'package:EMMA/Pages/Organiser/eventreportform.dart';
import 'package:EMMA/Pages/Organiser/updateEvent.dart';
import 'package:EMMA/services/databaseservice.dart';

// ignore: must_be_immutable
class EventDetails extends StatefulWidget {
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime endTime = DateTime.now();
  String eventName = "";
  String location = "";
  String eventfee = "";
  String description = "";
  String label = "";
  String reg = "";
  String uid = "";
  EventDetails(
    this.date,
    this.time,
    this.endDate,
    this.endTime,
    this.eventName,
    this.location,
    this.eventfee,
    this.description,
    this.label,
    this.reg,
    this.uid,
  ) {
    print(date);
    print(time);
    print(endDate);
    print(endTime);
    print(eventName);
    print(location);
    print(eventfee);
    print(description);
    print(label);
    print(reg);
  }

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final FocusScopeNode _node = FocusScopeNode();
  final newformat = DateFormat("MMMM");
  final format1 = DateFormat("HH:mm");
  CollectionReference participant =
      FirebaseFirestore.instance.collection('participant');
  final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    DateTime formattedDate = formatter.parse(now.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Stack(children: <Widget>[
                Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                            colors: [Color(0xff42E695), Color(0xff3BB2BB)],
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
                                  widget.date.day.toString(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  "${months[widget.date.month-1]}",
                                  //  widget.date.month.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.eventName != null ? widget.eventName : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              widget.location != null ? widget.location : '',
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
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      // 'COMING SOON',
                      widget.date.compareTo(formattedDate)>0 ? 'COMING SOON': widget.date.compareTo(formattedDate)<0 && widget.endDate.compareTo(formattedDate)<0? 'ENDED':'ONGOING',
                      style: TextStyle(
                        color: Colors.pink[800],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      widget.eventName,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(width: 10),
                      Text(widget.date.toString() == widget.endDate.toString()
                          ? "${widget.date.day} / ${widget.date.month} / ${widget.date.year} ( ${format1.format(widget.time)} ) "
                          : "${widget.date.day} / ${widget.date.month} / ${widget.date.year} ( ${format1.format(widget.time)} ) - ${widget.endDate.day} / ${widget.endDate.month} / ${widget.endDate.year} ( ${format1.format(widget.endTime)} ) "),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_pin),
                      SizedBox(width: 10),
                      Text(widget.location != null ? widget.location: ''),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money_sharp),
                      SizedBox(width: 10),
                      Text(widget.eventfee != null ? 'RM '+widget.eventfee : 'FOC'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.label_important_outline_sharp),
                      SizedBox(width: 10),
                      Text(widget.label != null ? widget.label.toUpperCase() : ''),
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'About',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        widget.description != null ? widget.description : '',
                        textAlign: TextAlign.justify,
                      )),
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Participant',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ],
                    
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('event').doc(widget.uid).collection("participant").snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: Text('Something went wrong'));
                          }
                          if(!snapshot.hasData)
                          return Center(child: Text('No participant'));

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Text("Loading"));
                          }
                          return new ListView(
                            children:  snapshot.data.docs.map((DocumentSnapshot document) {
                              return Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,children:<Widget> [
                                Text(document.data()["userName"],style: TextStyle(color:document.data()["payment"]? Colors.green:Colors.black ),),
                                
                                Text(document.data()["userContact"],style: TextStyle(color:document.data()["payment"]? Colors.green:Colors.black ),),

                              ],)
                            ;}
                            ).toList(),
                          );
                        }),
                  )
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Invitation',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('event').doc(widget.uid).collection("invitee").snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Something went wrong'));
                            }
                            if(!snapshot.hasData)
                            return Center(child: Text('No Invitee'));
                      
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: Text("Loading"));
                            }
                            return new ListView(
                              children:  snapshot.data.docs.map((DocumentSnapshot document) {
                                return Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,children:<Widget> [
                                  Text(document.data()["userName"],style: TextStyle(color:Colors.black ),),
                                  
                                  Text(document.data()["email"],style: TextStyle(color:Colors.black ),),
                                ],)
                              ;}
                              ).toList(),
                            );
                          }),
                  ),
                  Row(
                    children: <Widget>[
                      Visibility(
                     visible: widget.date.compareTo(now)<0 ? false : true,
                     child: Flatbutton(
                            fontsize: 15,
                            icon: Icon(Icons.document_scanner, color:  Colors.red,),
                            colortext: Colors.red,
                            text: "Send Invitation",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SendInvitation(widget.date, widget.time, widget.eventName, widget.location, widget.uid)
                                )
                                );
                            },
                          ),
                   )
                    ],
                  ),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Report',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 25,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[                      
                   Visibility(
                     visible: widget.date.compareTo(now)>0 ? false : true,
                     child: Flatbutton(
                            fontsize: 15,
                            icon: Icon(Icons.document_scanner, color:  Colors.red,),
                            colortext: Colors.red,
                   
                            text: "create a report",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadingImageToFirebaseStorage(widget.date, widget.time, widget.eventName, widget.location, widget.eventfee, widget.uid )
                                )
                                );
                            },
                          ),
                   )
                      ],
                  ),
                                  ],
              )),
            ),
          ]),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 180.0,
              // height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateEvent(
                                widget.date,
                                widget.time,
                                widget.eventName,
                                widget.location,
                                widget.eventfee,
                                widget.description,
                                widget.label,
                                widget.reg,
                                widget.uid,
                              ),
                          fullscreenDialog: true));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[600],
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  side: BorderSide(color: Colors.red[600]),
                  fixedSize: Size(180, 40)
                ),
                child:
                    Text('Edit'.toUpperCase(), style: TextStyle(fontSize: 20)),
              ),
            ),
            ButtonTheme(
              minWidth: 180.0,
              // height: 40.0,
              child: ElevatedButton(
                onPressed: () {
                  DatabaseService().deleteEvent(widget.uid);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[600],
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  side: BorderSide(color: Colors.red[600]),
                  fixedSize: Size(180, 40)
                ),
                child: Text('Delete'.toUpperCase(),
                    style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
