import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  // final List<String> Function(List<String>) setList;
   
  List<String> Function(List<String>) setList;

   EmailInput(this.setList);

  // const EmailInput({Key key, this.setList, this.hint, this.parentEmails}) : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  TextEditingController _emailController;
  String lastValue = '';
  List<String> emails = [];
  FocusNode focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailController.text = 'example@gmail.com';

    focus.addListener(() {
      if (!focus.hasFocus) {
        updateEmails();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              minWidth: 0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: <Widget>[
                  ...emails
                      .map(
                        (email) => Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Text(
                              email.substring(0, 1),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          labelPadding: EdgeInsets.all(8),
                          backgroundColor: Colors.red[600],
                          label: Text(
                            email,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onDeleted: () => {
                            setState(() {
                              emails.removeWhere((element) => email == element);
                            })
                          },
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
          TextField(
            decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Recipient',
                  ),
            keyboardType: TextInputType.emailAddress,
            // decoration: InputDecoration.collapsed(hintText: widget.hint),
            controller: _emailController,
            focusNode: focus,
            onChanged: (String val) {
              setState(() {
                if (val != lastValue) {
                  lastValue = val;
                  if (val.endsWith(' ') && validateEmail(val.trim())) {
                    if (!emails.contains(val.trim())) {
                      emails.add(val.trim());
                      widget.setList(emails);
                    }
                    _emailController.clear();
                  } else if (val.endsWith(' ') && !validateEmail(val.trim())) {
                    _emailController.clear();
                  }
                }
              });
            },
            onEditingComplete: () {
              updateEmails();
            },
          )
        ],
      ),
    ));
  }

  updateEmails() {
    setState(() {
      if (validateEmail(_emailController.text)) {
        if (!emails.contains(_emailController.text)) {
          emails.add(_emailController.text.trim());
          widget.setList(emails);
        }
        _emailController.clear();
      } else if (!validateEmail(_emailController.text)) {
        _emailController.clear();
      }
    });
  }

  setEmails(List<String> emails) {
    this.emails = emails;
  }
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(value);
}