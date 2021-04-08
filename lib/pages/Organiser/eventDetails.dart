import 'package:flutter/material.dart';

class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final FocusScopeNode _node = FocusScopeNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [ 
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Stack(
                  children: <Widget> [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [Color(0xff42E695), Color(0xff3BB2BB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff3BB2BB),
                            blurRadius:12,
                            offset: Offset(0,6) )
                        ])
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
                                    '20',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black
                                    ),
                                  ),
                                  Text(
                                    'NOV',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                    ),
                                  )
                                ],),
                            )
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                    'GEMA UTM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                    ),),
                                  SizedBox(height: 15),
                                  Text(
                                    'Dewan Sultan Ismail',
                                    style: TextStyle(
                                      color: Colors.grey[100],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],),
                    )
                ]
            ),),
            Padding (
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    Text('COMING SOON',
                    style: TextStyle(
                        color: Colors.pink[800],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),),
                    SizedBox(height: 15),
                    Text(
                      'GEMA UTM',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),),
                  ],),),),
            Padding (
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Container(
                  child: 
                      Column(
                        children: <Widget> [
                          Row(children: <Widget> [
                            Icon(Icons.calendar_today),
                            SizedBox(width: 10),
                            Text('20 November 2021 (Saturday)'),
                          ],),
                          Row(children: <Widget>[
                            Icon(Icons.location_pin),
                            SizedBox(width: 10),
                            Text('Dewan Sultan Ismail, UTM'),
                          ],),
                          Row(children:<Widget> [
                            Icon(Icons.attach_money_sharp),
                            SizedBox(width: 10),
                            Text('RM 20.00'),
                          ],),
                          Row(children:<Widget> [
                            Icon(Icons.label_important_outline_sharp),
                            SizedBox(width: 10),
                            Text('Awards'),
                          ],),
                      ],)
                      
                ),),
            Padding (
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: 
                      Column(
                        children: <Widget> [
                          Row(children: <Widget> [
                            Text('About',
                              style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                      ),),
                      ],), SizedBox(height: 10),
                          Row(children: <Widget>[
                            Flexible(
                              child: Text(
                                'Majlis diadakan bertujuan untuk menghargai setiap pencapaian mahasiswa UTM pada sesi 2019/2020, daripada pelbagai kategori aktiviti pembangunan pelajar merangkumi aspek kepimpinan, kebudayaan, kesukarelawanan, dan inovasi. Secara keseluruhannya, terdapat 31 anugerah yang dipertandingkan, termasuk anugerah utama iaitu Anugerah Naib Canselor.',
                                textAlign: TextAlign.justify,
                                )),
                          ],),
                      ],)
                      
                ),),
            Padding (
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: 
                      Column(
                        children: <Widget> [
                          Row(children: <Widget> [
                            Text('Invitation',
                              style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                      ),),
                      ],), SizedBox(height: 10),
                          Row(children: <Widget>[
                           Text(
                                'No invitation sent',
                            ),SizedBox(width: 5),
                           Text(
                                'Send one now',
                                style: TextStyle(
                              color: Colors.blue,
                      ),
                           )
                          ],),
                      ],)
                ),),
            Padding (
              padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                child: Container(
                  // constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                  child: 
                      Column(
                        children: <Widget> [
                          Row(children: <Widget> [
                            Text('Report',
                              style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                      ),),
                      ],), SizedBox(height: 10),
                          Row(children: <Widget>[
                           Text(
                                'Report not generate yet',
                                ),
                            Text(
                                'Generate one now',
                                style: TextStyle(
                                color: Colors.blue,
                                ),
                           )
                          ],),
                      ],)
                ),),
            
            
          ]
        ),
      ),  
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                     ButtonTheme(
                        minWidth: 180.0,
                        // height: 40.0,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.red[600],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red[600])
                          ),
                          child: Text('Edit'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                          ),
                      ButtonTheme(
                        minWidth: 180.0,
                        // height: 40.0,
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.red[600],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red[600])
                          ),
                          child: Text('Delete'.toUpperCase(), style: TextStyle(fontSize: 20)),
                        ),
                          ),
                    ],),
          ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}