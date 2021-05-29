import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  CustomFlatButton({
    this.child,
    this.icon,
    this.onPressed,
  });
  final Icon icon;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(label: child, icon: icon, onPressed: onPressed);
  }
}
