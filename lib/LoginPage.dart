import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:http/http.dart' as http;
import 'package:petz_invention_udayana/MainPage.dart';
import 'package:petz_invention_udayana/components/Buttons.dart';
import 'package:petz_invention_udayana/components/Dialogs.dart';
import 'package:petz_invention_udayana/sqlite/helper.dart';
import 'package:petz_invention_udayana/sqlite/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var db = new DatabaseHelper();

  static String usernameText;
  static String passwordText;
  static int isWelcomeText;

  TextEditingController controllerUsername;
  TextEditingController controllerPassword;

  void myShowDialog(String text){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => FunkyOverlay(text, [
        FlatButton(
          child: Text('OK'),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ])
    );
  }

  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('internet connected');
      }
    } on SocketException catch (_) {
      print('internet not connected');
    }
  }

  Future checkUserBaru() async{
    await db.checkUser();
  }

  void getUsername() async{
    List resultArray = await db.getUser();
    usernameText = resultArray[1];
    passwordText = resultArray[2];
    isWelcomeText = resultArray[3];

    setState(() {
      controllerUsername = TextEditingController(text: usernameText);
      controllerPassword = TextEditingController(text: passwordText);
    });
    // print(usernameText);
  }

  Future checkLogin() async{
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => FunkyLoading(),
    );

    String usernameInput = controllerUsername.text;
    String passwordInput = controllerPassword.text;

    String url = 'http://nyul.kumpulan-soal.com/index.php/member_login?username='+usernameInput+'&password='+passwordInput;
    var result = await http.get(Uri.encodeFull(url), headers: { 'accept':'application/json' });
    var content = json.decode(result.body);

    if (result.statusCode == 200){
      if (content['result'] == true){
        var data = content['data'];

        bool id = data[0]['id'] == null ? false : true;
        bool username = data[0]['username'] == null ? false : true;
        bool password = data[0]['password'] == null ? false : true;

        if(id && username && password){
          Navigator.pop(context);

          updateUserLoginCredential(usernameInput, passwordInput);

          Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
        }else{
          Navigator.pop(context);
          myShowDialog('Username atau Passwordmu salah, periksa kembali.');
        }
      }else if (content['result'] == false){
        Navigator.pop(context);
        myShowDialog('Username atau Passwordmu salah, periksa kembali.');
      }
    }else{
      Navigator.pop(context);
      myShowDialog('Username atau Passwordmu salah, periksa kembali.\n\n ' + content['result'].toString() +', '+ result.statusCode.toString());
    }
  }

  Future updateUserLoginCredential(String username, String password) async {
    var dbModel = new DatabaseModel(1, username, password, isWelcomeText);
    await db.updateUser(dbModel);
  }

  @override
  void initState() {
    super.initState();
    checkConnection();

    checkUserBaru();
    getUsername();
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
              Image.asset('assets/logo/app.png', width: MediaQuery.of(context).size.width/2,),
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
                onPressed: (){
                  checkLogin();
                },
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
    );
  }
}