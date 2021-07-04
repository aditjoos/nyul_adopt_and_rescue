import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/LoginPage.dart';
import 'package:petz_invention_udayana/MainPage.dart';
import 'package:petz_invention_udayana/components/Buttons.dart';
// import 'package:petz_invention_udayana/sqlite/helper.dart';
// import 'package:petz_invention_udayana/sqlite/model.dart';

import 'components/Dialogs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final int isUserLogin = 1;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark
    ));

    return MaterialApp(
      title: 'nyuL',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: isUserLogin == 0 ? GreetingPage() : isUserLogin == 1 ? LoginPage() : MainPage(),
    );
  }
}

// TODO : greeting dulu lalu ke login page
class GreetingPage extends StatefulWidget {
  @override
  _GreetingPageState createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('this is for greeting page'),
        ),        
      ),
    );
  }
}
