import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:EMMA/services/databaseservice.dart';

class UpdateEvent extends StatefulWidget {
 
  DateTime date;
  DateTime time;
  String eventName;
  String location;
  String eventfee;
  String description;
  String label;
  String reg;
  String uid;
  UpdateEvent(this.date, this.time, this.eventName, this.location,
      this.eventfee, this.description, this.label, this.reg, this.uid);

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  DateTime _date;
  DateTime _time;
  String _eventName;
  String _location;
  String _eventfee;
  String _description;
  String _label;
  String _reg;

  final eventController = TextEditingController();

  final FocusScopeNode _node = FocusScopeNode();
  @override
  void dispose() {
    eventController.dispose();
    _node.dispose();
    super.dispose();
  }

  final TextEditingController dateController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController eventfeeController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController labelController = new TextEditingController();
  final TextEditingController regController = new TextEditingController();
  @override
  void initState() {
    dateController.text = widget.date.toString();
    timeController.text = widget.time.toString();
    eventNameController.text = widget.eventName;
    locationController.text = widget.location;
    eventfeeController.text = widget.eventfee;
    descriptionController.text = widget.description;
    labelController.text = widget.label;
    regController.text = widget.reg;
    _date = widget.date;
    _time = widget.time;
    _eventName = widget.eventName;
    _location = widget.location;
    _eventfee = widget.eventfee;
    _description = widget.description;
    _label = widget.label;
    _reg = widget.reg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update event'),
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
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: eventNameController,
                                onChanged: (currentValue) =>
                                    _eventName = currentValue,

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
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              controller: dateController,
                              onChanged: (currentValue) => _date = currentValue,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                  ),
                                  labelText:
                                      'Date Format: (${newformat.pattern})'),
                              format: newformat,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              controller: timeController,
                              onChanged: (currentValue) => _time = currentValue,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                  ),
                                  labelText:
                                      'Time Format: (${format1.pattern})'),
                              format: format1,
                              onShowPicker: (context, currentValue) async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );
                                return DateTimeField.convert(time);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: locationController,
                                onChanged: (currentValue) =>
                                    _location = currentValue,
                                decoration: InputDecoration(
                                    labelText: 'Event Location',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: eventfeeController,
                                onChanged: (currentValue) =>
                                    _eventfee = currentValue,
                                decoration: InputDecoration(
                                    labelText: 'Event Fee (RM)',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: descriptionController,
                                onChanged: (currentValue) =>
                                    _description = currentValue,
                                decoration: InputDecoration(
                                    labelText: 'Event Description',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: labelController,
                                onChanged: (currentValue) =>
                                    _label = currentValue,
                                decoration: InputDecoration(
                                    labelText: 'Label (Sports,Seminar etc)',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: regController,
                                onChanged: (currentValue) =>
                                    _reg = currentValue,
                                decoration: InputDecoration(
                                    labelText:
                                        'Open for registration (Yes / No)',
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(25.0),
                                    ))),
                          ),
                          SizedBox(height: 20),
                          ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {
                                onSubmit();
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(180, 40)
                              ),
                              child: Text('Submit'.toUpperCase(),
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          SizedBox(height: 15),
                          ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(180, 40)
                              ),
                              child: Text('Reset'.toUpperCase(),
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ])),
              ),
            ),
          ),
        ));
  }

  Future<void> onSubmit() async {
    final formState = _formKey.currentState;
    formState.save();
    DatabaseService().updateEvent(
      _eventName,
      _date,
      _time,
      _location,
      _eventfee,
      _description,
      _label,
      _reg,
      widget.uid,
    );
  }
}
