//Caution: Only works on Android & iOS platforms
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:EMMA/Pages/Organiser/eventDetails.dart';
import 'package:EMMA/Pages/Organiser/eventdetailsform.dart';

//void main() => runApp(MyApp());

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);

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
  String _imageUrl1;
  String _imageUrl2;
  String _imageUrl3;
  String _imageUrl4;
  String _imageUrl5;
  String _imageUrl6;
  String _imageUrl7;
  String _imageUrl8;
  bool isload = false;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  Future pickImage(File _imageFile) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (_imageFile == _imageFile1)
        _imageFile1 = File(pickedFile.path);
      else if (_imageFile == _imageFile2)
        _imageFile2 = File(pickedFile.path);
      else if (_imageFile == _imageFile3)
        _imageFile3 = File(pickedFile.path);
      else if (_imageFile == _imageFile4)
        _imageFile4 = File(pickedFile.path);
      else if (_imageFile == _imageFile5)
        _imageFile5 = File(pickedFile.path);
      else if (_imageFile == _imageFile6)
        _imageFile6 = File(pickedFile.path);
      else if (_imageFile == _imageFile7)
        _imageFile7 = File(pickedFile.path);
      else if (_imageFile == _imageFile8) _imageFile8 = File(pickedFile.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context, File _imageFile) async {
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => {
            print(value),
            if (_imageFile == _imageFile1)
              {_imageUrl1 = value, print("image URL 1 : $_imageUrl1")}
            else if (_imageFile == _imageFile2)
              {_imageUrl2 = value, print("image URL 2 : $_imageFile2")}
            else if (_imageFile == _imageFile3)
              {_imageUrl3 = value, print("image URL 3 : $_imageUrl3")}
            else if (_imageFile == _imageFile4)
              {_imageUrl4 = value, print("image URL 4 : $_imageFile4")}
            else if (_imageFile == _imageFile5)
              {_imageUrl5 = value, print("image URL 5 : $_imageFile5")}
            else if (_imageFile == _imageFile6)
              {_imageUrl6 = value, print("image URL 6 : $_imageFile6")}
            else if (_imageFile == _imageFile7)
              {_imageUrl7 = value, print("image URL 7 : $_imageFile7")}
            else if (_imageFile == _imageFile8)
              {_imageUrl8 = value, print("image URL 8 : $_imageUrl8")}
          },
        );
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
                                    : FlatButton(
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
                                    : FlatButton(
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
                                    : FlatButton(
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
                                  : FlatButton(
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
                                  : FlatButton(
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
                                  : FlatButton(
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
                                  : FlatButton(
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
                                  : FlatButton(
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
            child: FlatButton(
              onPressed: () => isload
                  ? {
                      uploadImageToFirebase(context, _imageFile6),
                      uploadImageToFirebase(context, _imageFile7),
                      uploadImageToFirebase(context, _imageFile8),
                      setState(() {
                        print("$_imageFile6");
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
                                    _imageUrl1,
                                    _imageUrl2,
                                    _imageUrl3,
                                    _imageUrl4,
                                    _imageUrl5,
                                    _imageUrl6,
                                    _imageUrl7,
                                    _imageUrl8)));
                      })
                    }
                  : {
                      uploadImageToFirebase(context, _imageFile1),
                      uploadImageToFirebase(context, _imageFile2),
                      uploadImageToFirebase(context, _imageFile3),
                      uploadImageToFirebase(context, _imageFile4),
                      uploadImageToFirebase(context, _imageFile5),
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
