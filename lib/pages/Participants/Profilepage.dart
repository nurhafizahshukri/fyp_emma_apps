import 'package:EMMA/pages/Participants/ProfileEdit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);
        
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: user.snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshotuser) {
                  //signOut()
              if (snapshotuser.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (snapshotuser.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)); 
              }
            return new SafeArea(
            child: Card(
              // color: Colors.red,
              margin: EdgeInsets.fromLTRB(20, 60, 20, 40),
               elevation: 10,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Text(
                        'Hi, ' + snapshotuser.data['name'] + ' !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              
                    // CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: AssetImage('assets/images/profile.png'),
                    // // ),
                    SizedBox(
                      height: 15,
                      width: 150,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    InfoCard(
                      text: snapshotuser.data['name'],
                      icon: Icons.perm_identity,
                    ),
                    InfoCard(
                      text: snapshotuser.data['gender'],
                      icon: Icons.wc,
                    ),
                    InfoCard(
                      text: snapshotuser.data['mobile'],
                      icon: Icons.phone,
                     
                    ),
                    InfoCard(
                      text: FirebaseAuth.instance.currentUser.email,
                      icon: Icons.email,
                     
                    ),
                    InfoCard(
                      text: snapshotuser.data['interest'],
                      icon: Icons.favorite,
                     
                    ),
                    SizedBox(
                      height: 15,
                      width: 150,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileEdit(
                              snapshotuser.data['name'],
                              snapshotuser.data['gender'],
                              snapshotuser.data['age'],
                              snapshotuser.data['mobile'],
                              FirebaseAuth.instance.currentUser.uid
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
                  ],
                ),
              ),
              
            ),
          );}
      ),
      );
  }
}



class InfoCard extends StatelessWidget{
    final String text;
    final IconData icon;
    Function onPressed;

    InfoCard({@required this.text, @required this.icon, this.onPressed});

    @override
  Widget build(BuildContext context){
    return GestureDetector(
              onTap: onPressed,
              child: Flexible(
                flex: 3,
                child: Card(
                  //color:Colors.cyan[800],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan[800], width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:EdgeInsets.symmetric(vertical:10.0,horizontal:20.0),
                  child: ListTile(
                    leading: Icon(
                      icon,
                      color: Colors.cyan[800],
                      
                    ),
                    title: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Source San Pro',
                        fontSize: 18.0,
                        color: Colors.black,
              
                      ),
              
                    )
                  ),
                ),
              ),
            );
  }
}