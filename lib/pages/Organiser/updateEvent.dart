import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:EMMA/services/databaseservice.dart';

// ignore: must_be_immutable
class UpdateEvent extends StatefulWidget {
 
  DateTime date;
  DateTime endDate;
  String eventName;
  String location;
  String eventfee;
  String description;
  String label;
  String reg;
  DateTime regDate;
  String picName;
  String contact;
  String uid;
  UpdateEvent(this.date, this.endDate, this.eventName, this.location,
      this.eventfee, this.description, this.label, this.reg, this.regDate, this.picName, this.contact, this.uid);

  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd hh:mm a");
  final format1 = DateFormat("HH:mm");
  DateTime _date;
  DateTime _endDate;
  String _eventName;
  String _location;
  String _eventfee;
  String _description;
  String _label;
  String _reg;
  DateTime _regDate;
  String _picName;
  String _contact;

  final eventController = TextEditingController();

  final FocusScopeNode _node = FocusScopeNode();
  @override
  void dispose() {
    eventController.dispose();
    _node.dispose();
    super.dispose();
  }

  final TextEditingController dateController = new TextEditingController();
  final TextEditingController endDateController = new TextEditingController();
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController eventfeeController = new TextEditingController();
  final TextEditingController descriptionController =
      new TextEditingController();
  final TextEditingController labelController = new TextEditingController();
  final TextEditingController regController = new TextEditingController();
  final TextEditingController regDateController = new TextEditingController();
  final TextEditingController picNameController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  @override
  // ignore: must_call_super
  void initState() {
    dateController.text = widget.date.toString();
    endDateController.text = widget.endDate.toString();
    eventNameController.text = widget.eventName;
    locationController.text = widget.location;
    eventfeeController.text = widget.eventfee;
    descriptionController.text = widget.description;
    labelController.text = widget.label;
    regController.text = widget.reg;
    regDateController.text = widget.regDate.toString();
    picNameController.text = widget.picName;
    contactController.text = widget.contact;
    _date = widget.date;
    _endDate = widget.endDate;
    _eventName = widget.eventName;
    _location = widget.location;
    _eventfee = widget.eventfee;
    _description = widget.description;
    _label = widget.label;
    _reg = widget.reg;
    _regDate = widget.regDate;
    _picName = widget.picName;
    _contact = widget.contact;
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
                                      'Start Date Format: (${newformat.pattern})'),
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
                              controller: endDateController,
                              onChanged: (currentValue) => _endDate = currentValue,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                  ),
                                  labelText:
                                      'End Date Format: (${newformat.pattern})'),
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
                            controller: picNameController,
                            onChanged: (currentValue) => _picName= currentValue,
                            decoration: InputDecoration(
                              labelText: 'PIC Name',
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
                            controller: contactController,
                            onChanged: (currentValue) => _contact = currentValue,
                            decoration: InputDecoration(
                              labelText: 'PIC Contact Info',
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
                          Padding(padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              controller: regDateController,
                              onChanged: (currentValue) => _regDate = currentValue,
                              decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                    ),
                                labelText: 'Registration Deadline (${newformat.pattern})'
                              ),
                              format: newformat,
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ?? DateTime.now(),
                                    lastDate: DateTime(2100));
                              }),
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
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(180, 40)
                              ),
                              child: Text('Cancel'.toUpperCase(),
                                  style: TextStyle(fontSize: 20, color: Colors.red[600])),
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
      _endDate,
      _location,
      _eventfee,
      _description,
      _label,
      _reg,
      _regDate,
      _picName,
      _contact,
      widget.uid,
    );
  }
}
