import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:EMMA/services/databaseservice.dart';

// ignore: must_be_immutable
class RegisterEvent extends StatefulWidget {
  DateTime date;
  DateTime endDate;
  String eventName;
  String location;
  String eventfee;
  String username;
  String mobile;
  String uid;

  RegisterEvent(this.date, this.endDate, this.eventName, this.location,
      this.eventfee, this.uid,this.username,this.mobile);
  @override
  _RegisterEventState createState() => _RegisterEventState();
}

class _RegisterEventState extends State<RegisterEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  // ignore: unused_field
  DateTime _date;
  // ignore: unused_field
  DateTime _endDate;
  // ignore: unused_field
  String _eventName;
  // ignore: unused_field
  String _location;
  // ignore: unused_field
  String _eventfee;
  // ignore: unused_field
  String _description;
  // ignore: unused_field
  String _label;
  // ignore: unused_field
  String _reg;
  String _name;
  String _contact;
  final FocusScopeNode _node = FocusScopeNode();

  final eventController = TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController endDateController = new TextEditingController();
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController eventfeeController = new TextEditingController();
   final TextEditingController nameController = new TextEditingController();
  final TextEditingController mobileController = new TextEditingController();

  @override
  void dispose() {
    eventController.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  // ignore: must_call_super
  void initState() {
dateController.text = widget.date.toString();
    endDateController.text = widget.endDate.toString();
    eventNameController.text = widget.eventName;
    locationController.text = widget.location;
    eventfeeController.text = widget.eventfee;
    nameController.text=widget.username;
    mobileController.text=widget.mobile;
 
    _date = widget.date;
    _endDate = widget.endDate;
    _eventName = widget.eventName;
    _location = widget.location;
    _eventfee = widget.eventfee;
    _name=widget.username;
    _contact=widget.mobile;

   }

  // @override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Register event'),
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
                            enabled: false,
                            controller: eventNameController,
                            style:TextStyle(color: Colors.grey),
                          onChanged: (currentValue) => _eventName = currentValue,

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
                        controller: dateController,
                        style:TextStyle(color: Colors.grey),
                        enabled: false,
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
                        controller: endDateController,
                        style:TextStyle(color: Colors.grey),
                        enabled: false,
                        onChanged: (currentValue) => _endDate = currentValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: new BorderRadius.circular(25.0),),
                          labelText: 'End Date Format: (${format1.pattern})'
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
                            controller: locationController,
                            style:TextStyle(color: Colors.grey),
                            enabled: false,
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
                            controller:eventfeeController,
                            style:TextStyle(color: Colors.grey),
                            enabled: false,
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
                            controller: nameController,
                            onChanged: (currentValue) => _name = currentValue,
                            decoration: InputDecoration(
                              labelText: 'Name',
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
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Mobile can\'t be empty';
                                } else if (value.isNotEmpty) {
                                //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                                bool mobileValid =
                                RegExp(r'^(?:\+?88|0088)?01[13-9]\d{8}$').hasMatch(value);
                                return mobileValid ? null : "Invalid mobile";
                                }
                                return null;
                            },
                            onChanged: (currentValue) => _contact = currentValue,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
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
                                fixedSize: Size(280, 40)
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
                                fixedSize: Size(280, 40)
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
    DatabaseService().addParticipant(_name,_contact,widget.uid);

}

}