import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {
  MyIconButton({
    @required this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.color,
    this.shadowColorTopLeft,
    this.shadowColorBottomRight,
  });

  final VoidCallback onPressed;
  final String text;
  final Icon icon;
  final Color backgroundColor;
  final Color color;
  final Color shadowColorTopLeft;
  final Color shadowColorBottomRight;

  @override
  _MyIconButtonState createState() => _MyIconButtonState();
}

class _MyIconButtonState extends State<MyIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: widget.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: widget.shadowColorTopLeft,
              offset: Offset(-3.0, -3.0),
              blurRadius: 15.0,
              spreadRadius: 1
            ),
            BoxShadow(
              color: widget.shadowColorBottomRight,
              offset: Offset(3.0, 3.0),
              blurRadius: 15.0,
              spreadRadius: 1
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.text, style: TextStyle(color: widget.color, fontWeight: FontWeight.bold),),
              widget.icon
            ],
          )
        ),
      ),
    );
  }
}