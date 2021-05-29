import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EMMA/Pages/homepage.dart';

import 'package:EMMA/Pages/interest.dart';
import 'package:EMMA/services/authservice.dart';

// ignore: must_be_immutable
class UserDetailsForm extends StatefulWidget {
  UserDetailsForm({
    this.email,
    this.password,
  });
  String email;
  String password;

  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<UserDetailsForm>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();

  String _name;
  String _age;
  String _gender;
  String _mobile;
  String _role;

  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Personal Information"),
          backgroundColor: Colors.red,
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 30.0),
                             child: Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                           ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  
                                  new Flexible(
                                    child: new TextFormField(
                                      controller: nameController,
                                      onChanged: (value) => {_name = value},
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                      enabled: true,
                                      autofocus: true,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Text(
                                  'Accont Type',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 60),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),

                                  // dropdown below..
                                  child: DropdownButton<String>(
                                    value: _role,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.red,
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: SizedBox(),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _role = newValue;
                                      });
                                    },
                                    items: <String>['participant', 'organizer']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                    Container(
                                  child: new Text(
                                    'Age',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                
                                Expanded(child:SizedBox(),),
                                  Container(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: new Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: ageController,
                                        onChanged: (value) => {_mobile = value},
                                        decoration: InputDecoration(
                                        labelText: 'Age',
                                        labelStyle:
                                            TextStyle(color:Colors.black),
                                        fillColor: Colors.white,
                                        border: new OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                        enabled: true,
                                        autofocus: true,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                         right: 10),
                                    child: Container(
                                      height: 55,
                                      
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                      child: DropdownButton<String>(
                                      value: _gender,
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.red,
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: const TextStyle(color: Colors.black),
                                      underline: SizedBox(),
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _gender = newValue;
                                        });
                                      },
                                      items: <String>['Male', 'Female']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(color: Colors.black, ),
                                          ),
                                        );
                                      }).toList(),
                                  ),
                                    ),
                                  ),
                                ],
                              )),
                               Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),

                        child: Text(
                                    'Mobile',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: new Flexible(
                                child: new TextFormField(
                                  controller: mobileController,
                                  onChanged: (value) => {_mobile = value},
                                  keyboardType: TextInputType.number,
                                  decoration:   InputDecoration(
                                    labelText: 'Phone Number',
                                    labelStyle:
                                        TextStyle(color: Colors.black),
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Interest',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Interest()),
                          _getActionButtons(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Submit"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  print(widget.email);
                  print(widget.password);
                  print(_name);
                  print(_age);
                  print(_gender);
                  print(_mobile);
                  print(_role);
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: widget.email, password: widget.password);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                    return Future<bool>.value(false);
                  } finally {
                    User user = FirebaseAuth.instance.currentUser;

                    await FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.uid)
                        .set({
                      "name": _name,
                      "age": _age,
                      "gender": _gender,
                      "mobile": _mobile,
                      "role": _role,
                      "createdAt": FieldValue
                          .serverTimestamp(), // https://stackoverflow.com/questions/50907151/flutter-firestore-server-side-timestamp
                      "updatedAt": FieldValue.serverTimestamp(),
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Home(),
                            fullscreenDialog: true));
                  }
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
