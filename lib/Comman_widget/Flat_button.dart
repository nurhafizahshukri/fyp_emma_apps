import 'package:EMMA/Comman_widget/Custom_FlatButton.dart';
import 'package:flutter/material.dart';

class Flatbutton extends CustomFlatButton {
  Flatbutton({
    @required Color colortext,
@required Icon icon,
    @required String text,
    double fontsize=20,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: colortext, fontSize: fontsize),
          ),
          icon: icon,
          onPressed: onPressed,
        );
}
