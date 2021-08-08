import 'package:EMMA/pages/interest.dart';
import 'package:EMMA/services/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileEdit extends StatefulWidget {

  String name;
  String gender;
  String age;
  String mobile;
  String uid;

  ProfileEdit(this.name, this.gender, this.age, this.mobile, this.uid);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController ageController = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();

  String _name;
  String _age;
  String _gender;
  String _mobile;
  List<String> _interest;
  String uid;
  
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    nameController.text = widget.name;
    ageController.text = widget.age;
    genderController.text = widget.gender;
    mobileController.text = widget.mobile;
    _name = widget.name;
    _age = widget.age;
    _gender = widget.gender;
    _mobile = widget.mobile;
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
              Form(
                key: _formKey,
                child: Column(
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
                                        textInputAction: TextInputAction.next,
                                        controller: nameController,
                                        onChanged: (value) => {_name = value},
                                        decoration: InputDecoration(
                                          labelText: 'First name, last name',
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          controller: ageController,
                                          onChanged: (value) => {_age = value},
                                          decoration: InputDecoration(
                                          labelText: 'e.g 22',
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                    textInputAction: TextInputAction.next,
                                    controller: mobileController,
                                    onChanged: (value) => {_mobile = value},
                                    keyboardType: TextInputType.number,
                                    decoration:   InputDecoration(
                                      labelText: 'e.g 0123456789',
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                child: Interest((value) {
                                  return _interest = value;
                                }),),
                            _getActionButtons(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[600],
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      side: BorderSide(color: Colors.red[600]),
                      fixedSize: Size(380, 40)
                    ),
                child: new Text("Submit"),
                onPressed: () {
                  onSubmit();
                  Navigator.of(context).pop();
                },
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
    Future<void> onSubmit() async {
    String a =_interest.join(",");
    final formState = _formKey.currentState;
    formState.save();
    DatabaseService().updateProfile(
      _name, 
      _gender, 
      _age, 
      _mobile, 
      a, 
      FirebaseAuth.instance.currentUser.uid
    );
    print('object');
    print(_name);
    print(_gender);
    print(_age);
    print(_mobile);
    print(FirebaseAuth.instance.currentUser.uid);
  }
}