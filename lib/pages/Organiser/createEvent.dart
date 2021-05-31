import 'package:EMMA/services/databaseservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class CreateEvent extends StatefulWidget {

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  DateTime _date;
  DateTime _time;
  String _eventName;
  String _location;
  String _eventfee;
  String _description;
  String _lebel;
  String _reg;
  final FocusScopeNode _node = FocusScopeNode();

  final eventController = TextEditingController();

  @override
  void dispose() {
    eventController.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  void initState() {
   // TODO
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text('Create event'),
        backgroundColor: Colors.red[700],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: FocusScope(
              node: _node,
              child: Container(
                margin: EdgeInsets.fromLTRB(40, 25, 40, 0),
                    // height: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                          onChanged: (currentValue) => _eventName = currentValue,

                            // onEditingComplete: _node.nextFocus,
                            // ignore: missing_return
                            // validator: (input) {
                            //   if(input.isEmpty || !input.contains('@')){
                            //     return 'Invalid email!';
                            //   }
                            // },
                            // onSaved: (input) => _email = input,
                            decoration: InputDecoration(
                              labelText: 'Event Name',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(8.0),
                      child: DateTimeField(
                        onChanged: (currentValue) => _date = currentValue,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                          labelText: 'Date Format: (${newformat.pattern})'
                        ),
                        format: newformat,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100)
                            );
                        },
                      ),
                    ),
                        Padding(padding: const EdgeInsets.all(8.0),
                      child:DateTimeField(
                        onChanged: (currentValue) => _time = currentValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),),
                          labelText: 'Time Format: (${format1.pattern})'
                        ),
                        format: format1,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                      ), ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                                                    onChanged: (currentValue) => _location = currentValue,

                            decoration: InputDecoration(

                              labelText: 'Event Location',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                                                    onChanged: (currentValue) => _eventfee = currentValue,

                            decoration: InputDecoration(
                              labelText: 'Event Fee (RM)',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                                                    onChanged: (currentValue) => _description = currentValue,

                            decoration: InputDecoration(
                              labelText: 'Event Description',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                                                    onChanged: (currentValue) => _lebel = currentValue,

                            decoration: InputDecoration(
                              labelText: 'Label (Sports,Seminar etc)',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                              onChanged: (currentValue) => _reg = currentValue,

                            decoration: InputDecoration(
                              labelText: 'Open for registration (Yes / No)',
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              )
                            )
                          ),
                        ),
                        SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {onSubmit();
                              Navigator.of(context).pop();},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(380, 40)
                              ),
                              child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 20)),
                            ),
                        ),
                        SizedBox(height: 15),
                        ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () { },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(380, 40)
                              ),
                              child: Text('Reset'.toUpperCase(), style: TextStyle(fontSize: 20)),
                            ),
                        ),
                      ])
              ),
            ),),
        ),
      )
    );
  }
  Future <void> onSubmit() async {
  final formState = _formKey.currentState;
  
    formState.save();
    DatabaseService().addEvent(_eventName,_date,_time,_location,_eventfee,_description,_lebel,_reg);

}

}