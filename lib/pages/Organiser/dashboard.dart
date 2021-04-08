import 'package:EMMA/model/class.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var items = [
    EventInfo('GEMA UTM', 'Dewan Sultan Ismail',Color(0xff42E695), Color(0xff3BB2BB)),
    EventInfo('SEGA KTDI', 'Dewan Sri Resak',Color(0xffFFB157), Color(0xffFFA057)),
    EventInfo('Jom Sihat UTM', 'Padang UTM',Color(0xffFF5895), Color(0xffF8556D)),
    EventInfo('GEMA UTM', 'Dewan Sultan Ismail',Color(0xffD76Ef5), Color(0xff8F7AFE)),
    EventInfo('GEMA UTM', 'Dewan Sultan Ismail',Color(0xff6DC8F3), Color(0xff73A1F9)),
    EventInfo('GEMA UTM', 'Dewan Sultan Ismail',Color(0xff42E695), Color(0xff3BB2BB)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Center(
          child: 
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Stack(
                children: <Widget> [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [items[index].startColor, items[index].endColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: items[index].endColor,
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
                                  items[index].eventName.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),),
                                Text(
                                  items[index].location.toUpperCase(),
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
            ),)
          );
        },)
      
      
    );
  }
}