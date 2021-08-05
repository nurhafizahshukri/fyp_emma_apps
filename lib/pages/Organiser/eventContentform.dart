import 'dart:io';
import 'dart:typed_data';
import 'package:EMMA/services/databaseservice.dart';
import 'package:EMMA/services/pdf_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// ignore: must_be_immutable
class EventContentForm extends StatefulWidget {
  DateTime date;
  DateTime endDate;
  String eventName;
  String location;
  String eventfee;
  String uid;

  Uint8List _imageUrl1;
  Uint8List _imageUrl2;
  Uint8List _imageUrl3;
  Uint8List _imageUrl4;
  Uint8List _imageUrl5;
  Uint8List _imageUrl6;
  Uint8List _imageUrl7;
  Uint8List _imageUrl8;

  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;
  File _imageFile5;
  File _imageFile6;
  File _imageFile7;
  File _imageFile8;

  EventContentForm(
      this.date,
      this.endDate,
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
      this._imageUrl8,
      this._imageFile1,
      this._imageFile2,
      this._imageFile3,
      this._imageFile4,
      this._imageFile5,
      this._imageFile6,
      this._imageFile7,
      this._imageFile8
      );
  @override
  _EventContentFormState createState() => _EventContentFormState();
}

class _EventContentFormState extends State<EventContentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final newformat = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("HH:mm");
  DateTime _date;
  DateTime _endDate;
  String _eventName;
  String _location;
  String _eventfee;
  String _paragraph;

  final FocusScopeNode _node = FocusScopeNode();

  final eventController = TextEditingController();
  final TextEditingController dateController = new TextEditingController();
  final TextEditingController endDateController = new TextEditingController();
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
  // ignore: must_call_super
  void initState() {
    dateController.text =
        "${widget.date.year.toString()}-${widget.date.month.toString()}-${widget.date.day.toString()}";
    endDateController.text =
        "${widget.endDate.year.toString()}-${widget.endDate.month.toString()}-${widget.endDate.day.toString()}";
    eventNameController.text = widget.eventName;
    locationController.text = widget.location;
    eventfeeController.text = widget.eventfee;
    paragrapthController.text =
        "${widget.eventName} telah diadakan pada ${widget.date.day.toString()} Hari bulan ${widget.date.month.toString()} Tahun ${widget.date.year.toString()} bermula jam  ${widget.date.hour} anjuran < > dengan kerjasama <> di hadiri <> orang perserta";
    _date = widget.date;
    _endDate = widget.endDate;
    _eventName = widget.eventName;
    _location = widget.location;
    _eventfee = widget.eventfee;
    _paragraph = paragrapthController.text;
  }

  @override
  Widget build(BuildContext context) {
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
                              controller: endDateController,
                              style: TextStyle(color: Colors.grey),
                              onChanged: (currentValue) => _endDate = currentValue,
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
                                    _paragraph = currentValue,
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
                                onSubmit(); int count = 2;
                                  Navigator.of(context).popUntil((_) => count-- <= 0);
                              },
                              style: ElevatedButton.styleFrom(
                              primary: Colors.red[600],
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              side: BorderSide(color: Colors.red[600]),
                              fixedSize: Size(180, 40)
                              ),
                              child: Text('Generate'.toUpperCase(),
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          SizedBox(height: 15),
                          ButtonTheme(
                            minWidth: 338.0,
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () async {
                                onSave();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Report Saved"),
                                ));
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
                              child: Text('Save'.toUpperCase(),
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
                                    _endDate,
                                    _eventName,
                                    _location,
                                    _eventfee,
                                    _paragraph,
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

  Future <void> onSave() async {
  final formState = _formKey.currentState;
  
    formState.save();
    DatabaseService().addReport(
      _paragraph,
      widget._imageFile1,
      widget._imageFile2,
      widget._imageFile3,
      widget._imageFile4,
      widget._imageFile5,
      widget._imageFile6,
      widget._imageFile7,
      widget._imageFile8,
     widget.uid);
  }

  
}