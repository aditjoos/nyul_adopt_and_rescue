import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
              Text('PETZ', style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold
              ),),
              Text('Solusi hidup anda.', style: TextStyle(
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 15.0,),
              TextField(
                controller: controllerUsername,
                // initialValue: snapshot.hasData ? dbModel[0].user : "",
                obscureText: false,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Username",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 15.0,),
              TextField(
                controller: controllerPassword,
                obscureText: true,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Password",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.teal[300],
                  ),
                  width: 100.0,
                  height: 45.0,
                  child: Center(child: Text('Masuk', style: TextStyle(color: Colors.white),)),
                ),
              ),
              SizedBox(height: 15.0,),
              Text('atau'),
              SizedBox(height: 15.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue[800],
                      ),
                      width: 100.0,
                      height: 45.0,
                      child: Center(child: Text('Facebook', style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                  SizedBox(width: 15.0,),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red[600],
                      ),
                      width: 100.0,
                      height: 45.0,
                      child: Center(child: Text('Google', style: TextStyle(color: Colors.white),)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Lupa kata sandi?'),
                  Text('Buat akun baru'),
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
