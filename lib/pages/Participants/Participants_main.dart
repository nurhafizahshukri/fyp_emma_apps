
import 'package:EMMA/Pages/Participants/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:EMMA/Pages/Participants/report.dart';
import 'package:EMMA/services/authservice.dart';

class MainpageParticipant extends StatefulWidget {

  @override
  _MainpageParticipantState createState() => _MainpageParticipantState();
}
int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    DashboardParticipant(),
    HistoryReport(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = DashboardParticipant(); // Our first view 

class _MainpageParticipantState extends State<MainpageParticipant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Container(height: 45,),
                  new Image.asset(
                            "assets/images/logo_white.png",
                            height: 45.0,
                            fit: BoxFit.scaleDown,
                          ) ],
        ),
        backgroundColor: Colors.red[700],
        actions: <Widget>[
        IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              AuthService().signOut(context);
            }),
      ],
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.red[700],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Setting'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepOrange,
        //   child: Icon(Icons.history),
        //   onPressed: () {
        //               },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.red[700],
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            DashboardParticipant(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home_outlined,
                          color: currentTab == 0 ? Colors.orange[700] : Colors.orange[50]
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.orange[700] : Colors.orange[50]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HistoryReport(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 1 ? Colors.orange[700] : Colors.orange[50]
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.orange[700] : Colors.orange[50]
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}