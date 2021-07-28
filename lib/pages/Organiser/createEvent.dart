import 'package:EMMA/services/databaseservice.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
class CreateEvent extends StatefulWidget {

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
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
    super.initState();
    _regDate = DateTime.now();
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (currentValue) => _eventName = currentValue,

                            // onEditingComplete: _node.nextFocus,
                            // ignore: missing_return
                            validator: (input) {
                              if(input.isEmpty){
                                return 'Please type the event name';
                              }
                            },
                            onSaved: (input) => _eventName = input,
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
                        validator: (input) {
                          if(input == null){
                                return 'Please enter start date';
                              }
                              return null;
                        },
                        onChanged: (currentValue) => _date = currentValue,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                          labelText: 'Start Date (${newformat.pattern})'
                        ),
                        format: newformat,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(Duration(days: 0)),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        }
                        // onShowPicker: (context, currentValue) {
                        //   return showDatePicker(
                        //     context: context,
                        //     firstDate: DateTime.now().subtract(Duration(days: 0)),
                        //     initialDate: currentValue ?? DateTime.now(),
                        //     lastDate: DateTime(2100)
                        //     );
                        // },
                      ),
                    ),
                        Padding(padding: const EdgeInsets.all(8.0),
                      child: DateTimeField(
                        validator: (input) {
                          if(input == null){
                                return 'Please enter end date';
                              }
                              return null;
                        },
                        onChanged: (currentValue) => {_endDate = currentValue},
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                              ),
                          labelText: 'End Date (${newformat.pattern})'
                        ),
                        format: newformat,
                        onShowPicker: (context, currentValue) async {
                          final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(Duration(days: 0)),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                          if (date != null) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );
                            return DateTimeField.combine(date, time);
                          } else {
                            return currentValue;
                          }
                        }
                        // onShowPicker: (context, currentValue) {
                        //   return showDatePicker(
                        //     context: context,
                        //     firstDate: DateTime.now().subtract(Duration(days: 0)),
                        //     initialDate: currentValue ?? DateTime.now(),
                        //     lastDate: DateTime(2100)
                        //     );
                        // },
                      ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (input) {
                              if(input.isEmpty){
                                return 'Please type the event location';
                              }
                              return null;
                            },
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (currentValue) => _picName= currentValue,
                            validator: (input) {
                              if(input.isEmpty){
                                return 'Please type the event PIC name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Person In Charge Name',
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Mobile can\'t be empty';
                                } else if (value.isNotEmpty) {
                                //bool mobileValid = RegExp(r"^(?:\+88||01)?(?:\d{10}|\d{13})$").hasMatch(value);

                                bool mobileValid =
                                RegExp(r'^(?:[+0]6)?[0-9]{10}$').hasMatch(value);
                                return mobileValid ? null : "Invalid mobile";
                                }
                                return null;
                            },
                            onChanged: (currentValue) => _contact = currentValue,
                            decoration: InputDecoration(
                              labelText: 'Person In Charge Contact Info',
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (input) {
                              if(input.isEmpty){
                                return 'Please type the event fee';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              CurrencyTextInputFormatter(
                                // locale: 'ko',
                                decimalDigits: 2,
                                symbol: 'RM ',
                              ),
                            ],
                            onChanged: (currentValue) => _eventfee = currentValue,
                            decoration: InputDecoration(
                              labelText: 'Event Fee',
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (input) {
                              if(input.isEmpty){
                                return 'Please type the event description';
                              }
                              return null;
                            },
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: DropdownButtonFormField<String>(
                                    validator: (input) {
                                     if(input.isEmpty){
                                       return 'Please choose registration';
                                     }
                                     return null;
                                   },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                    ),
                                    labelText: 'Open for registration (Yes / No)',
                                    ),
                                  isExpanded: true,
                                  value: _reg,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.red,
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  // underline: SizedBox(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _reg = newValue;
                                    });
                                  },
                                  items: <String>['Yes', 'No']
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
                        Visibility(
                          visible: _reg == 'Yes'? true : false,
                          child: Padding(padding: const EdgeInsets.all(8.0),
                          child: DateTimeField(
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
                              firstDate: DateTime.now().subtract(Duration(days: 0)),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100)
                              );
                          },
                          ),
                          ),
                        ),   
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: DropdownButtonFormField<String>(
                                  validator: (input) {
                                    if(input.isEmpty){
                                      return 'Please choose the event categories';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                    ),
                                    labelText: 'Categories',
                                    ),
                                  isExpanded: true,
                                  value: _label,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.red,
                                  ),
                                  iconSize: 30,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  // underline: SizedBox(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      _label = newValue;
                                    });
                                  },
                                  items: <String>[
                                    "conferences",
                                    "seminar",
                                    "workshops",
                                    "expo",
                                    "award",
                                    "festival",
                                    "leadership",
                                    "creative",
                                    "cooking",
                                    "foreign language",
                                    "art",
                                    "robotic",
                                    "religious",
                                    "self improvement",
                                    "sport",
                                    "volunteers"
                                  ]
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
                          
                        SizedBox(height: 20),
                        ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {onSubmit();
                              },
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
                        SizedBox(height: 10),
                        ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () { Navigator.of(context).pop();},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(380, 40)
                              ),
                              child: Text('Cancel'.toUpperCase(), style: TextStyle(color: Colors.red[600],fontSize: 20)),
                            ),
                        ),
                        SizedBox(height: 15),
                      ])
              ),
            ),),
        ),
      )
    );
  }
  Future <void> onSubmit() async {
  final formState = _formKey.currentState;
  if (formState.validate()) {
    formState.save();
    DatabaseService().addEvent(_eventName,_date, _endDate, _location,_eventfee,_description,_label,_reg,_regDate,_picName,_contact);
    Navigator.of(context).pop();
  }
  
}

}