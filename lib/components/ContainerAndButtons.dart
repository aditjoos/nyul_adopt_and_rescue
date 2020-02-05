import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  MyContainer({this.child, this.color});

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
            offset: Offset(0.0, 2.0),
            blurRadius: 10.0,
            spreadRadius: 1.0
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: color == null ? Colors.white : color,
      ),
      child: child,
    );
  }
}