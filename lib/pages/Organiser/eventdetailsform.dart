import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:EMMA/services/databaseservice.dart';
import 'package:EMMA/services/pdf_services.dart';

class EvenntDetailsForm extends StatefulWidget {
  DateTime date;
  DateTime time;
  String eventName;
  String location;
  String eventfee;
  String uid;

  String _imageUrl1;
  String _imageUrl2;
  String _imageUrl3;
  String _imageUrl4;
  String _imageUrl5;
  String _imageUrl6;
  String _imageUrl7;
  String _imageUrl8;

  EvenntDetailsForm(
      this.date,
      this.time,
      this.eventName,
      this.location,
      this.eventfee,
      this.uid,
      this._imageUrl1,
      this._imageUrl2,
      this._imageUrl3,
      this._imageUrl4,
      this._imageUrl5,
      this._imageUrl6,
      this._imageUrl7,
      this._imageUrl8);
  @override
  _EvenntDetailsFormState createState() => _EvenntDetailsFormState();
}

class _EvenntDetailsFormState extends State<EvenntDetailsForm> {
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
  String _paragrapth;

  final FocusScopeNode _node = FocusScopeNode();

  final eventController = TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController timeController = new TextEditingController();
  final TextEditingController eventNameController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController eventfeeController = new TextEditingController();
  final TextEditingController paragrapthController =
      new TextEditingController();

  @override
  void dispose() {
    eventController.dispose();
    _node.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dateController.text =
        "${widget.date.year.toString()}-${widget.date.month.toString()}-${widget.date.day.toString()}";
    timeController.text =
        "${widget.time.hour.toString()}:${widget.time.minute.toString()} ";
    eventNameController.text = widget.eventName;
    locationController.text = widget.location;
    eventfeeController.text = widget.eventfee;
    paragrapthController.text =
        "${widget.eventName} telah diadakan pada ${widget.date.day.toString()} Hari bulan ${widget.date.month.toString()} Tahun ${widget.date.year.toString()} bermula jam  ${timeController.text} anjuran < > dengan kerjasama <> di hadiri <> orang perserta";
    _date = widget.date;
    _time = widget.time;
    _eventName = widget.eventName;
    _location = widget.location;
    _eventfee = widget.eventfee;
    _paragrapth = paragrapthController.text;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
        appBar: AppBar(
          title: Text('Generate Report'),
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
                                style: TextStyle(color: Colors.grey),
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
                              style: TextStyle(color: Colors.grey),
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
                              style: TextStyle(color: Colors.grey),
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
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: locationController,
                                style: TextStyle(color: Colors.grey),
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
                                style: TextStyle(color: Colors.black),
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
                                maxLength: null,
                                maxLines: 20,
                                controller: paragrapthController,
                                onChanged: (currentValue) =>
                                    _paragrapth = currentValue,
                                decoration: InputDecoration(
                                    labelText: 'Content',
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
                              onPressed: () async {
                                onSubmit();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[600],
                                shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                side: BorderSide(color: Colors.red[600]),
                                fixedSize: Size(280, 40)
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
                                fixedSize: Size(280, 40)
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

final pdfFile = await PdfApi.generateImage( _date,
                                    _time,
                                    _eventName,
                                    _location,
                                    _eventfee,
                                    _paragrapth,
                                    widget._imageUrl1,
                                    widget._imageUrl2,
                                     widget._imageUrl3,
                                     widget._imageUrl4,
                                     widget._imageUrl5,
                                     widget._imageUrl6,
                                     widget._imageUrl7,
                                     widget._imageUrl8);

                    PdfApi.openFile(pdfFile);
  }
}
