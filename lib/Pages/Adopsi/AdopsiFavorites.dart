import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nyul_adopt_rescue/components/ContainerAndButtons.dart';

class AdopsiFavoritesPage extends StatefulWidget {
  @override
  _AdopsiFavoritesPageState createState() => _AdopsiFavoritesPageState();
}

class _AdopsiFavoritesPageState extends State<AdopsiFavoritesPage> {

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
                          icon: Icon(LineIcons.arrowLeft, color: Colors.white,),
                          onPressed: () => Navigator.pop(context),
                          splashColor: Colors.black26,
                          focusColor: Colors.black38,
                          highlightColor: Colors.black12,
                        ),
                        Text('Kembali', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                  Center(child: Text('Favorites', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),),
                  SizedBox(height: 15.0,),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MyContainer(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        child: Text('hi'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0,),
        ],
      ),
    );
  }
}