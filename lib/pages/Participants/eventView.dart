import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:intl/intl.dart';
import 'package:EMMA/Comman_widget/Submit_button.dart';
import 'package:EMMA/Pages/Participants/Register_event.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:EMMA/Pages/Participants/payment.dart';

// ignore: must_be_immutable
class EventView extends StatefulWidget {
  DateTime date = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime regDate = DateTime.now();
  String eventName = "";
  String location = "";
  String eventfee = "";
  String description = "";
  String label = "";
  String reg = "";
  String picName = "";
  String picContact = "";
  String uid = "";
  String username="";
  String mobile = "";
  EventView(
    this.date,
    this.endDate,
    this.regDate,
    this.eventName,
    this.location,
    this.eventfee,
    this.description,
    this.label,
    this.reg,
    this.picName,
    this.picContact,
    this.uid,
    this.username,
    this.mobile,
  ) {
    print(date);
    print(endDate);
    print(eventName);
    print(location);
    print(eventfee);
    print(description);
    print(label);
    print(reg);
  }

 Event buildEvent({Recurrence recurrence}) {
    return Event(
      title: '$eventName',
      description: '$description',
      location: '$location',
      startDate: date,
      endDate: date.add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
      ),
      androidParams: AndroidParams(
      ),
      recurrence: recurrence,
    );
  }
  @override
  _EventViewState createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  final FocusScopeNode _node = FocusScopeNode();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  final months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  User user = FirebaseAuth.instance.currentUser;
  bool isRegisterd=false;
  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    var formatter2 = new DateFormat('dd-MM-yyyy (hh:mm a)');
    DateTime formattedDate = formatter.parse(now.toString());
    DateTime formattedEventDate = formatter.parse(widget.date.toString());
    DateTime formattedEventEndDate = formatter.parse(widget.endDate.toString());
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
                      formattedEventDate.compareTo(formattedDate)>0 ? 'COMING SOON': formattedEventDate.compareTo(formattedDate)<0 && formattedEventEndDate.compareTo(formattedDate)<0? 'ENDED':'ONGOING',
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
                      Text(
                        (widget.date.day.toString() == widget.endDate.day.toString()) && widget.date.month.toString() == widget.endDate.month.toString()
                          ? formatter2.format(widget.date)
                          : formatter2.format(widget.date) + ' - ' + formatter2.format(widget.endDate)
                        ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.location_pin),
                      SizedBox(width: 10),
                      Text(widget.location != null ? widget.location : ''),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money_sharp),
                      SizedBox(width: 10),
                      Text(widget.eventfee != 'RM 0.00' ? widget.eventfee : 'FREE'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.label_important_outline_sharp),
                      SizedBox(width: 10),
                      Text(widget.label != null ? widget.label : ''),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.call),
                      SizedBox(width: 10),
                      Text(widget.picContact != null ? widget.picContact +' ( ' + widget.picName + ' )' : ''),
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
                          fontSize: 20,
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
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Text(
                        'Registration Deadline',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Text(widget.reg =="Yes" ?
                            formatter2.format(widget.regDate) : "Registration Unavailable",
                            textAlign: TextAlign.justify,
                      )),
                    ],
                  ),
                ],
              )),

            ),
      

      
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('event').doc(widget.uid).collection("participant").where(
                      "user_uid",isEqualTo: user.uid
                    )
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshotuser) {
                  if (snapshotuser.hasData&& snapshotuser.data.size>0) {
                            // ignore: unused_local_variable
                            DocumentSnapshot queryDocumentSnapshot = snapshotuser.data.docs.first;
                    if(  snapshotuser.data.docs[0]["payment"]==false)
                    {
                      return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                       child: FormSubmitButton(
                        color: Colors.red,
                        colortext: Colors.white,
                        text: 'Make Payment'.toUpperCase(),
                        onPressed:(){
                           Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentInfo(widget.eventfee,widget.uid,snapshotuser.data.docs[0].id)
                            )
                            );
                        } ),
                       );
                    }
                    else
                    {return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                       child: 
                      FlutterTicketWidget(
                        width: 350.0,
                        height: 350.0,
                        color: Colors.red[700],
                        isCornerRounded: true,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 120.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.white),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Participant',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  widget.eventName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Column(
                                  children: <Widget>[
                                    ticketDetailsWidget('Name',
                                        snapshotuser.data.docs[0]["userName"], 'Date', "${widget.date.day} - ${widget.date.month} - ${widget.date.year} "),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 40.0),
                                      child: ticketDetailsWidget(
                                          'Location', widget.location, 'TIME', "${widget.date.hour} : ${widget.date.minute} "),
                                    ),
                                    
                                  ],
                                ),
                              ),
                              SizedBox(height:20),
                              FormSubmitButton(
                        color: Colors.red,
                        colortext: Colors.white,
                        text: 'Save to Google Calender'.toUpperCase(),
                        onPressed: (){
                          Add2Calendar.addEvent2Cal(
                  widget.buildEvent(),
                );
                        }),
                            ],
                          ),
                        ),
                      ),
                    );}
                    
                  } else
                    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              minWidth: 180.0,
              // height: 40.0,
              child: ElevatedButton(
                onPressed: (widget.reg =="Yes") && (formattedDate.compareTo(widget.regDate)<=0)? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterEvent(
                                widget.date,
                                widget.endDate,
                                widget.eventName,
                                widget.location,
                                widget.eventfee,
                                widget.uid,
                                widget.username,
                                widget.mobile,
                              ),
                          fullscreenDialog: true));
                } : null,
                          style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                // side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(280, 40)
                              ),

                child: Text('Register'.toUpperCase(),
                    style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      );
                })
          ]),
        ),
      ),
     
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              secondTitle,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}