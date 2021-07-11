import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SendInvitation extends StatefulWidget {
  // const SendInvitation({ Key? key }) : super(key: key);
  DateTime date = DateTime.now();
  DateTime time = DateTime.now();
  String eventName;
  String location;
  String uid;

  SendInvitation(
   this.date,
   this.time,
   this.eventName,
   this.location,
   this.uid);

  @override
  _SendInvitationState createState() => _SendInvitationState();
}

class _SendInvitationState extends State<SendInvitation> {
  String _body;
  String _recipient;
  String _subject;
  final invitationController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    invitationController.dispose();
    super.dispose();
  }

  @override
  void initState() { 
    _recipientController.text = 'example@gmail.com';
    _subjectController.text = 'Invitation to ${widget.eventName}';
    _bodyController.text = 'Greetings, <invitee name>. \n\nYou are invited to our event called ${widget.eventName}.'+ 
                            ' ${widget.eventName} will be conducted on ${widget.date.day.toString()}-${widget.date.month.toString()}-${widget.date.year.toString()} at ${widget.location}';
    _body = _bodyController.text;
    _recipient = _recipientController.text;
    _subject = _subjectController.text;
  }

  Future<void> sendMail() async {
    String username =' utmemma@gmail.com';
    String password = 'emmafyp123';

    final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  

  // Create our message.
  final message = Message()
    ..from = Address(username, 'EMMA Invitation')
    ..recipients.add(_recipient)
    // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
    // ..bccRecipients.add(Address('bccAddress@example.com'))
    ..subject = _subject
    ..text = _body;

  try {
    final sendReport = await send(message, smtpServer);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Sending Message"),
    ));
    Navigator.of(context).pop();
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Invitation'),
        backgroundColor: Colors.red[700],
        ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _recipientController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Recipient',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  onChanged: (currentValue) => _body = currentValue,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
                child:  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[600],
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    side: BorderSide(color: Colors.red[600]),
                    fixedSize: Size(380, 40)
                  ),
                  child:Text('Send Email') ,
                  onPressed: sendMail ),
            ),
          ],
        ),
      ),
    );
  }
}