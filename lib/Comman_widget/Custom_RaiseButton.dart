import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.borderRadius: 50.0,
    this.height: 50.0,
    this.onPressed,
  }) : assert(borderRadius != null);
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return 
OutlinedButton(
        style: OutlinedButton.styleFrom(
            elevation: 6,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        child: child,
        onPressed: onPressed,
);

  }
}