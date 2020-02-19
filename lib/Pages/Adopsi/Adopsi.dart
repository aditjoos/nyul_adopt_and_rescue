import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AdopsiPage extends StatefulWidget {
  @override
  _AdopsiPageState createState() => _AdopsiPageState();
}

class _AdopsiPageState extends State<AdopsiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.orange[300],
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(LineIcons.arrow_left, color: Colors.white,),
                          onPressed: () => Navigator.pop(context),
                          splashColor: Colors.black26,
                          focusColor: Colors.black38,
                          highlightColor: Colors.black12,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              // width: MediaQuery.of(context).size.width - 100,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Cari ', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Icon(LineIcons.search)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text('1169 unggahan', style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   child: Container(
          //     child: SingleChildScrollView(
          //       //
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}