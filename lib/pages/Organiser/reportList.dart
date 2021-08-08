import 'package:EMMA/services/databaseservice.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class ReportList extends StatefulWidget {
  String uid;
  String content;
  List<String> logoImage;
  List<String> eventImage;
  DateTime date;
  DateTime endDate;
  String eventName;
  String location;
  String eventfee;
  String reportId;

  ReportList(this.uid, this.content, this.logoImage, this.eventImage, this.date, this.endDate, this.eventName, this.location, this.eventfee, this.reportId);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Report List'),
          backgroundColor: Colors.red[700],
        ),
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 8, 8),
                    child: Text(
                      "Logo Images",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LogoImages(images: widget.logoImage[0]),
                        LogoImages(images: widget.logoImage[1]),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LogoImages(images: widget.logoImage[2]),
                        LogoImages(images: widget.logoImage[3]),
                        LogoImages(images: widget.logoImage[4]),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 8, 8),
                    child: Text(
                      "Content",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                  ),
                ),
                Card(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Flexible(
                      child: Text(
                        widget.content,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          ),))
                      
                    ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 8, 12),
                    child: Text(
                      "Event Images",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 1,),
                  items: widget.eventImage.map((item) => Container(
                    child: Center(
                      child: Image.network(
                        item, 
                        fit: BoxFit.cover,
                        height: 200, 
                        width: 400,
                        loadingBuilder: (BuildContext context,
                                Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                              .expectedTotalBytes !=
                                          null
                                      ? loadingProgress
                                              .cumulativeBytesLoaded /
                                          loadingProgress
                                              .expectedTotalBytes
                                      : null,
                                ),
                              );
                            },)
                    ),
                  )).toList(),
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _promptRemoveReport(),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: Colors.red[600],
            onPrimary: Colors.red,
            side: BorderSide(color: Colors.red[600]),
          ), 
          child: Icon(Icons.delete_outline, color: Colors.white, size: 35,),
      )
            
      )
    );
  }
  void _promptRemoveReport() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Delete this report?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new TextButton(
            child: new Text('DELETE'),
            onPressed: () {
              DatabaseService().deleteReport(widget.uid, widget.reportId);
              int count = 2;
              Navigator.of(context).popUntil((_) => count-- <= 0);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Report has been deleted"),
              ));
            }
          )
        ]
      );
    }
  );
}
}
class LogoImages extends StatelessWidget {
  final String images;

  LogoImages({@required this.images});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      images,
      loadingBuilder: (BuildContext context,
          Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress
                        .expectedTotalBytes !=
                    null
                ? loadingProgress
                        .cumulativeBytesLoaded /
                    loadingProgress
                        .expectedTotalBytes
                : null,
          ),
        );
      },
      height: 100,
      width: 100,
      fit: BoxFit.contain,
    );
  }
}