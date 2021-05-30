import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Tables {
  final String name;
  final  content;

  const Tables({ this.name, this.content});
}

class PdfApi {
    DateTime date;
  DateTime time;
  String eventName;
  String location;
  String eventfee;
  String uid;
  String paragraph;
  String _imageUrl1;
  String _imageUrl2;
  String _imageUrl3;
  String _imageUrl4;
  String _imageUrl5;
  String _imageUrl6;
  String _imageUrl7;
  String _imageUrl8;

  PdfApi(
      this.date,
      this.time,
      this.eventName,
      this.location,
      this.eventfee,);  
  static Future<File> generateTable(DateTime date,
      DateTime time,
      String location,
      String eventfee,) async {
    final pdf = Document();

    final headers = ['Name', 'Age'];

    final Tabless = [
      Tables(name: 'Privacy', content: "Public"),
      Tables(name: 'Date ', content: "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}"),
      Tables(name: 'Time', content: "${time.hour.toString()}:${time.minute.toString()} "),
      Tables(name: 'Location', content: "${location}"),
            Tables(name: 'Location', content: "${eventfee}"),

      ];
    final data = Tabless.map((Tables) => [Tables.name, Tables.content]).toList();

    pdf.addPage(Page(
      build: (context) => Table.fromTextArray(
        headers: headers,
        data: data,
      ),
    ));

    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  static Future<File> generateImage(DateTime date,
  DateTime time,
  String eventName,
  String location,
  String eventfee,
  String paragraph,
  String _imageUrl1,
  String _imageUrl2,
  String _imageUrl3,
  String _imageUrl4,
  String _imageUrl5,
  String _imageUrl6,
  String _imageUrl7,
  String _imageUrl8) async {
    final pdf = Document();
Uint8List bytes = (await NetworkAssetBundle(Uri.parse("${_imageUrl1}")).load("${_imageUrl1}"))
    .buffer
    .asUint8List();
Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse("${_imageUrl2}")).load("${_imageUrl2}"))
    .buffer
    .asUint8List();

Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse("${_imageUrl3}")).load("${_imageUrl3}"))
    .buffer
    .asUint8List();

Uint8List bytes3 = (await NetworkAssetBundle(Uri.parse("${_imageUrl4}")).load("${_imageUrl4}"))
    .buffer
    .asUint8List();

Uint8List bytes4 = (await NetworkAssetBundle(Uri.parse("${_imageUrl5}")).load("${_imageUrl5}"))
    .buffer
    .asUint8List();

Uint8List bytes5 = (await NetworkAssetBundle(Uri.parse("${_imageUrl6}")).load("${_imageUrl6}"))
    .buffer
    .asUint8List();

Uint8List bytes6 = (await NetworkAssetBundle(Uri.parse("${_imageUrl7}")).load("${_imageUrl7}"))
    .buffer
    .asUint8List();

Uint8List bytes7 = (await NetworkAssetBundle(Uri.parse("${_imageUrl8}")).load("${_imageUrl8}"))
    .buffer
    .asUint8List();

    final pageTheme = PageTheme(
      pageFormat: PdfPageFormat.a4,
      
    );
final headers = ['Name', 'Age'];

   
    final Tabless = [
      Tables(name: 'Privacy', content: "Public"),
      Tables(name: 'Date ', content: "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}"),
      Tables(name: 'Time', content: "${time.hour.toString()}:${time.minute.toString()} "),
      Tables(name: 'Vanue', content: "${location}"),
      Tables(name: 'Price', content: "${eventfee}"),

      ];
    final data = Tabless.map((Tables) => [Tables.name, Tables.content]).toList();
    pdf.addPage(
      MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
          GridView(
            padding: EdgeInsets.zero,
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.3,
            children: [
              Image(MemoryImage(bytes)),
              Image(MemoryImage(bytes1))
              
            ],

          ),
          GridView(
            padding: EdgeInsets.zero,
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.5,
            children: [
            Image(MemoryImage(bytes2)),
              Image(MemoryImage(bytes3)),
                 Image(MemoryImage(bytes4)),
              
            ],
            

          ),
          
          Center(child:Paragraph(
            textAlign: TextAlign.left,
            text:
                '${eventName}',
            style: TextStyle( fontSize: 20,fontBold: Font.helveticaBold() ,fontWeight:FontWeight.bold ),
          ), ),
        
Table.fromTextArray(
          
          headerAlignment: Alignment.centerLeft,
          cellAlignment: Alignment.centerLeft,
          
          
          cellHeight: 30,
         tableWidth: TableWidth.max,
        data: data,

      ),
                SizedBox(height:60),

               Image(MemoryImage(bytes5)),

          SizedBox(height:30),

        Paragraph(
            textAlign: TextAlign.center,
            text:
                '${paragraph}',
            style: TextStyle( fontSize: 12,fontBold: Font.helveticaBold() , ),
          ),

               Image(MemoryImage(bytes6)),

              Image(MemoryImage(bytes7)),
              
        ],
      ),
    );

    return saveDocument(name: '${eventName}.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
     String name,
     Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
