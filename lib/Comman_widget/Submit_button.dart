import 'package:flutter/material.dart';
import 'package:EMMA/Comman_widget/Custom_RaiseButton.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    @required Color color,
    @required Color colortext,
  
    @required String text,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: colortext, fontSize: 20.0),
          ),
          height: 44.0,
          color: color,
          borderRadius: 4.0,
          onPressed: onPressed,
        );
}
