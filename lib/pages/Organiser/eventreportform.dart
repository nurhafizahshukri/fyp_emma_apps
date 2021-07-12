import 'dart:io';
import 'dart:typed_data';

import 'package:EMMA/pages/Organiser/eventdetailsform.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//void main() => runApp(MyApp());

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

// ignore: must_be_immutable
class UploadingImageToFirebaseStorage extends StatefulWidget {
  DateTime date;
  DateTime time;
  String eventName;
  String location;
  String eventfee;
  String uid;
  UploadingImageToFirebaseStorage(
    this.date,
    this.time,
    this.eventName,
    this.location,
    this.eventfee,
    this.uid,
  );

  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}
class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  File _imageFile4;
  File _imageFile5;
  File _imageFile6;
  File _imageFile7;
  File _imageFile8;
    Uint8List _uintFile1;
  Uint8List _uintFile2;
  Uint8List _uintFile3;
  Uint8List _uintFile4;
  Uint8List _uintFile5;
  Uint8List _uintFile6;
  Uint8List _uintFile7;
  Uint8List _uintFile8;
  
  bool isload = false;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage(File _imageFile) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
       if (_imageFile == _imageFile1) {
        await pickedFile.readAsBytes().then((value) => _uintFile1 = value);
      } else if (_imageFile == _imageFile2) {
        await pickedFile.readAsBytes().then((value) => _uintFile2 = value);
      } else if (_imageFile == _imageFile3) {
        await pickedFile.readAsBytes().then((value) => _uintFile3 = value);
      } else if (_imageFile == _imageFile4) {
        await pickedFile.readAsBytes().then((value) => _uintFile4 = value);
      } else if (_imageFile == _imageFile5) {
        await pickedFile.readAsBytes().then((value) => _uintFile5 = value);
      } else if (_imageFile == _imageFile6) {
        await pickedFile.readAsBytes().then((value) => _uintFile6 = value);
      } else if (_imageFile == _imageFile7) {
        await pickedFile.readAsBytes().then((value) => _uintFile7 = value);
      } else if (_imageFile == _imageFile8) {
        await pickedFile.readAsBytes().then((value) => _uintFile8 = value);
      }
       setState(()  {
      if (_imageFile == _imageFile1)
       { _imageFile1 = File(pickedFile.path);
       }else if (_imageFile == _imageFile2)
        {_imageFile2 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile3)
        {_imageFile3 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile4)
        {_imageFile4 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile5)
       { _imageFile5 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile6)
        {_imageFile6 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile7)
        {_imageFile7 = File(pickedFile.path);
              }      else if (_imageFile == _imageFile8) {_imageFile8 = File(pickedFile.path);
              }    
              });
      
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: uploadImageButton(context),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(95),
                    bottomRight: Radius.circular(0))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    width: 100,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          isload
                              ? "\nEvent pictures"
                              : "Organizer \nand Sponsor Logo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )),
                  ),
                ]),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: isload
              ? SingleChildScrollView(
                  child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: double.infinity, height: 30),
                          GestureDetector(
                            child: Container(
                              height: 170,
                              width: 250,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: _imageFile6 != null
                                    ? Image.file(_imageFile6)
                                    : ElevatedButton(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                        onPressed: () => pickImage(_imageFile6),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Container(
                              height: 170,
                              width: 250,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: _imageFile7 != null
                                    ? Image.file(_imageFile7)
                                    : ElevatedButton(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          color: Colors.red,
                                          size: 50,
                                        ),
                                        onPressed: () => pickImage(_imageFile7),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            child: Container(
                              height: 170,
                              width: 250,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  )),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: _imageFile8 != null
                                    ? Image.file(_imageFile8)
                                    : ElevatedButton(
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => pickImage(_imageFile8),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ]),
                  ),
                )
              : Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                  Widget>[
                                              SizedBox(width:double.infinity,height:30),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _imageFile1 != null
                                  ? Image.file(_imageFile1)
                                  : ElevatedButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                      onPressed: () => pickImage(_imageFile1),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 50),
                        GestureDetector(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _imageFile2 != null
                                  ? Image.file(_imageFile2)
                                  : ElevatedButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => pickImage(_imageFile2),
                                    ),
                            ),
                          ),
                        ),
                      ]),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _imageFile3 != null
                                  ? Image.file(_imageFile3)
                                  : ElevatedButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.red,
                                        size: 50,
                                      ),
                                      onPressed: () => pickImage(_imageFile3),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _imageFile4 != null
                                  ? Image.file(_imageFile4)
                                  : ElevatedButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => pickImage(_imageFile4),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                )),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: _imageFile5 != null
                                  ? Image.file(_imageFile5)
                                  : ElevatedButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => pickImage(_imageFile5),
                                    ),
                            ),
                          ),
                        ),
                      ]),
                ])),

      // Stack(
      //   children: <Widget>[
      //     Container(
      //       height: 360,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.only(
      //               bottomLeft: Radius.circular(50.0),
      //               bottomRight: Radius.circular(50.0)),
      //           gradient: LinearGradient(
      //               colors: [orange, yellow],
      //               begin: Alignment.topLeft,
      //               end: Alignment.bottomRight)),
      //     ),
      //     Container(
      //       margin: const EdgeInsets.only(top: 80),
      //       child: Column(
      //         children: <Widget>[
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Center(
      //               child: Text(
      //                 "Uploading Image to Firebase Storage",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 28,
      //                     fontStyle: FontStyle.italic),
      //               ),
      //             ),
      //           ),
      //           SizedBox(height: 20.0),
      //           Expanded(
      //             child: Stack(
      //               children: <Widget>[
      //                 Container(
      //                   height: double.infinity,
      //                   margin: const EdgeInsets.only(
      //                       left: 30.0, right: 30.0, top: 10.0),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(30.0),
      //     child: _imageFile != null
      //         ? Image.file(_imageFile)
      //         : FlatButton(
      //             child: Icon(
      //               Icons.add_a_photo,
      //               size: 50,
      //             ),
      //             onPressed: pickImage,
      //           ),
      //   ),
      // ),
      //               ],
      //             ),
      //           ),
      //           uploadImageButton(context),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30.0)),
            child: ElevatedButton(
              onPressed: () => isload
                  ? {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EvenntDetailsForm(
                                    widget.date,
                                    widget.time,
                                    widget.eventName,
                                    widget.location,
                                    widget.eventfee,
                                    widget.uid,
                                    _uintFile1,
                                    _uintFile2,
                                    _uintFile3,
                                    _uintFile4,
                                    _uintFile5,
                                    _uintFile6,
                                    _uintFile7,
                                    _uintFile8)));
                      })
                    }
                  : {
                      setState(() {
                        isload = true;
                      })
                    },
              child: Text(
                "Next",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
          
