import 'package:EMMA/model/class.dart';
import 'package:EMMA/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {

  final EventInfo eventInfo;

  CreateEvent({this.eventInfo});

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  String _date, _time;
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
    final entryProvider = Provider.of<EventProvider>(context,listen: false);
    if (widget.eventInfo != null){
      //Edit
      eventController.text = widget.eventInfo.eventName;

      entryProvider.loadAll(widget.eventInfo);
    } else {
      //Add
      entryProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        onChanged: (currentValue) => _date = newformat.format(currentValue),
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
                        onChanged: (currentValue) => _time = format1.format(currentValue),
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
                              onPressed: () {},
                              // color: Colors.red[600],
                              // textColor: Colors.white,
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(25.0),
                              //   side: BorderSide(color: Colors.red[600])
                              // ),
                              child: Text('Submit'.toUpperCase(), style: TextStyle(fontSize: 20)),
                            ),
                        ),
                        SizedBox(height: 15),
                        ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () { },
                              // color: Colors.white,
                              // textColor: Colors.red[600],
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(25.0),
                              //   side: BorderSide(color: Colors.red[600])
                              // ),
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
}