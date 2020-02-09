import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:petz_invention_udayana/Pages/Home.dart';
import 'package:petz_invention_udayana/components/Buttons.dart';

import 'components/Dialogs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark
    ));

    return MaterialApp(
      title: 'PETZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  void myShowDialog(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => FunkyOverlay('Petz!', [
        FlatButton(
          color: Colors.indigo[300],
          child: Text('OK'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ])
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/petz-logo.png', width: MediaQuery.of(context).size.width/2,),
              SizedBox(height: 15.0,),
              TextField(
                controller: controllerUsername,
                // initialValue: snapshot.hasData ? dbModel[0].user : "",
                obscureText: false,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    hintText: "Username",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 15.0,),
              TextField(
                controller: controllerPassword,
                obscureText: true,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    hintText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Lupa password? ', style: TextStyle(color: Colors.black54,)),
                  GestureDetector(
                    onTap: (){},
                    child: Text('Dapatkan bantuan. ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[400],)),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              MyIconButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage())),
                backgroundColor: Color(0xFFff971d),
                color: Colors.white,
                shadowColorTopLeft: Color(0xFFffffff),
                shadowColorBottomRight: Color(0xFFa3b1c6),
                text: 'Masuk',
                icon: Icon(LineIcons.paper_plane, color: Colors.white,),
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black54,
                      height: 1.0,
                      thickness: 1.0,
                    ),
                  ),
                  Text(' atau ', style: TextStyle(color: Colors.black54,)),
                  Expanded(
                    child: Divider(
                      color: Colors.black54,
                      height: 1.0,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MyIconButton(
                    onPressed: () => showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Hi', [FlatButton(onPressed: (){}, child: Text('OK'))])),
                    backgroundColor: Colors.blue[800],
                    color: Colors.white,
                    shadowColorTopLeft: Color(0xFFffffff),
                    shadowColorBottomRight: Color(0xFFa3b1c6),
                    text: 'Facebook',
                    icon: Icon(LineIcons.facebook, color: Colors.white,),
                  ),
                  SizedBox(width: 15.0,),
                  MyIconButton(
                    onPressed: () => showDialog(barrierDismissible: true, context: context, builder: (_) => FunkyOverlay('Hi', [FlatButton(onPressed: (){}, child: Text('OK'))])),
                    backgroundColor: Colors.red[600],
                    color: Colors.white,
                    shadowColorTopLeft: Color(0xFFffffff),
                    shadowColorBottomRight: Color(0xFFa3b1c6),
                    text: 'Google',
                    icon: Icon(LineIcons.google, color: Colors.white,),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Lupa kata sandi?', style: TextStyle(color: Colors.black54,)),
                  Text('Buat akun baru', style: TextStyle(color: Colors.black54,)),
                ],
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => myShowDialog(),
      //   tooltip: 'Dialog',
      //   child: Icon(Icons.send),
      // ),
    );
  }
}
