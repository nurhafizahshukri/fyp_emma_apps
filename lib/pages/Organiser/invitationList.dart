import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InviteeList extends StatefulWidget {
String uid;

InviteeList(this.uid);

  @override
  _InviteeListState createState() => _InviteeListState();
}

class _InviteeListState extends State<InviteeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Invitee List'),
          backgroundColor: Colors.red[700],
        ),
      body: StreamBuilder<QuerySnapshot>(
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
            return Container(
              child: new ListView(
                padding: EdgeInsets.all(20),
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    // color: Colors.yellow,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget> [ 
                        Container(
                          padding: EdgeInsets.all(9),
                          width: 530,
                          decoration: BoxDecoration(
                            color: Colors.red[800],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              document.data()["userName"].toUpperCase(),
                              style: TextStyle(color:Colors.white, fontSize: 20, fontFamily: 'Roboto' ),
                            ),
                          )
                        ),
                        Expanded(
                          flex: 3,
                            child: new ListView.builder(
                              itemCount: document["email"].length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                List<String> email = List.from(document.data()["email"]);
                                return Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 30,
                                  color: Colors.red[100],
                                  child: 
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: new Text(
                                      email[index],
                                      style: TextStyle(color:Colors.black)
                                    ),
                                  )
                                );
                              }),
                        ),
                      ]
                    ),
                  );
                }
                ).toList(),
              ),
            );
          }
          )
      );
  }
}