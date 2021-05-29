import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';

class HistoryReport extends StatefulWidget {
  @override
  _HistoryReportState createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  @override
  Widget build(BuildContext context) {
    return Container();
//     User user = FirebaseAuth.instance.currentUser;
//         CollectionReference tickets = FirebaseFirestore.instance.collection('participant');
                    

//     return StreamBuilder<QuerySnapshot>(
//             stream: tickets.where("user_uid", isEqualTo: user.uid).snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return Center(child: Text('Something went wrong'));
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: Text("Loading"));
//               }
//               return new ListView(
//                   children: snapshot.data.docs.map((DocumentSnapshot document) {
//                 String userName = document.data()['userName'];
//                 String eventUid = document.data()['event_uid'];
//                 print(eventUid);
//                 Text("papega")
//                 // return  FutureBuilder(
//                 //   future: FirebaseFirestore.instance.collection('event').doc(eventUid).get(),
//                 //                   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshots) {
//                 //                     if(snapshots.hasData){
//                 //                                       DateTime _date = (snapshots.data()['Date']).toDate();

//                 //                                       DateTime _time = (snapshots.data()['Time']).toDate();
//                 //                     return Padding(
//                 //         padding: const EdgeInsets.only(top: 30.0),
//                 //         child: FlutterTicketWidget(
//                 //           width: 350.0,
//                 //           height: 350.0,
//                 //           color: Colors.red[700],
//                 //           isCornerRounded: true,
//                 //           child: Padding(
//                 //             padding: const EdgeInsets.all(20.0),
//                 //             child: Column(
//                 //               crossAxisAlignment: CrossAxisAlignment.start,
//                 //               children: <Widget>[
//                 //                 Row(
//                 //                   mainAxisAlignment:
//                 //                       MainAxisAlignment.spaceBetween,
//                 //                   children: <Widget>[
//                 //                     Container(
//                 //                       width: 120.0,
//                 //                       height: 25.0,
//                 //                       decoration: BoxDecoration(
//                 //                         borderRadius: BorderRadius.circular(30.0),
//                 //                         border: Border.all(
//                 //                             width: 1.0, color: Colors.white),
//                 //                       ),
//                 //                       child: Center(
//                 //                         child: Text(
//                 //                           'Participant',
//                 //                           style: TextStyle(color: Colors.white),
//                 //                         ),
//                 //                       ),
//                 //                     ),
//                 //                   ],
//                 //                 ),
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(top: 20.0),
//                 //                   child: Text(
//                 //                     snapshots.data["EventName"],
//                 //                     style: TextStyle(
//                 //                         color: Colors.white,
//                 //                         fontSize: 20.0,
//                 //                         fontWeight: FontWeight.bold),
//                 //                   ),
//                 //                 ),
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(top: 25.0),
//                 //                   child: Column(
//                 //                     children: <Widget>[
//                 //                       ticketDetailsWidget('Name',
//                 //                           userName, 'Date', "${_date.day} - ${_date.month} - ${_date.year} "),
//                 //                       Padding(
//                 //                         padding: const EdgeInsets.only(
//                 //                             top: 12.0, right: 40.0),
//                 //                         child: ticketDetailsWidget(
//                 //                             'Location',snapshots.data["Location"], 'TIME', "${_time.hour} : ${_time.minute} "),
//                 //                       ),
                                      
//                 //                     ],
//                 //                   ),
//                 //                 ),
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(
//                 //                       top: 30.0, left: 30.0, right: 30.0),
//                 //                   child: Container(
//                 //                     width: 250.0,
//                 //                     height: 60.0,
//                 //                     color: Colors.black,
//                 //                   ),
//                 //                 ),
//                 //                 Padding(
//                 //                   padding: const EdgeInsets.only(
//                 //                       top: 10.0, left: 75.0, right: 75.0),
//                 //                   child: Text(
//                 //                     '9824 0972 1742 1298',
//                 //                     style: TextStyle(
//                 //                       color: Colors.black,
//                 //                     ),
//                 //                   ),
//                 //                 )
//                 //               ],
//                 //             ),
//                 //           ),
                          
                          
//                 //         ),
//                 //       );
//                 //         }else
//                 //           return SizedBox();

                                  
//                 //   }
//                 //   );
                    
//                 }    
//               ).toList());

//               }
              
//               );


            
            
  
  
            

//   }
  
//   }


// Widget ticketDetailsWidget(String firstTitle, String firstDesc,
//     String secondTitle, String secondDesc) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.only(left: 12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               firstTitle,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 firstDesc,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.only(right: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               secondTitle,
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 4.0),
//               child: Text(
//                 secondDesc,
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           ],
//         ),
//       )
//     ],
//   );
}
}