import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  String uid;

  Participants(this.uid);

  @override
  _ParticipantsState createState() => _ParticipantsState();
}


class _ParticipantsState extends State<Participants> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Participants List'),
          backgroundColor: Colors.red[700],
        ),
        body: StreamBuilder<QuerySnapshot>(
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
         return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                    color: Colors.red[700],
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(15.0, 16.0, 15.0, 0),
                    child: InkWell(
                      borderRadius: new  BorderRadius.circular(25.0),
                      splashColor: Colors.blue.withAlpha(30),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 350,
                          height: 100,
                          child: Row(
                            children: <Widget> [
                              Container(
                                width: 120,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snapshot.data.size.toString(),
                                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'REGISTERED',
                                      style: TextStyle(fontSize: 30, color: Colors.white),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      'PARTICIPANTS',
                                      style: TextStyle(fontSize: 20,color: Colors.white, fontStyle: FontStyle.italic),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),),
                Container(
                  height: 1300,
                  child: ListView(
                            padding: EdgeInsets.all(20),
                            children:  snapshot.data.docs.map((DocumentSnapshot document) {
                              return Card(
                                elevation: 5,
                                color: document.data()["payment"]? Colors.green[400]:Colors.red[400],
                                child: ListTile(
                                  dense: true,
                                  title: Text(document.data()["userName"],style: TextStyle(color:Colors.black, fontSize: 20 , fontWeight: FontWeight.bold),),
                                  subtitle: Text(document.data()["userContact"],style: TextStyle(color:Colors.black, fontSize: 18 ),),
                                  trailing: Text(document.data()["payment"]? "Paid" : "Unpaid",style: TextStyle(color:Colors.black, fontSize: 18, fontStyle: FontStyle.italic ),),
                                ),
                              )
                              // Container(
                              //   padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                              //   // height: 35,
                              //   color: document.data()["payment"]? Colors.green[300]:Colors.red[100],
                              //   child: Row(
                              //     mainAxisAlignment:MainAxisAlignment.spaceBetween ,children:<Widget> [
                              //     Column(
                              //       children: [
                              //         Text(document.data()["userName"] + " (" +document.data()["userContact"] +")",style: TextStyle(color:Colors.black, fontSize: 18 ),),
                              //       ],
                              //     ),
                                  // Text(document.data()["userContact"],style: TextStyle(color:Colors.black, fontSize: 18 ),),
                              //     Text(document.data()["payment"]? "Paid" : "Unpaid",style: TextStyle(color:Colors.black, fontSize: 18, fontStyle: FontStyle.italic ),),
        
                              //   ],),
                              // )
                            ;}
                            ).toList(),
                          )
                        
                ),
              ],
            ),
          ),
        );
                            })
    );
  }
}